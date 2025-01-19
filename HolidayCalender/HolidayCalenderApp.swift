//
//  HolidayCalenderApp.swift
//  HolidayCalender
//
//  Created by Max krupa on 12.01.25.
//

import SwiftUI

@main
struct HolidayCalenderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        dateFormatterSetup()
        AppTheme.applyNavigationBarStyle()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
