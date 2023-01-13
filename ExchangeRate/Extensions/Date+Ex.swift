//
//  Date+Ex.swift
//  ExchangeRate
//
//  Created by Dmitry Lipuntsov on 12.01.2023.
//

import Foundation

extension Date {
    static func nextYear() -> [Date]{
        return Date.next(numberOfDays: 365, from: Date())
    }
    
    static func previousYear()-> [Date]{
        return Date.next(numberOfDays: 365, from: Calendar.current.date(byAdding: .year, value: -1, to: Date())!)
    }
    
    static func next(numberOfDays: Int, from startDate: Date) -> [Date]{
        var dates = [Date]()
        for i in 0..<numberOfDays {
            if let date = Calendar.current.date(byAdding: .day, value: numberOfDays - i, to: startDate) {
                dates.append(date)
            }
        }
        return dates
    }
}
