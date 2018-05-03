//
//  AppDelegate.swift
//  All Imports
//
//  Created by Felipe Lacet on 02/05/18.
//  Copyright © 2018 Felipe Lacet. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if self.window != nil  {
            self.configureViewControllers()
            self.window?.makeKeyAndVisible()
        }
        
        DataManager.loadProducts()
        return true
    }
    
    private func configureViewControllers() {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.isTranslucent = false
        
        let feedNavigationController = UINavigationController(rootViewController: ProductListViewController())
        
        tabBarController.viewControllers = [feedNavigationController]
        self.window?.rootViewController = tabBarController
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AImportsModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

