//
//  DataTimeConvertible.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.04.2022.
//

import Foundation
//MARK: - перевод формата времени Unix  в текстовый формат (MM-dd-yyyy HH:mm)
func unixTimeConvertion(unixTime: Double) -> String {
    let time = NSDate(timeIntervalSince1970: unixTime)
    let dateFormatter = DateFormatter()
    //dateFormatter.timeZone = NSTimeZone(name: timeZoneInfo)
    dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.system.identifier) as Locale?
    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
    let dateAsString = dateFormatter.string(from: time as Date)

    return dateAsString
}
