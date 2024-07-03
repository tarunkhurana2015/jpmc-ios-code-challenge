//
//  Int+.swift
//  Weather
//
//  Created by Tarun Khurana on 2/21/24.
//

import Foundation

extension Int {

    func timeZoneOffsetToDateString() -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy h:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let currentDate = Date()

        let timezoneOffset = Double(self)
        let epochDate = currentDate.timeIntervalSince1970

        let timezoneEpochOffset = (epochDate + timezoneOffset)

        let timeZoneOffsetDate = Date(timeIntervalSince1970: timezoneEpochOffset)

        return dateFormatter.string(from: timeZoneOffsetDate)
    }

}
