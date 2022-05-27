//
//  AddExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 26/05/22.
//

import Foundation
import RxSwift

class AddExpenseViewModel {
    // MARK: - Constants
    fileprivate let expenseSubject = PublishSubject<ExpenseModel>()
    
    // MARK: - Variables
    var taskSubjectObservable: Observable<ExpenseModel> {
        return expenseSubject.asObserver()
    }
    
    func addNewExpense(by newExpense: ExpenseModel) {
        expenseSubject.onNext(newExpense)
    }
}
