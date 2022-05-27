//
//  HomeViewModel.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 24/05/22.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel {
    var spendBehavior: BehaviorRelay<[ExpenseModel]> = BehaviorRelay(value: [])
    
    func newTask(_ expenseItem: ExpenseModel) {
        var aux = self.spendBehavior.value
        aux.insert(expenseItem, at: 0)
        self.spendBehavior.accept(aux)
    }
}
