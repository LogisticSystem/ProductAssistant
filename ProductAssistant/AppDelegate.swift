//
//  AppDelegate.swift
//  ProductAssistant
//
//  Created by Илья Халяпин on 01.04.2018.
//  Copyright © 2018 Ilya Khalyapin. All rights reserved.
//

import UIKit
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Публичные свойства
    
    var window: UIWindow?
    
    
    // MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
        
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60 * 60 * 24)
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
        
        // Path to Log file
        print("Log: \(fileLogger.currentLogFileInfo.filePath)")
        
        return true
    }
    
}
