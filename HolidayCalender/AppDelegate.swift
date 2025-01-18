import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "holidaycalendar" {
            handleCustomURL(url)
            return true
        } else if url.isFileURL {
            handleIncomingFile(url)
            return true
        }
        return false
    }
    
    private func handleCustomURL(_ url: URL) {
        // Handle custom URL logic here
        print("Custom URL received: \(url)")
    }
    
    private func handleIncomingFile(_ url: URL) {
        do {
            let fileContent = try String(contentsOf: url, encoding: .utf8)
            print("Received file content: \(fileContent)")
            // Process or display the file content in the app
        } catch {
            print("Failed to read file: \(error)")
        }
    }
}
