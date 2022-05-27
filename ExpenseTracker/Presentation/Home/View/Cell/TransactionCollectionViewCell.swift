//
//  TransactionCollectionViewCell.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 24/05/22.
//

import UIKit

class TransactionCollectionViewCell: UICollectionViewCell {
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let stackHeader: UIStackView = {
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
    
    fileprivate let labelEmoji: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let stackHeaderText: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let viewHeaderTextAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    fileprivate let labelCategory: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 12, weight: .regular)
//        label.textColor = UIColor(named: "Disabled")
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    fileprivate let stackFooter: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .right
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textAlignment = .right
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor(named: "Card")
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func settingCell(_ item: ExpenseModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        self.labelValue.text = item.expenseType == .expense ? "$-\(item.value)" : "$\(item.value)"
        self.labelTitle.text = item.category.rawValue
        self.labelDate.text = dateFormatter.string(from: item.date)
        
        setEmoji(to: item.category)
    }
    
    fileprivate func setEmoji(to category: CategoryType) {
        switch category {
        case .housing:
            self.labelEmoji.text = "🏠"
        case .transportation:
            self.labelEmoji.text = "🚗"
        case .food:
            self.labelEmoji.text = "🍔"
        case .medical:
            self.labelEmoji.text = "💊"
        case .personalSpending:
            self.labelEmoji.text = "🛍"
        case .entertainment:
            self.labelEmoji.text = "📽"
        case .miscellaneous:
            self.labelEmoji.text = "💳"
        case .salary:
            self.labelEmoji.text = "💰"
        case .investments:
            self.labelEmoji.text = "💹"
        }
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        
        stackBase.addArrangedSubview(stackHeader)
        stackHeader.addArrangedSubview(viewSquareContainer)
        viewSquareContainer.addSubview(viewSquare)
        viewSquare.addSubview(labelEmoji)
        stackHeader.addArrangedSubview(stackHeaderText)
        stackHeaderText.addArrangedSubview(labelTitle)
//        stackHeaderText.addArrangedSubview(viewHeaderTextAux)
        
        stackBase.addArrangedSubview(stackFooter)
        stackFooter.addArrangedSubview(labelValue)
        stackFooter.addArrangedSubview(labelDate)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            viewSquareContainer.widthAnchor.constraint(equalToConstant: 32),
            
            viewSquare.widthAnchor.constraint(equalToConstant: 32),
            viewSquare.heightAnchor.constraint(equalToConstant: 32),
            viewSquare.centerXAnchor.constraint(equalTo: viewSquareContainer.centerXAnchor),
            viewSquare.centerYAnchor.constraint(equalTo: viewSquareContainer.centerYAnchor),
        
            labelEmoji.centerXAnchor.constraint(equalTo: viewSquare.centerXAnchor),
            labelEmoji.centerYAnchor.constraint(equalTo: viewSquare.centerYAnchor),
        ])
    }
}
