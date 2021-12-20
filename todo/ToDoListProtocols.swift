//
//  ToDoListProtocols.swift
//  todo
//
//  Created by xcode on 20.12.2021.
//

import Foundation
protocol ToDoListDisplayLogic: AnyObject {
    func displayCells(_ viewModel: ToDoListModels.FetchItems.ViewModel)
    func displayUpdateItem(_ viewModel: ToDoListModels.UpdateItems.ViewModel)
    func displayError(_ viewModel: ToDoListModels.Error.ViewModel)
    func displayLoad(_ viewModel: ToDoListModels.Load.ViewModel)
}


// MARK: ToDoListBusinessLogic -> ToDoListInterpretator
protocol ToDoListBusinessLogic: AnyObject {
    func fetchItems(_ request: ToDoListModels.FetchItems.Request)
}

protocol ToDoListPresentationLogic: AnyObject {
    func presentLoad(_ response: ToDoListModels.Load.Response)
    func presentError(_ response: ToDoListModels.Error.Response)
    func presentCells(_ response: ToDoListModels.FetchItems.Response)
    func presentUpdate( _ response: ToDoListModels.UpdateItems.Response)
}

protocol ToDoListRoutingLogic: AnyObject {
    func routeToAddItem(callback: @escaping () -> Void)
    func routeToSettings()
}

protocol ToDoListWorkerProtocol: AnyObject {
    func fetchItems(
        parameter: String,
        action: ToDoListModels.ItemAction,
        completion: @escaping (Result<[ToDoListItem], Error>) -> Void
    )
}
