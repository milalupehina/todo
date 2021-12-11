//
//  ViewController.swift
//  todo
//
//  Created by xcode on 08.12.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

/*
 view for presentation smth in the first (called) launch
 */


/*
 model - data
 модель - часть? содержащая в себе функциональную бизнес логику приложения
 не знает об элеменентах и как они отображаются
 - бизнес-логика
 - знания только о себе , нет понятия о контроллерах и представлениях
 - мб слой данных (база данных, xml)
 - обычно менеджер бд, набор объектов или логика приложения
*/

/*
 view - ui
 view представление
 отображение данных модели
 не может напрямуб влиять на модель
 (только чтение данных)
 - реализуется отображение данных, полученных любым путем от модели
 - мб код реализации бизнес-логики
 */

/*
 controller - logic
 контроллер
 - опроеделяет, какие представления должны быть отображены в данный момент
 - события представления могут повлеять только на контроллер. контроллер может повлиять на модель и определить другое представление
 - возможно несколько представлений для одного контроллера
 */

/*
 Components of MVC
 Model – Model is a wrapper which hold the data.
 View – Representation of UI or Views in the hierarchy.
 Controller – Controller act as a mediator between view and model and hold the business logics.
 */
