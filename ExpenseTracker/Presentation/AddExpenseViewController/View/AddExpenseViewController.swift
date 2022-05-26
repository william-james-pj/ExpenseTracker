//
//  AddExpenseViewController.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 24/05/22.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    // MARK: - Variables
    fileprivate var viewModel: AddExpenseViewModel = {
        return AddExpenseViewModel()
    }()
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewStackAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackHeader: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewStackHeaderAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Text")
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor(named: "Card")
        
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Add Expenses"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let viewInputContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackInputValue: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fill
        
        stack.backgroundColor = UIColor(named: "Card")
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let textFieldValue: TextFieldCustom = {
        let input = TextFieldCustom()
        input.placeholder = "0"
        input.textAlignment = .center
        input.font = .systemFont(ofSize: 20, weight: .bold)
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    fileprivate let stackForm: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let boxCategory: BoxCategory = {
        let stack = BoxCategory()
        return stack
    }()
    
    fileprivate let boxExpense: BoxExpense = {
        let stack = BoxExpense()
        return stack
    }()
    
    fileprivate let boxDate: BoxDate = {
        let stack = BoxDate()
        return stack
    }()
    
    fileprivate lazy var buttonSave: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Text")
        button.setTitle("SAVE", for: .normal)
        button.tintColor = UIColor(named: "Card")
        
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    // MARK: - Action
    @IBAction func closeButtonTapped() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(named: "Backgroud")
        
        self.boxCategory.setActionButton(to: self.viewModel.getTitleActions())
        
        buildHierarchy()
        buildConstraints()
    }

    // MARK: - Methods
    fileprivate func buildHierarchy() {
        view.addSubview(stackBase)
        
        stackBase.addArrangedSubview(stackHeader)
        stackHeader.addArrangedSubview(viewStackHeaderAux)
        stackHeader.addArrangedSubview(buttonClose)
        
        stackBase.addArrangedSubview(labelTitle)
        
        stackBase.addArrangedSubview(viewInputContainer)
        viewInputContainer.addSubview(stackInputValue)
        stackInputValue.addArrangedSubview(textFieldValue)
        
        stackBase.addArrangedSubview(stackForm)
        stackForm.addArrangedSubview(boxCategory)
        stackForm.addArrangedSubview(boxExpense)
        stackForm.addArrangedSubview(boxDate)
        
        stackBase.addArrangedSubview(buttonSave)
        
        stackBase.addArrangedSubview(viewStackAux)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackBase.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            buttonClose.widthAnchor.constraint(equalToConstant: 35),
            buttonClose.heightAnchor.constraint(equalToConstant: 35),
            
            stackInputValue.topAnchor.constraint(equalTo: viewInputContainer.topAnchor),
            stackInputValue.leadingAnchor.constraint(equalTo: viewInputContainer.leadingAnchor, constant: 32),
            stackInputValue.trailingAnchor.constraint(equalTo: viewInputContainer.trailingAnchor, constant: -32),
            stackInputValue.bottomAnchor.constraint(equalTo: viewInputContainer.bottomAnchor),
            
            buttonSave.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
