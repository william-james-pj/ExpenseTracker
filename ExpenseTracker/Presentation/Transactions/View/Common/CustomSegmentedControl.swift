//
//  CustomSegmentedControl.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 30/05/22.
//

import UIKit
import RxSwift

class CustomSegmentedControl: UIView {
    // MARK: - Constants
    fileprivate let indexSelectedSubject = PublishSubject<Int>()
    
    // MARK: - Variables
    var indexSelectedSubjectObservable: Observable<Int> {
        return indexSelectedSubject.asObserver()
    }
    fileprivate var buttonTitles: [String] = []
    fileprivate var buttons: [UIButton] = []
    
    fileprivate var selectorTextColor = UIColor(named: "Card")
    fileprivate var disableTextColor = UIColor(named: "Text")
    fileprivate var selectorViewColor = UIColor(named: "Text")
    fileprivate var disabeldViewColor = UIColor(named: "Card")
    
    // MARK: - Actions
    @IBAction func buttonTapped(sender: UIButton) {
        for (indexButton, btn) in buttons.enumerated() {
            btn.setTitleColor(disableTextColor, for: .normal)
            btn.backgroundColor = disabeldViewColor
            
            if btn == sender {
                btn.setTitleColor(selectorTextColor, for: .normal)
                btn.backgroundColor = selectorViewColor
                self.indexSelectedSubject.onNext(indexButton)
            }
        }
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        createButton()
        configStack()
    }
    
    // MARK: - Methods
    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        self.setupVC()
    }
    
    fileprivate func createButton() {
        self.buttons = [UIButton]()
        self.buttons.removeAll()
        self.subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton()
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(disableTextColor, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
            button.backgroundColor = disabeldViewColor
            button.layer.cornerRadius = 8
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons[0].backgroundColor = selectorViewColor
    }
    
    fileprivate func configStack() {
        let stackBase = UIStackView(arrangedSubviews: buttons)

        stackBase.backgroundColor = UIColor(named: "Card")
        stackBase.clipsToBounds = true
        stackBase.layer.cornerRadius = 8
        
        stackBase.axis = .horizontal
        stackBase.spacing = 8
        stackBase.distribution = .fillEqually
        stackBase.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackBase)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 45),
            
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
