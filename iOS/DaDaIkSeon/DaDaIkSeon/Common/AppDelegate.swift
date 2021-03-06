//
//  AppDelegate.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/13.
//

import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        checkDeviceID()
        clearKeychainIfWillUnistall()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.set(true,
                                  forKey: "isEmailView")
    }
    
    func checkDeviceID() {
        if StorageManager<String>(type: .deviceID).load() == nil {
            let deviceID = UUID().uuidString
            _ = StorageManager<String>(type: .deviceID).store(deviceID)
            print("처음 깔았어요")
        } else {
            print("처음 깔지 않았어요 이 기기의 ID는 \(StorageManager<String>(type: .deviceID).load()!)")
        }
    }
    
    func clearKeychainIfWillUnistall() {
        let freshInstall = !UserDefaults.standard.bool(forKey: "alreadyInstalled")
        if freshInstall {
            _ = StorageManager<[Token]>(type: .token).delete()
            _ = StorageManager<String>(type: .pincode).delete()
            _ = StorageManager<String>(type: .JWTToken).delete()
            _ = StorageManager<String>(type: .backupPassword).delete()
            UserDefaults.standard.set(true, forKey: "alreadyInstalled")
        }
    }
}
