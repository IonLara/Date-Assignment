//
//  Date.swift
//  Assignment2
//
//  Created by Derrick Park on 2023-03-03.
//

import Foundation

struct Date {
    private (set) var day: Int
    private (set) var month: Int
    private (set) var year: Int
    
    
    init(month: Int, day: Int, year: Int) {
        if month > 12 || month < 1 {
            self.day = 1
            self.month = 1
            self.year = 2000
            return
        } else {
            self.month = month
        }
        if year >= 0 {
            self.year = year
        } else {
            self.day = 1
            self.month = 1
            self.year = 2000
        }
        var limit = -1
        switch month {
        case 2:
            let leap = year % 4 == 0 ? 1 : 0
            limit = 28 + leap
        case 1, 3, 5, 7, 8, 10, 12:
            limit = 31
        default:
            limit = 30
        }
        if day > limit || day < 1 {
            self.day = 1
            self.month = 1
            self.year = 2000
            return
        } else {
            self.day = day
        }
    }
    init() {
        self.day = 1
        self.month = 1
        self.year = 2000
    }
}

enum DateFormat {
  case standard, long, two
}

