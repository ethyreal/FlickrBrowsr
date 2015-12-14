//
//  AppDelegate.swift
//  Flickr Browsr
//
//  Created by George Webster on 12/4/15.
//  Copyright © 2015 George Webster. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var navigationController:UINavigationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let nav = UINavigationController()
        
        let layout = PhotoLayout()
        let photosVC = PhotoListViewController(collectionViewLayout:layout)
        
        nav.pushViewController(photosVC, animated: false)
        
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window.rootViewController = nav
        
        window.backgroundColor = UIColor.whiteColor()
        
        window.makeKeyAndVisible()
        
        self.navigationController = nav
        self.window = window

        return true
    }
}

