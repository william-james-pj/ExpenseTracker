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
    var spendBehavior: BehaviorRelay<[String]> = BehaviorRelay(value: ["", ""])
}
