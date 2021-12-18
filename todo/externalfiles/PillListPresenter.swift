//
//  PillListPresenter.swift
//  hiDementia
//
//  Created by xcode on 29.11.2021.
//

final class PillListPresenter {
//MARK: protocols models
     var view: PillListDisplayLogic?

     init() {}
 }

 // MARK: - Presentation Logic

 extension PillListPresenter: PillListPresentationLogic {
     func presentLoad(_ response: PillListModels.Load.Response) {
          view?.displayLoad(.init(show: response.show))
      }
     
     func presentUpdate(_ response: PillListModels.UpdateItems.Response) {
         view?.displayUpdateItem(.init(item: response.item))
     }

     func presentCells(_ response: PillListModels.FetchItems.Response) {
         view?.displayCells(.init(items: response.items))
     }

     func presentError(_ response: PillListModels.Error.Response) {
         view?.displayError(.init(title: response.title))
     }
 }
