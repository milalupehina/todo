//
//  DropDownView.swift
//  todo
//
//  Created by xcode on 20.12.2021.
//

import Foundation
import UIKit

protocol DropDownViewDelegate: AnyObject {
    //priority
    func didSelect(_ type: ToDoListItem.ItemPriority)
//    func didSelect(_ type: ToDoListItem)//.ItemPriority)
}

final class DropDownView: UIView {
    
    weak var delegate: DropDownViewDelegate?
    
    //priority
    private struct Item {
        
        let type: ToDoListItem.ItemPriority
        let name: String
        let image: UIImage
    }
    
    private let id = "dropCell"
    //priority
    private let items = [
        Item(type: .high, name: "Высокий приоритет", image: UIColor.red.image()),//
        Item(type: .normal, name: "Средний приоритет", image: UIColor.yellow.image()),//
        Item(type: .low, name: "Низкий приоритет", image: UIColor.green.image()),//
//        Item(name: "Высокий приоритет", image: UIColor.red.image()),//type: .high,
//        Item(name: "Средний приоритет", image: UIColor.yellow.image()),//type: .normal,
//        Item(name: "Низкий приоритет", image: UIColor.green.image()),//type: .low,
    ]
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: id)
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        table.clipsToBounds = true
        table.layer.cornerRadius = 16
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DropDownView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as UITableViewCell
        cell.imageView?.image = items[indexPath.row].image
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.superview != nil {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseOut
            ) {
                self.removeFromSuperview()
            }
        }
        //priority
        //delegate?.didSelect(items[indexPath.row].type)
        delegate?.didSelect(items[indexPath.row].type)
    }
}
