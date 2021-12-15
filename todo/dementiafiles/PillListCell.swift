//
//  PillListCell.swift
//  hiDementia
//
//  Created by xcode on 29.11.2021.
//

import UIKit

protocol PillListCellDelegate: class {
    func didTapButton(in cell: PillListCell)
}

final class PillListCell: UITableViewCell {
    
    static let id = "PillListCell"
    
    weak var delegate: PillListCellDelegate?
    
    var model: PillListItem? {
        didSet {
            nameLabel.text = model?.name
            timeLabel.text = model?.time
            quantityLabel.text = "\(model?.quantity)".replacingOccurrences(of: "[^\\.\\d+]", with: "", options: [.regularExpression])
            mealLabel.text = model?.meal
        }
    }
    private lazy var checkBox: UIButton = {
        let checkBox = UIButton()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.setImage(UIImage(systemName: "circle"), for: .normal)
        checkBox.layer.cornerRadius = 0.5 * checkBox.bounds.size.width
        checkBox.clipsToBounds = true
        checkBox.frame = CGRect(x: 15, y: -50, width: 10, height: 10)
        checkBox.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return checkBox
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var mealLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
               timeLabel,
               quantityLabel,
               mealLabel
            ]
        )
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var hStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
               nameLabel,
               vStackView
            ]
        )
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var vMainStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                checkBox,
                hStackView
            ]
        )
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private func setupUI() {
//        addSubview(vStackView)
//        vStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        vStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        vStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        vStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        addSubview(vMainStackView)
        vMainStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        vMainStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        vMainStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        vMainStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
//        leftImageView.widthAnchor.constraint(equalTo: heightAnchor).isActive = true
//        priorityView.widthAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var buttonIsTapped = false
    
    @objc
    func checkButtonTapped() {
        delegate?.didTapButton(in: self)
//        print("Tapped")
//        if buttonIsTapped {
//            checkBox.setImage(UIImage(systemName: "circle"), for: .normal)
//            nameLabel.textColor = .black
//            timeLabel.textColor = .black
//            quantityLabel.textColor = .black
//            mealLabel.textColor = .black
//            buttonIsTapped = false
//        } else {
//            checkBox.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
//            nameLabel.textColor = .systemGray
//            timeLabel.textColor = .systemGray
//            quantityLabel.textColor = .systemGray
//            mealLabel.textColor = .systemGray
//            buttonIsTapped = true
//
//        }
     }
}
