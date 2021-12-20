//
//  ToDoListPresenter.swift
//  todo
//
//  Created by xcode on 20.12.2021.
//

import Foundation
final class ToDoListPresenter {
    
    var view: ToDoListDisplayLogic?
    
    init() {}
}

// MARK: - Presentation Logic

extension ToDoListPresenter: ToDoListPresentationLogic {
    func presentLoad(_ response: ToDoListModels.Load.Response) {
        view?.displayLoad(.init(show: response.show))
    }
    
    func presentUpdate(_ response: ToDoListModels.UpdateItems.Response) {
        view?.displayUpdateItem(.init(item: response.item))
    }
    
    func presentCells(_ response: ToDoListModels.FetchItems.Response) {
        view?.displayCells(.init(items: response.items))
    }
    
    func presentError(_ response: ToDoListModels.Error.Response) {
        view?.displayError(.init(title: response.title))
    }
}
