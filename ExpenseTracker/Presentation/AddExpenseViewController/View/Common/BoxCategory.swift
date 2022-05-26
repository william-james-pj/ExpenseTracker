//
//  BoxCategory.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 25/05/22.
//
import UIKit

class BoxCategory: UIView {
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
        image.image = UIImage(systemName: "book.fill")
        image.tintColor = UIColor(named: "Disabled")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    fileprivate let pullDownButton: UIButton = {
        let button = UIButton()
        button.showsMenuAsPrimaryAction = true
        
        button.setTitle("Category", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(UIColor(named: "Text"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func setActionButton(to actionTitle: [String]) {
        var actions: [UIAction] = []
        
        for title in actionTitle {
            let action = UIAction(title: title) { _ in
                self.pullDownButton.setTitle(title, for: .normal)
            }
            actions.append(action)
        }
        self.pullDownButton.menu = UIMenu(title: "", children: actions)
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(viewImageContainer)
        viewImageContainer.addSubview(imageView)
        stackBase.addArrangedSubview(pullDownButton)
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
