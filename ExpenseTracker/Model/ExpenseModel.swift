//
//  ExpenseModel.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 26/05/22.
//

import Foundation

enum ExpenseType: Codable {
    case expense
    case income
}

enum CategoryType: String, CaseIterable, Codable {
    case salary = "Salary"
    case housing = "Housing"
    case transportation = "Transportation"
    case food = "Food"
    case investments = "Investments"
    case medical = "Medical"
    case personalSpending = "Personal Spending"
    case entertainment = "Entertainment"
    case miscellaneous = "Miscellaneous"
}

class ExpenseModel: Codable {
    let id: String;
    let category: CategoryType;
    let expenseType: ExpenseType
    let date: Date
    let value: Double
    
    init() {
        self.id = "-1"
        self.category = .entertainment
        self.expenseType = .expense
        self.date = Date()
        self.value = 0
    }
    
    init (id: String, category: CategoryType, expenseType: ExpenseType, date: Date, value: Double) {
        self.id = id
        self.category = category
        self.expenseType = expenseType
        self.date = date
        self.value = value
    }
}
