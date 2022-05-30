//
//  TransactionsViewController.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 30/05/22.
//

import UIKit
import RxSwift
import RxRelay

class TransactionsViewController: UIViewController {
    // MARK: - Constrants
    fileprivate let resuseIdentifierTransaction = "TransactionCollectionViewCellTransactions"
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - Variables
    var viewModel: TransactionsViewModel = {
        return TransactionsViewModel()
    }()
    fileprivate var filterData: [ExpenseModel] = []
    fileprivate let filterOpBehavior: BehaviorRelay<ExpenseType> = BehaviorRelay(value: .income)
    
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
    
    fileprivate let stackNav: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate lazy var buttonBack: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Card")
        button.setImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: "Disabled")
        
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let labeltitleNav: UILabel = {
        let label = UILabel()
        label.text = "Transactions"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var buttonFilter: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Card")
        button.setImage(UIImage(systemName: "chart.bar.fill"), for: .normal)
        button.tintColor = UIColor(named: "Disabled")
        
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let customSegmented: CustomSegmentedControl = {
        let view = CustomSegmentedControl()
        view.setButtonTitles(buttonTitles: ["Income", "Expenses"])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackText: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelData: UILabel = {
        let label = UILabel()
        label.text = "All"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelTotal: UILabel = {
        let label = UILabel()
        label.text = "0.00"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    // MARK: - Action
    @IBAction func closeButtonTapped() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(named: "Backgroud")
        
        self.viewModel.expenseBehavior.subscribe(onNext: { expenses in
            self.filterData = expenses.filter { $0.expenseType == self.filterOpBehavior.value }
            self.settingFilter()
        }).disposed(by: disposeBag)
        
        self.customSegmented.indexSelectedSubjectObservable.subscribe(onNext: { indexButton in
            if indexButton == 0 {
                self.filterOpBehavior.accept(.income)
                return
            }
            self.filterOpBehavior.accept(.expense)
        }).disposed(by: disposeBag)
        
        self.filterOpBehavior.skip(1).subscribe(onNext: { op in
            let elements = self.viewModel.getElements()
            self.filterData = elements.filter { $0.expenseType == op }
            self.settingFilter()
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
    fileprivate func settingFilter() {
        self.collectionViewTransaction.reloadData()
    }
    
    fileprivate func buildHierarchy() {
        view.addSubview(stackBase)
        
        stackBase.addArrangedSubview(stackNav)
        stackNav.addArrangedSubview(buttonBack)
        stackNav.addArrangedSubview(labeltitleNav)
        stackNav.addArrangedSubview(buttonFilter)
        
        stackBase.addArrangedSubview(customSegmented)
        
        stackBase.addArrangedSubview(stackText)
        stackText.addArrangedSubview(labelData)
        stackText.addArrangedSubview(labelTotal)
        
        stackBase.addArrangedSubview(collectionViewTransaction)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackBase.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            buttonBack.widthAnchor.constraint(equalToConstant: 30),
            buttonBack.heightAnchor.constraint(equalToConstant: 30),
            
            buttonFilter.widthAnchor.constraint(equalToConstant: 30),
            buttonFilter.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

// MARK: - extension CollectionViewDelegate
extension TransactionsViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       return
    }
}

// MARK: - extension CollectionViewDataSource
extension TransactionsViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterData.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifierTransaction, for: indexPath) as! TransactionCollectionViewCell
        cell.settingCell(filterData[indexPath.row])
        return cell
    }
}

// MARK: - extension CollectionViewDelegateFlowLayout
extension TransactionsViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 64)
    }
}

