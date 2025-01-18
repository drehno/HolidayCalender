//
//  OptionsView.swift
//  HolidayCalender
//
//  Created by Max krupa on 17.01.25.
//

import SwiftUI

struct OptionsView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Button("Give Notification permission"){
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
                            if success {
                                print("Permission granted")
                            } else if let error = error {
                                print("Permission denied: \(error.localizedDescription)")
                            }
                        }
                }
                
            }
        }
    }
}

#Preview {
    OptionsView()
}
