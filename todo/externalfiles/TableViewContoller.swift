//
//  TableViewContoller.swift
//  hiDementia
//
//  Created by xcode on 01.12.2021.
//

import UIKit
import FirebaseInAppMessagingSwift
//MARK: pilllistcell
 class TableViewController<Model, Cell: PillListCell>: UITableViewController {

     var items: [Model]
     var configure: (Cell, Model) -> Void
     var didTap: (Cell) -> Cell

     init(
         _ items: [Model],
         configure: @escaping(Cell, Model) -> Void,
         didTap: @escaping(Cell) -> Cell
     ) {
         self.items = items
         self.configure = configure
         self.didTap = didTap
         super.init(style: .plain)
         self.tableView.register(Cell.self, forCellReuseIdentifier: String(describing: Cell.self))
         self.tableView.rowHeight = UITableView.automaticDimension
     }

     @available(*, unavailable)
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         items.count
     }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PillListCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as? Cell
         else {
             return PillListCell()
         }
         configure(cell, items[indexPath.row])
         cell.delegate = self
         return cell
     }

     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         Cell.checkButtonTapped(<#T##self: PillListCell##PillListCell#> as! Cell)
     }
 }

extension TableViewController: PillListCellDelegate {
    func didTapButton(in cell: PillListCell) {
        print("Was tapped!!!")
    }
    
    
}
