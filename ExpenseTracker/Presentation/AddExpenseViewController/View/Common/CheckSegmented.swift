//
//  CheckSegmented.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 25/05/22.
//

import UIKit

class CheckSegmented: UIView {
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewStackAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackOp1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewCheckOp1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var buttonCheckOp1: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "Text")?.cgColor
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.imageView?.contentMode = .center
        button.tintColor = .clear
        return button
    }()
    
    fileprivate let labelOp1: UILabel = {
        let label = UILabel()
        label.text = "Income"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let stackOp2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewCheckOp2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var buttonCheckOp2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "Text")?.cgColor
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        button.imageView?.contentMode = .center
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .clear
        return button
    }()
    
    fileprivate let labelOp2: UILabel = {
        let label = UILabel()
        label.text = "Expenses"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(named: "Text")
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
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Action
    @IBAction func checkButtonTapped(_ sender: UIButton) -> Void {
        buttonCheckOp1.backgroundColor = .clear
        buttonCheckOp1.tintColor = .clear
        buttonCheckOp2.backgroundColor = .clear
        buttonCheckOp2.tintColor = .clear
        
//        sender.backgroundColor = UIColor(named: "Text")
        sender.tintColor = UIColor(named: "Text")
    }
    
    // MARK: - Methods
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        
        stackBase.addArrangedSubview(stackOp1)
        stackOp1.addArrangedSubview(viewCheckOp1)
        viewCheckOp1.addSubview(buttonCheckOp1)
        stackOp1.addArrangedSubview(labelOp1)
        
        stackBase.addArrangedSubview(stackOp2)
        stackOp2.addArrangedSubview(viewCheckOp2)
        viewCheckOp2.addSubview(buttonCheckOp2)
        stackOp2.addArrangedSubview(labelOp2)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 160),
            
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewCheckOp2.widthAnchor.constraint(equalToConstant: 20),
            buttonCheckOp1.centerXAnchor.constraint(equalTo: viewCheckOp1.centerXAnchor),
            buttonCheckOp1.centerYAnchor.constraint(equalTo: viewCheckOp1.centerYAnchor),
            buttonCheckOp1.heightAnchor.constraint(equalToConstant: 20),
            buttonCheckOp1.widthAnchor.constraint(equalToConstant: 20),
            
            viewCheckOp2.widthAnchor.constraint(equalToConstant: 20),
            buttonCheckOp2.centerXAnchor.constraint(equalTo: viewCheckOp2.centerXAnchor),
            buttonCheckOp2.centerYAnchor.constraint(equalTo: viewCheckOp2.centerYAnchor),
            buttonCheckOp2.heightAnchor.constraint(equalToConstant: 20),
            buttonCheckOp2.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
}
