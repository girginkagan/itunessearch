//
//  AppDelegate.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import UIKit
import Swinject
import RxCocoa
import SVProgressHUD
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator!
    static let container = Container()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.enable = true
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.3))
        SVProgressHUD.setBackgroundLayerColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))

        AppDelegate.container.registerDependencies()

        appCoordinator = AppDelegate.container.resolve(AppCoordinator.self)!
        appCoordinator.start()
        
        return true
    }

}

