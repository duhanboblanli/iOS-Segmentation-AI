//
//  DayManager.swift
//  Segment AI
//
//  Created by Duhan Boblanlı on 30.10.2023.
//

import Foundation
import Combine

class DayManager: ObservableObject {
    
    // get current day to compare with the day in db
    @Published var currentDay: Int = 3
    let currentDate = Date()
    let calendar = Calendar.current
    
    init() {
        currentDay = calendar.component(.day, from: currentDate)
    }
    
    var currentDayPublisher: Published<Int>.Publisher { $currentDay }
}
