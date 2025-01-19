import Foundation

struct CalendarDay {
    var date: Date
    var background: String
    var quote: String
}

let dateFormatter = DateFormatter()

func dateFormatterSetup(){
    dateFormatter.dateFormat = "dd.MM.yyyy"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
}

func isToday(_ date: Date) -> Bool {
    let calendar = Calendar.current
    return calendar.isDateInToday(date)
}

let date1 = dateFormatter.date(from: "01.01.2000") ?? Date()
let date2 = dateFormatter.date(from: "02.01.2000") ?? Date()
let date3 = dateFormatter.date(from: "19.01.2025") ?? Date()

var exampleCalendar = [
    CalendarDay(date: date1, background: "b1", quote: "Deine Mom."),
    CalendarDay(date: date2, background: "b2", quote: "Stay positive."),
    CalendarDay(date: date3, background: "b3", quote: "Stay negative.")
]
