//
//  CardExpense.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 24/05/22.
//

import UIKit

enum CardExpenseType {
    case expense
    case income
}

class CardExpense: UIView {
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewSquareContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let viewSquare: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1.00)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let imageViewType: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.tintColor = UIColor(named: "Text")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    fileprivate let stackText: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelValue: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
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
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func confiView(to type: CardExpenseType, value: String) {
        self.labelValue.text = value
        
        switch type {
        case .expense:
            self.labelTitle.text = "Expense"
            self.imageViewType.image = UIImage(systemName: "arrow.down")
        case .income:
            self.labelTitle.text = "Income"
            self.imageViewType.image = UIImage(systemName: "arrow.up")
        }
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        
        stackBase.addArrangedSubview(viewSquareContainer)
        viewSquareContainer.addSubview(viewSquare)
        viewSquare.addSubview(imageViewType)
        
        stackBase.addArrangedSubview(stackText)
        stackText.addArrangedSubview(labelTitle)
        stackText.addArrangedSubview(labelValue)
        
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 55),
            
            stackBase.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            viewSquareContainer.widthAnchor.constraint(equalToConstant: 45),
            
            viewSquare.widthAnchor.constraint(equalToConstant: 30),
            viewSquare.heightAnchor.constraint(equalToConstant: 30),
            viewSquare.centerXAnchor.constraint(equalTo: viewSquareContainer.centerXAnchor),
            viewSquare.centerYAnchor.constraint(equalTo: viewSquareContainer.centerYAnchor),
            
            imageViewType.topAnchor.constraint(equalTo: viewSquare.topAnchor),
            imageViewType.leadingAnchor.constraint(equalTo: viewSquare.leadingAnchor),
            imageViewType.trailingAnchor.constraint(equalTo: viewSquare.trailingAnchor),
            imageViewType.bottomAnchor.constraint(equalTo: viewSquare.bottomAnchor),
        ])
    }
}
