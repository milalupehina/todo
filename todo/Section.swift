//
//  Section.swift
//  todo
//
//  Created by xcode on 20.12.2021.
//

import Foundation


struct SectionData {
    let title: String
    let data : [String]

    var numberOfItems: Int {
        return data.count
    }

    subscript(index: Int) -> String {
        return data[index]
    }
    
    init(title: String, data: String...) {
        self.title = title
        self.data  = data
    }
}


//Multiple commands produce '/Users/xcode/Library/Developer/Xcode/DerivedData/todo-ejjfbkcsncxdmyfhgtrxomltdudp/Build/Intermediates.noindex/todo.build/Debug-iphonesimulator/todo.build/Objects-normal/arm64/DropDownView.stringsdata':
//1) Target 'todo' (project 'todo') has compile command for Swift source files
//2) Target 'todo' (project 'todo') has compile command for Swift source files
