//
//  ToDoListAssembly.swift
//  todo
//
//  Created by xcode on 20.12.2021.
//

import Foundation
enum ToDoListAssembly {
    static func assembly() -> ToDoListVC {
        let router = ToDoListRouter()
        let presenter = ToDoListPresenter()
        let interactor = ToDoListInteractor(presenter)
        let viewController = ToDoListVC(interactor, router: router)
        
        presenter.view = viewController
        router.view = viewController
        return viewController
    }
}
