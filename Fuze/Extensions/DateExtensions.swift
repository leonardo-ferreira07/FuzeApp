//
//  DateExtensions.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

extension Date {
    func to(timeZone outputTimeZone: TimeZone, from inputTimeZone: TimeZone) -> Date {
         let delta = TimeInterval(outputTimeZone.secondsFromGMT(for: self) - inputTimeZone.secondsFromGMT(for: self))
         return addingTimeInterval(delta)
    }
    
    static func convertToFuzeDate(_ dateString: String) -> String {
        let utcTimeZone = TimeZone(abbreviation: "UTC")!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString)
        
        let finalDate = date?.to(timeZone: .autoupdatingCurrent, from: utcTimeZone) ?? Date()
        let day = Calendar.current.component(.day, from: finalDate)
        let month = Calendar.current.component(.month, from: finalDate)
        let hour = Calendar.current.component(.hour, from: finalDate)
        let minute = Calendar.current.component(.minute, from: finalDate)
        
        return String(format: "%02d.%02d %02d:%02d", day, month, hour, minute)
    }
}
