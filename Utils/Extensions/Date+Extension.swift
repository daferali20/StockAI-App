import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay) ?? self
    }
    
    var startOfWeek: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components) ?? self
    }
    
    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components) ?? self
    }
    
    var startOfYear: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return calendar.date(from: components) ?? self
    }
    
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ar_SA")
        return formatter.string(from: self)
    }
    
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        if secondsAgo < 60 {
            return "\(secondsAgo) ثانية"
        } else if secondsAgo < 3600 {
            return "\(secondsAgo / 60) دقيقة"
        } else if secondsAgo < 86400 {
            return "\(secondsAgo / 3600) ساعة"
        } else if secondsAgo < 604800 {
            return "\(secondsAgo / 86400) يوم"
        } else {
            return toString(format: "dd/MM/yyyy")
        }
    }
}
