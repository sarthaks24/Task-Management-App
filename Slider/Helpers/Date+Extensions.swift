//
//  Date+Extensions.swift
//  Slider
//
//  Created by Sarthak on 26/04/24.
//

import SwiftUI

extension Date{
    
    // Custom Date Format
    func format(format: String) -> String {
            let formatter = DateFormatter()
            formatter.calendar = Calendar.current
            formatter.dateFormat = format
            
            return formatter.string(from: self)
    }
    
    // Checking whether is date today
    var isToday: Bool{
        return Calendar.current.isDateInToday(self)
    }
    
    // Checking if the date is same hour
    var isSameHour: Bool{
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedSame
    }
    
    // Checking if the date is Past hours
    var isPast: Bool{
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedAscending
    }


    // Fetching Week based on given Date
    func fetchWeek(_ date: Date = .init()) -> [WeekDay]{
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)
        
        var week: [WeekDay] = []
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        guard let startOfWeek = weekForDate?.start else{
             return []
         }
         // Iterating to get the full week
        (0..<7).forEach { index in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                week.append(.init(date: weekDay))
            }
        }
        return week

    }
    
    //Creating next week based on last week
    func createNextWeek() -> [WeekDay]{
         let calendar = Calendar.current
         let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else{
             return []
         }
         return fetchWeek(nextDate)
     }
    
    // Creating Previous week, based on the first current week date
   func createPreviousWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfFirstDate = calendar.startOfDay(for: self)
       guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfFirstDate) else{
           return []
       }
       return fetchWeek(previousDate)
   }



    struct WeekDay: Identifiable{
        var id: UUID = .init()
        var date: Date
    }
    
    
    
}
