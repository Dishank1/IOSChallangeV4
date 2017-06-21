//
//  AppDelegate.swift
//  CopiaWork
//
//  Created by Dishank Jhaveri on 19/06/17.
//  Copyright © 2017 Dishank Jhaveri. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var allCoords : [mapCoord] = []
    var cont : ViewController?
    
    /*
     * Reads the json data and converts each latitude/longitude to a CLLocation object.
     */
    func loadData() {
        do {
            if let file = Bundle.main.url(forResource: "coordinates", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [NSArray] {
                    if let swiftArray = object as Array? {
                        for items in swiftArray{
                            if let coords = items as? [Double]{
                                let latitude = coords[0]
                                let longitude = coords[1]
                                let location = CLLocation(latitude: latitude,longitude: longitude)
                                
                                let m = mapCoord(location: location)
                                allCoords.append(m)
                            }
                        }
                    }
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyCQ_Wg8acK7Vw3o76bvefw7GnAt0CtgtlE")
        
        loadData()
        cont = window?.rootViewController as? ViewController
        
        let coordList = allMapCoords()
        coordList.coordList = allCoords
        cont?.coordList = coordList
        
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

