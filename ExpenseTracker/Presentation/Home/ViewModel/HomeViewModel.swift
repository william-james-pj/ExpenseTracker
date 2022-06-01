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
    
    init() {
        getData()
    }
    
    func newTask(_ expenseItem: ExpenseModel) {
        var aux = self.spendBehavior.value
        aux.insert(expenseItem, at: 0)
        self.spendBehavior.accept(aux)
        
        setUserDefault()
    }
    
    fileprivate func getData() {
        if getUserDefault() {
            return
        }
    }
    
    fileprivate func getUserDefault() -> Bool{
        let userDefaults = UserDefaults.standard
        do {
            let arrayUserDefault = try userDefaults.getObject(forKey: "expenses", castTo: [ExpenseModel].self)

            self.spendBehavior.accept(arrayUserDefault)
            
            return true
        } catch {
            return false
        }
    }
    
    fileprivate func setUserDefault() {
        let userDefaults = UserDefaults.standard
        let all = self.spendBehavior.value
        do {
            try userDefaults.setObject(all, forKey: "expenses")
        } catch {
        }
    }
}
