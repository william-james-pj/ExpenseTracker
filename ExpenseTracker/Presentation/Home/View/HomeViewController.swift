//
//  HomeViewController.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 24/05/22.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    // MARK: - Constrants
    fileprivate let resuseIdentifierTransaction = "TransactionCollectionViewCell"
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - Variables
    fileprivate var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    fileprivate var allExpenses: [ExpenseModel] = []
    
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
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewCardMonth: CardMonthSpend = {
        let view = CardMonthSpend()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackCard: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewCardIncome: CardExpense = {
        let view = CardExpense()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let viewCardExpense: CardExpense = {
        let view = CardExpense()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackTransactions: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelTransactions: UILabel = {
        let label = UILabel()
        label.text = "Recent transactions"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let collectionViewTransaction: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    fileprivate lazy var buttonAdd: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Text")
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    // MARK: - Action
    @IBAction func addButtonTapped() -> Void {
        let modalVC = AddExpenseViewController()
        modalVC.modalPresentationStyle = .fullScreen
        
        modalVC.viewModel.taskSubjectObservable.subscribe(onNext: { expense in
            self.viewModel.newTask(expense)
        }).disposed(by: disposeBag)
        
        self.present(modalVC, animated: true, completion: nil)
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(named: "Backgroud")
        
        viewModel.spendBehavior.subscribe(onNext: { expenses in
            print("Subscribe Home")
            self.allExpenses = expenses
            self.collectionViewTransaction.reloadData()
            self.settingValues()
        }).disposed(by: disposeBag)
        
        buildHierarchy()
        buildConstraints()
        setupCollection()
    }
    
    fileprivate func setupCollection() {
        collectionViewTransaction.dataSource = self
        collectionViewTransaction.delegate = self
        
        collectionViewTransaction.register(TransactionCollectionViewCell.self, forCellWithReuseIdentifier: resuseIdentifierTransaction)
    }
    
    // MARK: - Methods
    fileprivate func settingValues() {
        let expenses = allExpenses.filter { $0.expenseType == .expense }
        let incomes = allExpenses.filter { $0.expenseType == .income }
        
        let expenseValues = expenses.map { $0.value }
        let incomeValues = incomes.map { $0.value }
        
        let expenseTotal = expenseValues.reduce(0) { $0 + $1 }
        let incomeTotal = incomeValues.reduce(0) { $0 + $1 }
        
        self.viewCardExpense.confiView(to: .expense, value: "$\(expenseTotal)")
        self.viewCardIncome.confiView(to: .income, value: "$\(incomeTotal)")
        self.viewCardMonth.confiView(value: "$\(incomeTotal - expenseTotal)")
    }
    
    fileprivate func buildHierarchy() {
        view.addSubview(stackBase)
        
        stackBase.addArrangedSubview(stackHeader)
        stackHeader.addArrangedSubview(viewCardMonth)
        stackHeader.addArrangedSubview(stackCard)
        stackCard.addArrangedSubview(viewCardIncome)
        stackCard.addArrangedSubview(viewCardExpense)
        
        stackBase.addArrangedSubview(stackTransactions)
        stackTransactions.addArrangedSubview(labelTransactions)
        stackTransactions.addArrangedSubview(collectionViewTransaction)
        
        view.addSubview(buttonAdd)
        
//        stackBase.addArrangedSubview(viewStackAux)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackBase.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            buttonAdd.heightAnchor.constraint(equalToConstant: 50),
            buttonAdd.widthAnchor.constraint(equalToConstant: 50),
            buttonAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            buttonAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }
}

// MARK: - extension CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       return
    }
}

// MARK: - extension CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allExpenses.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifierTransaction, for: indexPath) as! TransactionCollectionViewCell
        cell.settingCell(allExpenses[indexPath.row])
        return cell
    }
}

// MARK: - extension CollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 64)
    }
}

