//
//  TokenCellViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/30.
//

import Foundation
import Combine

final class TokenCellViewModel: ViewModel {
    
    // MARK: Property
    
    @Published var state: TokenCellState
    
    let timerInterval = TOTPTimer.shared.timerInterval
    var totalTime = TOTPTimer.shared.totalTime
    var subscriptions = Set<AnyCancellable>()
    var lastSecond: Int = 1
    var isMainCell: Bool
    var refreshAction: (() -> Void)?
    
    // MARK: init
    
    init(service: TokenServiceable,
         token: Token,
         isMainCell: Bool,
         refreshAction: (() -> Void)? = nil) {
        
        let timeAmount = Date()
            .timeIntervalSince1970
            .truncatingRemainder(dividingBy: totalTime) + timerInterval
        
        self.isMainCell = isMainCell
        state = TokenCellState(service: service,
                               token: token,
                               password: TOTPGenerator.generate(from: token.key ?? "") ?? "",
                               leftTime: "",
                               timeAmount: timeAmount,
                               isShownEditView: false)
        TOTPTimer.shared.start(tokenID: token.id,
                               subscriber: initTimer(key: token.key ?? ""))
        self.refreshAction = refreshAction
    }
    
    // MARK: Methods
    
    func trigger(_ input: TokenCellInput) {
        switch input {
        case .showEditView:
            TOTPTimer.shared.cancel()
            state.isShownEditView = true
        case .hideEditView:
            TOTPTimer.shared.startAll()
            state.isShownEditView = false
            refreshAction?()
        }
        
    }
    
}

extension TokenCellViewModel {
    
    func initTimer(key: String) -> ((TOTPTimer.TimerPublisher) -> Void) {
        return { [weak self] timer in
            guard let self = self else { return }
            timer.map({ (output) in
                output.timeIntervalSince1970
            })
            .map({ [weak self] (timeInterval) -> Int in
                guard let self = self else { return 0 }
                return Int(timeInterval.truncatingRemainder(dividingBy: self.totalTime))
            })
            .sink { [weak self] (seconds) in
                guard let self = self else { return }
                self.momentOfSecondsChanged(seconds: seconds, key: key)
                if self.isMainCell { self.updateTimeAmount() }
            }
            .store(in: &self.subscriptions)
        }
    }
    
    func momentOfSecondsChanged(seconds: Int, key: String) {
        if lastSecond != seconds {
            if isMainCell { leftTime = "\(30 - seconds)" }
            if seconds == 0 {
                password
                    = TOTPGenerator.generate(from: key) ?? ""
                resetTimeAmount()
            }
            lastSecond = seconds
        }
    }
    
    func resetTimeAmount() {
        timeAmount = 0
    }
    
    func updateTimeAmount() {
        timeAmount = countTimeBy30 + timerInterval
    }
    
    var countTimeBy30: Double {
        Date().timeIntervalSince1970
            .truncatingRemainder(dividingBy: totalTime)
    }
    
    var service: TokenServiceable {
        get { state.service }
        set { state.service = newValue }
    }
    
    var token: Token {
        get { state.token }
        set { state.token = newValue }
    }
    
    var isShownEditView: Bool {
        get { state.isShownEditView }
        set { state.isShownEditView = newValue }
    }
    
    var password: String {
        get { state.password }
        set { state.password = newValue }
    }
    
    var leftTime: String {
        get { state.leftTime }
        set { state.leftTime = newValue }
    }
    
    var timeAmount: Double {
        get { state.timeAmount }
        set { state.timeAmount = newValue }
    }
    
}
