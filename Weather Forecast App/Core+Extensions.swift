//
//  Core+Extensions.swift
//  Weather Forecast App
//
//  Created by Eric Kazuo  on 02/01/24.
//

import Foundation

extension Int {
    func toWeekdayName() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "EE" // "EEEE" representa o nome completo do dia da semana
        
        
        return dateFormatter.string(from: date)
    }
    
    func toHourFormat() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm" // "HH:mm" representa o formato de 24 horas
        
        return dateFormatter.string(from: date)
    }
    
    func isDayTime() -> Bool {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let hour = Calendar.current.component(.hour, from: date)
        
        let dayStartHour = 6
        let dayEndHour = 18
        
        return hour >= dayStartHour && hour < dayEndHour
    }
}

extension Double {
    func toCelsius () -> String {
     "\(Int(self))°C"
    }
}
