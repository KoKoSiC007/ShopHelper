//
//  AppDelegate.swift
//  ShopHelper
//
//  Created by Grisha Okin on 27/03/2019.
//  Copyright © 2019 Grisha Okin. All rights reserved.
//

import UIKit
import NMAKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	let credentials = (
		appId: "0tcDInPDhVWb6ROpa5ry",
		appCode: "hdiWUWqXQa9RmLMf670r_Q",
		licenseKey: "hA9swLydtUzeENQN2Z/w00YZreymxwH2rcGF8JHaLGzWst0nxkHfbjEnMZd5Qe8HyaEcn6jmjDHmmz5MTDRSzrcpC6FFoFmFE88hZwDgnUFbDMtRQDnMROfAh4fWu2as53DnKEacjZlZgVf/074V345lip7QVXN8HAIe0+5OiGAYdnthyxZwAoGsRtxseOzTCTkgwC+3YGa4K5OtduS0YID2fo+KVbhujPyx1Ac3AOjlUCy7tRXIkUb66uZwCTWnNkzSw/4ZKFh2fyztJQG+QHKiDjjq0j28Yx4Ku8Ogc2GP20TywJBTv+mP2CwV6GQHJGz8htY8vnh1zVYhXLyc+PJaS6j7x4i3T28CfbfhxtCfbVdvKv+SUA8cLNT3u2/0eRCmsnRCMexyw/+qgXyNHKaKrC+Xb4lJJJYyePM3WZGtds61Aojece6+WXxiDMRcfmCaHOWWfIq1mqTTXubErPLjcjXGOYNMRbHvUwRl3ZwdnixhxKArhtDcqNRWI7uIA0ITmWVaOJtaG0SPXihBmGWl0A3ArM5QApSzfLSKYKd6kGyCCl6DEBzJ/rl6zwEhhsWjKhHL3hAFBoX0FHKTFtZZlVcUOXstbpxYtea1QCXt5c7Khbl3wo87vx/yx+1caTH6prs5fO93vDiBJ7NzMMhGJXzV+AlVini8FzYCX9g="
	)

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		NMAApplicationContext.set(appId: credentials.appId, appCode: credentials.appCode)
		
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

