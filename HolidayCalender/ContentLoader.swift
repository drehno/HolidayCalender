import Foundation

func loadZodiacContent(for zodiac: String) -> (quotes: [String], facts: [String]) {
    guard let url = Bundle.main.url(forResource: zodiac.lowercased(), withExtension: "json") else {
        print("File for \(zodiac) not found")
        return ([], [])
    }
    do {
        let data = try Data(contentsOf: url)
        let decoded = try JSONDecoder().decode([String: [String]].self, from: data)
        let quotes = decoded["quotes"] ?? []
        let facts = decoded["facts"] ?? []
        return (quotes, facts)
    } catch {
        print("Error loading file for \(zodiac): \(error)")
        return ([], [])
    }
}
