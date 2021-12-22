//
//  ToDoListRouter.swift
//  todo
//
//  Created by xcode on 20.12.2021.
//

import Foundation
import UIKit


final class ToDoListRouter {
    
    weak var view: (ToDoListDisplayLogic & UIViewController)?
    
    init() {}
}

// MARK: - Routing Logic

extension ToDoListRouter: ToDoListRoutingLogic { //Type 'ToDoListRouter' does not conform to protocol 'ToDoListRoutingLogic'
    //fix->
//    func routeToSettings() {
//        <#code#>
//    }
    
    func routeToAddItem(callback: @escaping () -> Void) {
        let vc = AddItemVC(callback)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        view?.present(vc, animated: true)
    }
    
    func routeToSettings() {
        let vc = SettingsVC()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
