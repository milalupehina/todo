//
//  AddItemVC.swift
//  hiDementia
//
//  Created by xcode on 01.12.2021.
//

import UIKit

final class AddItemVC: UIViewController {
    
    private let manager: FirestoreManagerProtocol = FirestoreManager(.pillList)
    
    private lazy var time = String("00:00 AM")
    
    private lazy var blurredView: UIView = {
        let containerView = UIView()
        let blurEffect = UIBlurEffect(style: .light)
        let customBlurEffectView = CustomVisualEffectView(blurEffect, intensity: 0.2)
        customBlurEffectView.frame = self.view.bounds
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.6)
        dimmedView.frame = self.view.bounds
        containerView.addSubview(customBlurEffectView)
        containerView.addSubview(dimmedView)
        return containerView
    }()
    
    private lazy var timeStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            timeTextField,
            timePicker,
        ])
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var vStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            nameLabel,
            quantityLabel,
            timeStackView,
            mealPickerView,
            hStackView
        ])
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .systemBackground
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 16
        stack.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return stack
    }()
    
    private lazy var hStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            sendButton
        ])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var nameLabel: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isScrollEnabled = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var quantityLabel: UITextView = {
        let label = UITextView()
        label.isScrollEnabled = false
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Time of tacking pill:"
        return textField
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 200)
        picker.addTarget(self, action: #selector(self.handler(sender:)), for: UIControl.Event.valueChanged)
        return picker
    }()
    
    private lazy var mealPickerView: MealPickerView = {
        let picker = MealPickerView()
        picker.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 200)
        return picker
    }()
    
    
//    private lazy var priorityButton: UIButton = {
//        let button = UIButton()
//        button.setImage(
//            UIImage(systemName: "tag.circle"),
//            for: .normal
//        )
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(
//            self,
//            action: #selector(openDropDownView),
//            for: .touchUpInside
//        )
//        return button
//    }()
//
//    private lazy var priorityDropDownView: DropDownView = {
//        let view = DropDownView()
//        view.delegate = self
//        return view
//    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "arrow.up.circle"),
            for: .normal
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(sendBtnPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private var bottomLayoutConstraint: NSLayoutConstraint?
    
    private let callback: () -> Void
    
    init(_ callback: @escaping () -> Void) {
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.becomeFirstResponder()
        
        mealPickerView.dataSource = mealPickerView
        mealPickerView.delegate = mealPickerView
        
        setupUI()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIApplication.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIApplication.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func setupUI() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissTap)
        )
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .clear
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
        view.addSubview(vStackView)
        NSLayoutConstraint.activate([
            vStackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            vStackView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        bottomLayoutConstraint = vStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomLayoutConstraint?.isActive = true
        hStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameLabel.placeholder = "Pill name"
        quantityLabel.placeholder = "Pills quantity" //may be implement plus-minus interface
        
    }
    
    // function for geting value from timePicker
    @objc
    private func handler(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        time = timeFormatter.string(from: timePicker.date)
    }
    
    @objc
    private func sendBtnPressed() {
        let item = PillListItem(
            name: nameLabel.text ?? "Undefined",
            time: time,
            quantity: (quantityLabel.text as NSString).floatValue ?? 0,
            meal: mealPickerView.myDataSource[mealPickerView.selectedRow(inComponent: 0)] ?? "Doesn't metter"
        )
        manager.addItem(
            item,
            merge: false) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_):
                    self.dismiss(animated: true)
                    self.callback()
                case .failure(let error):
//                    self.alert(
//                        title: "Oups, ERROR",
//                        desc: error.localizedDescription
//                    )
                    print("Ops")
                }
            }
        //callback(item)
    }
    
    
    
    @objc
    private func dismissTap() {
        dismiss(animated: true)
    }
}

extension AddItemVC {
    
    private func setButtonConstraint(offset: CGFloat) {
        if let constraint = bottomLayoutConstraint {
            view.removeConstraint(constraint)
        }
        bottomLayoutConstraint = vStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -offset)
        bottomLayoutConstraint?.isActive = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard
            let info = notification.userInfo,
            let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            return
        }
        setButtonConstraint(offset: keyboardSize.height)
        view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        setButtonConstraint(offset: 0)
        view.layoutIfNeeded()
    }
}
