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
    
    mutating func input() {
    outerloop: while true {
            print("Input a date (mm/dd/yyyy): ", terminator: "")
            if let temp = readLine() {
                let array = temp.components(separatedBy: "/")
                if array.count == 3 {
                    var numbers = [0, 0, 0]
                    for i in 0...2 {
                        if let number = Int(array[i]) {
                            numbers[i] = number
                        } else{ //Invalid Input - Any of the inputs are not numbers
                            print("Invalid Input!")
                            continue
                        }
                    }
                    if numbers[0] <= 0 && numbers[0] > 12 { //Invalid Input - Month is out of bounds
                        print("Invalid Input!")
                        continue
                    }
                    if numbers[2] < 0 && numbers[2] >= 10_000 { //Invalid Input - Year is out of bounds
                        print("Invalid Input!")
                        continue
                    }
                    let limit = GetLimit(numbers[0], numbers[2])
                    if numbers[1] <= limit && numbers[1] > 0 {
                        month = numbers[0]
                        day = numbers[1]
                        year = numbers[2]
                        break outerloop
                    } else { //Invalid Input - Day is out of bounds
                    print("Invalid Input!")
                        continue
                    }
                    
                } else { //Invalid Input - Too many or too few numbers
                    print("Invalid Input!")
                    continue
                }
            } else { //Invalid Input
                print("Invalid Input!")
                continue
            }
        }
    }
    
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
    
    private func GetLimit(_ month: Int, _ year: Int) -> Int {
        switch month {
        case 2:
            let leap = year % 4 == 0 ? 1 : 0
            return 28 + leap
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        default:
            return 30
        }
    }
}

enum DateFormat {
  case standard, long, two
}

