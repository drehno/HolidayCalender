//
//  HolidayCalenderApp.swift
//  HolidayCalender
//
//  Created by Max krupa on 12.01.25.
//

import SwiftUI

@main
struct HolidayCalenderApp: App {
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        dateFormatterSetup()
        AppTheme.applyNavigationBarStyle()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    handleCustomURL(url: url) }
        }
    }
    
    
    private func handleCustomURL(url: URL) {
        print("Handling custom URL: \(url)")
        
        if let query = url.query, query.hasPrefix("file="),
           let fileName = query.replacingOccurrences(of: "file=", with: "").removingPercentEncoding {
            
            print("Extracted file name: \(fileName)")
            
            // Assuming the file was shared alongside the link and stored in the app's Documents or a temp directory
            if let sharedFileURL = findSharedFile(named: fileName) {
                do {
                    let fileContent = try String(contentsOf: sharedFileURL, encoding: .utf8)
                    print("CSV file content: \(fileContent)")
                    
                    createFolderIfNeeded(folderName: "sharedCalendars")
                    saveCSVFile(content: fileContent, fileName: fileName)
                    
                    // Trigger navigation or further processing
                    // navigationManager.navigateToDetail = true
                    
                } catch {
                    print("Failed to read shared CSV file: \(error)")
                }
            } else {
                print("File not found: \(fileName)")
            }
        } else {
            print("Invalid query or file name missing")
        }
    }
    
    private func findSharedFile(named fileName: String) -> URL? {
        // Check the temporary directory or documents directory for the shared file
        let tempDir = FileManager.default.temporaryDirectory
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let possiblePaths = [
            tempDir.appendingPathComponent(fileName),
            documentDir?.appendingPathComponent(fileName)
        ]
        
        for path in possiblePaths {
            if let path = path, FileManager.default.fileExists(atPath: path.path) {
                return path
            }
        }
        
        return nil
    }
    
    private func createFolderIfNeeded(folderName: String) {
        let fileManager = FileManager.default
        if let folderURL = getFolderURL(folderName: folderName) {
            if !fileManager.fileExists(atPath: folderURL.path) {
                do {
                    try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
                    print("Created folder at: \(folderURL.path)")
                } catch {
                    print("Failed to create folder: \(error)")
                }
            }
        }
    }
    
    private func getFolderURL(folderName: String) -> URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentDirectory?.appendingPathComponent(folderName)
    }
    
    private func saveCSVFile(content: String, fileName: String) {
        if let folderURL = getFolderURL(folderName: "sharedCalendars") {
            let fileURL = folderURL.appendingPathComponent(fileName)
            do {
                try content.write(to: fileURL, atomically: true, encoding: .utf8)
                print("CSV file saved at: \(fileURL.path)")
            } catch {
                print("Failed to save CSV file: \(error)")
            }
        } else {
            print("Failed to locate sharedCalendars folder")
        }
    }
}
