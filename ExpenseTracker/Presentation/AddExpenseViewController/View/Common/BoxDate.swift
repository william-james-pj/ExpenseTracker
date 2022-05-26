//
//  BoxDate.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 26/05/22.
//

import UIKit

class BoxDate: UIView {
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
        image.image = UIImage(systemName: "calendar")
        image.tintColor = UIColor(named: "Disabled")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    fileprivate let datePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .date
        date.locale = Locale(identifier: "en_US")
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    fileprivate let viewDatePickerAux: UIView = {
        let view = UIView()
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
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(viewImageContainer)
        viewImageContainer.addSubview(imageView)
        stackBase.addArrangedSubview(viewDatePickerAux)
        viewDatePickerAux.addSubview(datePicker)
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
            
//            datePicker.widthAnchor.constraint(equalToConstant: 130),
            datePicker.heightAnchor.constraint(equalToConstant: 30),
            datePicker.centerYAnchor.constraint(equalTo: viewDatePickerAux.centerYAnchor),
            datePicker.leadingAnchor.constraint(equalTo: viewDatePickerAux.leadingAnchor),
        ])
    }
    
}
