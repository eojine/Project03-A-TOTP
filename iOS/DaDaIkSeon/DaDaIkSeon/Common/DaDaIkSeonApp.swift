//
//  DaDaIkSeonApp.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI

@main
struct DaDaIkSeonApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var root: DaDaIkSeonAppRootViews = .none
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        
//        #if DEBUG
//        let service = MockTokenService()
//        #else
        let service = TokenService(StorageManager(type: .token))
//        #endif
        
        WindowGroup {
            switch root {
            case .main:
                MainView(service: service)
                    .environmentObject(NavigationFlowObject())
            case .localAuth:
                if let pincode = StorageManager<String>(type: .pincode).load() {
                    PinCodeView(mode: .auth(pincode), completion: { _ in
                        root = .main
                    })
                }
            case .networkAuth:
                EmptyView()
            case .none:
                BackgroundView()
            case .login:
                LoginView(service: LoginService(), completion: {
                    DispatchQueue.main.async { root = .main }
                })
            }
        }
        .onChange(of: scenePhase, perform: { newScenePhrase in
            switch newScenePhrase {
            //case .inactive:
                //DispatchQueue.main.async { root = .none }
            case .active:
                #if DEBUG
                if StorageManager<String>(type: .JWTToken).load() == nil {
                    DispatchQueue.main.async { root = .login }
                } else {
                    print("현재 토큰 \(StorageManager<String>(type: .JWTToken).load()!)")
                    print("현재 백업 비밀번호 \(StorageManager<String>(type: .backupPassword).load())")
                    if root == .none {
                        localAuthenticate()
                    }
                }
                #else
                localAuthenticate()
                #endif
            default: break
            }
        })
    }
    
}

extension DaDaIkSeonApp {
    
    func localAuthenticate() {
        switch root {
        case .none:
            if nil != StorageManager<String>(type: .pincode).load() {
                BiometricIDAuth().authenticateUser { result in
                    if result == nil { // 생체인증 성공
                        DispatchQueue.main.async { root = .main }
                    } else {            // 생체인증 실패
                        DispatchQueue.main.async { root = .localAuth}
                    }
                }
            } else { // pincode 없으면 앱 보호 안하겠다는 것
                DispatchQueue.main.async { root = .main }
            }
        default:
            return
        }
    }
    
    enum DaDaIkSeonAppRootViews {
        case main
        case localAuth
        case networkAuth
        case none
        case login
    }

}
