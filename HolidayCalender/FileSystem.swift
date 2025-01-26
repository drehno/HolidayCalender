//
//  Share.swift
//  HolidayCalender
//
//  Created by Torben Steegmann on 18.01.25.
//

import Foundation

func generateCSVContent(for calendar: [CalendarDay]) -> String {
    var csvContent = ""
    for entry in calendar {
        let line = "\(entry.date);\(entry.background);\(entry.quote);"
        csvContent += line
    }
    return csvContent
}

func saveCSVFile(content: String, fileName: String, folder: String = "createdCalendars") {
    let fileManager = FileManager.default
    do {
        let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let folderURL = documentsURL.appendingPathComponent(folder)
        
        let fileURL = folderURL.appendingPathComponent("\(fileName).csv")
        try content.write(to: fileURL, atomically: true, encoding: .utf8)
    } catch {
        print("Error saving file: \(error)")
    }
}


func exportCalender(calendar: [CalendarDay], folder: String = "createdCalendars") {
    let csvFormat = generateCSVContent(for: calendar)
    saveCSVFile(content: csvFormat, fileName: "HolidayCalendar", folder: folder)
}

func deleteCSVFile(fileName: String) {
    let fileManager = FileManager.default
    do {
        let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let folderURL = documentsURL.appendingPathComponent("createdCalendars")
        
        let fileURL = folderURL.appendingPathComponent("\(fileName).csv")
        
        if fileManager.fileExists(atPath: fileURL.path) {
            try fileManager.removeItem(at: fileURL)
            print("File \(fileName).csv deleted successfully.")
        } else {
            print("File does not exist.")
        }
    } catch {
        print("Error deleting file: \(error)")
    }
}



func getCalender(fileURL: URL) -> [CalendarDay] {
    var calendarDay = CalendarDay(date: Date(), background: "b1", quote: "")
    var calendar : [CalendarDay]
    calendar = []
    do {
        let fileHandle = try FileHandle(forReadingFrom: fileURL)
        
        defer { fileHandle.closeFile() }
        
        var attributeCounter = 0
        var word = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        while let data = try fileHandle.read(upToCount: 1), !data.isEmpty {
            if let char = String(data: data, encoding: .utf8)
            {
            if attributeCounter % 3 == 0 {
                if char == ";" {
                    if let date = dateFormatter.date(from: word){
                        calendarDay.date = date
                    }
                    word = ""
                    attributeCounter += 1
                    continue
                }
                word += char
            } else if attributeCounter % 3 == 1 {
                if char == ";" {
                    calendarDay.background = word
                    word = ""
                    attributeCounter += 1
                    continue
                }
                word += char
            } else if attributeCounter %  3 == 2 {
                if char == ";" {
                    calendarDay.quote = word
                    word = ""
                    calendar.append(calendarDay)
                    attributeCounter += 1
                    continue
                }
                word += char
            }
            
            }
        }
    } catch {
        print("Error reading calendar file")
    }
    
    return calendar
}

func getFolderURL(folderName: String) -> URL? {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName)
}

func createFolderIfNeeded(folderName: String) {
    guard let folderURL = getFolderURL(folderName: folderName) else { return }
    
    if !FileManager.default.fileExists(atPath: folderURL.path) {
        do {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            print("Folder created at: \(folderURL.path)")
        } catch {
            print("Failed to create folder: \(error)")
        }
    }
}

func getAllCalendarNames(folderName: String) -> [String] {
    guard let folderURL = getFolderURL(folderName: folderName) else {
        return []
    }
    do {
        let fileURLs = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
        let calendarNames = fileURLs.map { $0.deletingPathExtension().lastPathComponent }
        return calendarNames
    } catch {
        print("Failed to retrieve calendar names: \(error)")
        return []
    }
}

func getABackground(fileName: String) -> String?{
    do {
        let fileContent = try String(contentsOfFile: fileName, encoding: .utf8)
        
        // Split the content by ";"
        let parts = fileContent.split(separator: ";", maxSplits: 2, omittingEmptySubsequences: false)
        
        if parts.count > 1 {
            // Return the string between the first two semicolons
            return String(parts[1])
        } else {
            // Return nil if less than two semicolons are found
            return nil
        }
    } catch {
        print("Error reading file: \(error.localizedDescription)")
        return nil
    }
}

func getAllCalendarBackgrounds(folderName: String) -> [String] {
    guard let folderURL = getFolderURL(folderName: folderName) else {
        print("Invalid folder URL.")
        return []
    }
    
    let fileManager = FileManager.default
    var fileBackgrounds: [String] = []
    
    do {
        // Get all file paths in the folder
        let files = try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
        
        for fileURL in files {
            // Check if it's a file (not a directory)
            var isDirectory: ObjCBool = false
            if fileManager.fileExists(atPath: fileURL.path, isDirectory: &isDirectory), !isDirectory.boolValue {
                // Process the file
                if let result = getABackground(fileName: fileURL.path) {
                   // let convertedName = convertBackgroundName(name: result)
                    fileBackgrounds.append(result)
                } else {
                    print("File: \(fileURL.lastPathComponent), no valid content found between semicolons.")
                }
            }
        }
    } catch {
        print("Error accessing folder: \(error.localizedDescription)")
    }
    
    return fileBackgrounds
}

import Foundation

func replaceBackgroundInFile(_ fileName: String, atOccurrence occurrence: Int, with newBackground: String) {
    // Step 1: Get the folder URL
    guard let folderURL = getFolderURL(folderName: "createdCalendars") else {
        print("Error: Could not find the 'createdCalendars' folder.")
        return 
    }
    
    // Step 2: Construct the file URL
    let fileURL = folderURL.appendingPathComponent(fileName)
    
    // Step 3: Read the file content
    guard let fileContent = try? String(contentsOf: fileURL, encoding: .utf8) else {
        print("Error: Could not read the file.")
        return 
    }
    
    // Step 4: Split the content by `;`
    var components = fileContent.components(separatedBy: ";")
    
    // Step 5: Validate the number of components
    guard components.count >= occurrence * 3 else {
        print("Error: Not enough entries in the file.")
        return 
    }
    
    // Step 6: Calculate the index of the background to replace
    // Each entry consists of 3 parts: date, background, quote
    // The background is at index 1, 4, 7, etc.
    let backgroundIndex = (occurrence - 1) * 3 + 1
    
    // Step 7: Replace the background at the calculated index
    components[backgroundIndex] = newBackground
    
    // Step 8: Join the components back into a single string
    let updatedContent = components.joined(separator: ";")
    
    // Step 9: Write the modified content back to the file
    do {
        try updatedContent.write(to: fileURL, atomically: true, encoding: .utf8)
        return 
    } catch {
        print("Error: Could not write to the file.")
        return 
    }
}

/*
func convertBackgroundName(name: String) -> String
{
    var filename : String = ""
    switch name {
        case "b1":
            filename = "moon-7744608_1920"
        case "b2":
            filename = "mountains-5993080_1920_11zon"
        case "b3":
            filename = "astrology (3)"
        default:
            filename = "astrology (3)"
    }    
    return filename
}
*/
