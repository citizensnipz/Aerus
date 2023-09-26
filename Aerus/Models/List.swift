//
//  List.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/25.
//

import Foundation

var sampleLists: [List] = [
    List(id: 0, name: "Personal", color: "#E59500", tasks: sampleTasks),
    List(id: 1, name: "Work", color: "#840032", tasks: sampleTasks),
    List(id: 2, name: "Family", color: "#FAF8F8", tasks: sampleTasks)
]



struct List: Identifiable {
    let id: Int
    let name: String
    var color: String
    var tasks: [Task]
}

class AllLists: ObservableObject {
    @Published var lists: [List]
    @Published var names: [String] = []
    
    init() {
        self.lists = sampleLists
        createArrayOfNames()
    }
    
    private func createArrayOfNames() {
        for list in lists {
            names.append(list.name)
        }
    }
}
