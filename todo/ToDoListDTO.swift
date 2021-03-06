//
//  ToDoListDTO.swift
//  todo
//
//  Created by xcode on 20.12.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

//priority

struct ToDoListItem: Codable {
    @DocumentID var id: String? = UUID().uuidString
    let title: String
    let description: String
    let imageName: String?
    let time: String
    let priority: ItemPriority
    
    enum ItemPriority: String, Codable, CaseIterable {
        case low
        case normal
        case high
    }
}

extension ToDoListItem {
    static func prototype() -> ToDoListItem {
        ToDoListItem(
            id: nil,
            title: "",
            description: "",
            imageName: nil,
            time: "",
            priority: .normal
        )
    }
}
