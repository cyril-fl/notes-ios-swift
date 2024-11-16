import SwiftUI

extension Text {
    init(_ date: Date, dateStyle: Date.FormatStyle.DateStyle = .abbreviated, timeStyle: Date.FormatStyle.TimeStyle = .shortened) {
        let formattedDate = date.formatted(date: dateStyle, time: timeStyle)
        self.init(formattedDate)
    }
    
    init(_ value: Int) {
        self.init("\(value)")
    }
}
