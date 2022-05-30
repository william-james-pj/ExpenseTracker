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
    
    // MARK: - Methods
    func getElements() -> [ExpenseModel] {
        return expenseBehavior.value
    }
}
