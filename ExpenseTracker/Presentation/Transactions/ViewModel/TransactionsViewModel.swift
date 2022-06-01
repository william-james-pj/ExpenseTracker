//
//  TransactionsViewModel.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 30/05/22.
//

import Foundation
import RxRelay

class TransactionsViewModel {
    // MARK: - Variables
    var expenseBehavior: BehaviorRelay<[ExpenseModel]> = BehaviorRelay(value: [])
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    init() {
        self.startDate = newDate(of: Date())
        self.endDate = newDate(of: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
    }
    
    // MARK: - Methods
    func getElements() -> [ExpenseModel] {
        return expenseBehavior.value
    }
    
    func getTotalValue(to expenseType: ExpenseType) -> Double {
        let filtered = self.expenseBehavior.value.filter { $0.expenseType == expenseType && dateIsBetween($0.date) }
        let values = filtered.map { $0.value }
        
        if expenseType == .income {
            return values.reduce(0) { $0 + $1 }
        }
        return -1 * values.reduce(0) { $0 + $1 }
    }
    
    func setDate(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func dateIsBetween(_ date: Date) -> Bool {
        let date1 = self.startDate
        let date2 = self.endDate
        return (min(date1, date2) ... max(date1, date2)).contains(date)
    }
    
    func newDate(of date: Date) -> Date {
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        let components = calendar.components([.day , .month , .year], from: date)
        
        var dc = DateComponents()
        dc.year = components.year
        dc.month = components.month
        dc.day = components.day
        
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        
        if let date = calendar.date(from: dc) {
            return Date.init(timeInterval: 0, since: date)
        }
        return Date()
    }
    
}
