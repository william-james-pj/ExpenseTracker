//
//  BoxExpense.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 26/05/22.
//

import UIKit
import RxSwift

class BoxExpense: UIView {
    // MARK: - Constants
    fileprivate let expenseSubject = PublishSubject<ExpenseType>()
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - Variables
    var expenseSubjectObservable: Observable<ExpenseType> {
        return expenseSubject.asObserver()
    }
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewStackAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let viewImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "arrow.up.arrow.down")
        image.tintColor = UIColor(named: "Disabled")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    fileprivate let checkSegmented: CheckSegmented = {
        let view = CheckSegmented()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        self.backgroundColor = UIColor(named: "Card")
        self.layer.cornerRadius = 8
        
        self.checkSegmented.checkSubjectObservable.subscribe(onNext: { expenseType in
            self.expenseSubject.onNext(expenseType)
        }).disposed(by: disposeBag)
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(viewImageContainer)
        viewImageContainer.addSubview(imageView)
        stackBase.addArrangedSubview(checkSegmented)
        stackBase.addArrangedSubview(viewStackAux)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 45),
            
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewImageContainer.widthAnchor.constraint(equalToConstant: 40),
            
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.centerXAnchor.constraint(equalTo: viewImageContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: viewImageContainer.centerYAnchor),
        ])
    }
    
}
