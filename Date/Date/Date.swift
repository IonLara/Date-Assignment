//
//  Date.swift
//  Assignment2
//
//  Created by Derrick Park on 2023-03-03.
//

import Foundation

struct Date: Comparable, CustomStringConvertible{
    private (set) var day: Int
    private (set) var month: Int
    private (set) var year: Int
    var format = DateFormat.standard
    
    var description: String { //Set the description for the struct
        return "The date is: \(month)/\(day)/\(year)"
    }
    mutating func input() { //Function that receives input from user and changes date after validating it
    outerloop: while true {
            print("Input a date (M/D/Y): ", terminator: "")
            if let temp = readLine() { //Check input is not nil
                let array = temp.components(separatedBy: "/") //Creates a String array with the values
                if array.count == 3 { //Checks if there are exactly 3 numbers in the input
                    var numbers = [0, 0, 0] //Initialize an array that will store the numbers as Int
                    for i in 0...2 {
                        if let number = Int(array[i]) { //Unwrap the strings into integers
                            numbers[i] = number
                        } else{ //Invalid Input - Any of the inputs are not numbers
                            print("Invalid Input!")
                            continue //Ask for input again
                        }
                    }
                    //After unwrapping the numbers validate that the dates are within bounds
                    if numbers[0] <= 0 && numbers[0] > 12 { //Invalid Input - Month is out of bounds
                        print("Invalid Input!")
                        continue //Ask for input again
                    }
                    if numbers[2] < 0 { //Invalid Input - Year is out of bounds
                        print("Invalid Input!")
                        continue //Ask for input again
                    }
                    let limit = GetLimit(numbers[0], numbers[2]) //Get how many days are in the month
                    if numbers[1] <= limit && numbers[1] > 0 { //If days are within bounds then all input is validated and change the date
                        month = numbers[0]
                        day = numbers[1]
                        year = numbers[2]
                        break outerloop //Break from the while loop
                    } else { //Invalid Input - Day is out of bounds
                    print("Invalid Input!")
                        continue //Ask for input again
                    }
                    
                } else { //Invalid Input - Too many or too few numbers
                    print("Invalid Input!")
                    continue //Ask for input again
                }
            } else { //Invalid Input
                print("Invalid Input!")
                continue //Ask for input again
            }
        }
    }
    
    func show() {
        switch format {
        case .standard: //Show dates as integers
            print("\(month)/\(day)/\(year)")
        case .two: //Show dates in format of two by two
            let monthString = month > 9 ? String(month) : "0\(month)" //Add an extra 0 at the start if the number is less than 10
            let dayString = day > 9 ? String(day) : "0\(day)" //Add an extra 0 at the start if the number is less than 10
            let yearString = year > 9 ? String(year).suffix(2) : "0\(String(year).suffix(1))" //Add an extra 0 at the start if the number is less than 10
            print("\(monthString)/\(dayString)/\(yearString)")
        case .long: //Show dates in long format
            let monthShort = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
            print("\(monthShort[month - 1]) \(day), of \(year)")
        }
    }
    //Function to set a new date
    mutating func set(month: Int, day: Int, year: Int) -> Bool {
        if month < 1 || month > 12 { //If month is out of bounds abort function
            return false
        }
        if year < 0 { //If year is out of bounds abort function
            return false
        }
        let limit = GetLimit(month, year) //Get ammount of days in month
        if day > limit || day < 1 { //If month is out of bounds abort function
            return false
        }
        //After validating all new values change the variables
        self.month = month
        self.day = day
        self.year = year
        return true
    }
    
    mutating func setFormat(_ format: DateFormat) {
        self.format = format
    }
    
    mutating func increment(_ numDays: Int = 1) {
        var left = numDays //How many days we have to add to the date
        while left > 0 {
            let monthDays = GetLimit(month, year) - day //Get how many days are left in the month
            if left > monthDays { //If we have to add less days than there are left in the month
                left -= monthDays + 1 //Substract enough days to move to the first day of next month
                day = 1
                //We check if the month is december
                if month < 12 {
                    month += 1
                } else {
                    month = 1
                    year += 1
                }
            } else { //If we have to add less days than there are left in the month
                day += left
                left = 0
            }
        }
    }
    //Initializer for struct
    init(month: Int, day: Int, year: Int) {
        if month > 12 || month < 1 { //If month is out of bounds set default values
            self.day = 1
            self.month = 1
            self.year = 2000
            return
        } else {
            self.month = month
        }
        if year >= 0 {
            self.year = year
        } else { //If year is out of bounds set default values
            self.day = 1
            self.month = 1
            self.year = 2000
            return
        }
        //Get how many days are in this month
        var limit = -1
        switch month {
        case 2:
            limit = 28
        case 1, 3, 5, 7, 8, 10, 12:
            limit = 31
        default:
            limit = 30
        }
        if day > limit || day < 1 { //If day is out of bounds set default values
            self.day = 1
            self.month = 1
            self.year = 2000
            return
        } else {
            self.day = day
        }
    }
    //Initializer with no parameters passed
    init() {
        self.day = 1
        self.month = 1
        self.year = 2000
    }
    static func <(lhs: Date, rhs: Date) -> Bool {
        if lhs.year < rhs.year { //If the year is less then the date will always be less
            return true
        } else if lhs.year > rhs.year {
            return false
        }
        if lhs.month < rhs.month { //If the year is the same but the month is less it will always be less
            return true
        } else if lhs.month > rhs.month {
            return false
        }
        if lhs.day < rhs.day { //If same year and same month we check if the day is less
            return true
        } else {
            return false
        }
        
    }
    
    static func ==(lhs: Date, rhs: Date) -> Bool {
        lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }
    
    //Extra function to easily get how many days are in each month
    private func GetLimit(_ month: Int, _ year: Int) -> Int {
        switch month {
        case 2:
            return 28
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

