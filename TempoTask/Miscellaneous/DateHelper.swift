//
//  DateHelper.swift
//  TempoTask
//
//  Created by Hussein Kishk on 21/11/2020.
//

import Foundation
class DateHelper {
    static func getFormattedDateStr2Str(dateStr: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateStr ?? "" ) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
