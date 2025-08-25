import Foundation

extension DateFormatter {
    
    static func formatAsHome(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        return formatter.string(from: date)
    }
    
}

