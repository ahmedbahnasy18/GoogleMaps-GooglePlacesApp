//
//  AppDelegate.swift
//  GoogleMap&GooglePlacesApp
//
//  Created by Ahmed  on 1/20/18.
//  Copyright © 2018 Ahmed . All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // AIzaSyArNI5WpPUxdJsowxGN0kukny6bQZ7hqmE
        GMSServices.provideAPIKey("AIzaSyArNI5WpPUxdJsowxGN0kukny6bQZ7hqmE")
        GMSPlacesClient.provideAPIKey("AIzaSyArNI5WpPUxdJsowxGN0kukny6bQZ7hqmE")
        
        return true
    }

}

