//
//  TransactionTableViewCell.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 24/05/22.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    // MARK: - Components
    fileprivate let viewBase: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Card")
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupVC()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Setup
    fileprivate func setupVC() {
        self.backgroundColor = .red
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    fileprivate func buildHierarchy() {
        self.addSubview(viewBase)
        viewBase.addSubview(stackBase)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            viewBase.topAnchor.constraint(equalTo: self.topAnchor),
            viewBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            stackBase.topAnchor.constraint(equalTo: viewBase.topAnchor, constant: 8),
            stackBase.leadingAnchor.constraint(equalTo: viewBase.leadingAnchor, constant: 8),
            stackBase.trailingAnchor.constraint(equalTo: viewBase.trailingAnchor, constant: -8),
            stackBase.bottomAnchor.constraint(equalTo: viewBase.bottomAnchor, constant: -8),
        ])
    }
}
