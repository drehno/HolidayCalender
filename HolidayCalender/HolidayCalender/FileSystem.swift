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
        dateFormatter.dateFormat = "dd.MM.yyyy"
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
