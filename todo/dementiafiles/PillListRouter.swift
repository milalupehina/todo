//
//  PillListRouter.swift
//  hiDementia
//
//  Created by xcode on 29.11.2021.
//

import UIKit


 final class PillListRouter {

     weak var view: (PillListDisplayLogic & UIViewController)?

     init() {}
 }

 // MARK: - Routing Logic

 extension PillListRouter: PillListRoutingLogic {
     func routeToAddItem(callback: @escaping () -> Void) {
         let vc = AddItemVC(callback)
         vc.modalPresentationStyle = .formSheet
         view?.present(vc, animated: true)
     }

     func routeToSettings() {
         let vc = UIViewController()
         view?.navigationController?.pushViewController(vc, animated: true)
     }
 }
