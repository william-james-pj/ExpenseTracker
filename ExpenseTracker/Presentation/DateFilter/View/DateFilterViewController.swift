//
//  DateFilterViewController.swift
//  ExpenseTracker
//
//  Created by Pinto Junior, William James on 01/06/22.
//

import UIKit

protocol DateFilterDelegate {
    func setDate(startDate: Date, endDate: Date)
}

class DateFilterViewController: UIViewController {
    // MARK: - Variable
    var delegate: DateFilterDelegate?
    
    // MARK: - Components
    fileprivate let viewBase: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Card")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewStackAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor(named: "Text")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    fileprivate let stackStart: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelStart: UILabel = {
        let label = UILabel()
        label.text = "Start Date"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let datePickerStart: UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .date
        date.locale = Locale(identifier: "en_US")
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    fileprivate let stackEnd: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelEnd: UILabel = {
        let label = UILabel()
        label.text = "End Date"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let datePickerEnd: UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .date
        date.locale = Locale(identifier: "en_US")
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    // MARK: - Action
    @IBAction func closeButtonTapped() -> Void {
        if let delegate = delegate {
            let dateStartAux = self.datePickerStart.date
            let dateEndAux = self.datePickerEnd.date
            
            delegate.setDate(startDate: newDate(of: dateStartAux), endDate: newDate(of: dateEndAux))
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    fileprivate func newDate(of date: Date) -> Date {
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        let components = calendar.components([.day , .month , .year], from: date)
       
        var dc = DateComponents()
        dc.year = components.year
        dc.month = components.month
        dc.day = components.day

        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        
        if let date = calendar.date(from: dc) {
            return Date.init(timeInterval: 0, since: date)
        }
        return Date()
    }
    
    fileprivate func buildHierarchy() {
        view.addSubview(viewBase)
        viewBase.addSubview(stackBase)
        
        stackBase.addArrangedSubview(stackStart)
        stackStart.addArrangedSubview(labelStart)
        stackStart.addArrangedSubview(datePickerStart)
        
        stackBase.addArrangedSubview(stackEnd)
        stackEnd.addArrangedSubview(labelEnd)
        stackEnd.addArrangedSubview(datePickerEnd)
        
        viewBase.addSubview(buttonClose)
        
//        stackBase.addArrangedSubview(viewStackAux)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            viewBase.widthAnchor.constraint(equalToConstant: 180),
            viewBase.heightAnchor.constraint(equalToConstant: 180),
            viewBase.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewBase.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            stackBase.topAnchor.constraint(equalTo: viewBase.topAnchor, constant: 32),
            stackBase.leadingAnchor.constraint(equalTo: viewBase.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: viewBase.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: viewBase.bottomAnchor, constant: -16),
            
            buttonClose.topAnchor.constraint(equalTo: viewBase.topAnchor, constant: 16),
            buttonClose.trailingAnchor.constraint(equalTo: viewBase.trailingAnchor, constant: -16),
            buttonClose.widthAnchor.constraint(equalToConstant: 20),
            buttonClose.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

}
