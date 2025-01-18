//
//  Share.swift
//  HolidayCalender
//
//  Created by Torben Steegmann on 18.01.25.
//

import Foundation

struct CalendarDay {
    var date: Date
    var background: Int
    var quote: String
}

func generateCSVContent(for calendar: [CalendarDay]) -> String {
    var csvContent = ""
    for entry in calendar {
        let line = "\(entry.date);\(entry.background);\(entry.quote);"
        csvContent += line
    }
    return csvContent
}

func saveCSVFile(content: String, fileName: String) -> URL? {
    let fileManager = FileManager.default
    do {
        let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentsURL.appendingPathComponent(fileName)
        try content.write(to: fileURL, atomically: true, encoding: .utf8)
        return fileURL
    } catch {
        print("Error saving file: \(error)")
        return nil
    }
}



func exportCalender(calendar: [CalendarDay]) {
    let csvFormat = generateCSVContent(for: calendar)
    saveCSVFile(content: csvFormat, fileName: "HolidayCalendar.csv")
}

func getCalender(fileURL: URL) -> [CalendarDay] {
    var calendarDay = CalendarDay(date: Date(), background: 0, quote: "")
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
                    calendarDay.background = Int(word) ?? 0
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
