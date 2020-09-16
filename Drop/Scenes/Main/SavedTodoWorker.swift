//
//  SavedTodoWorker.swift
//  Drop
//
//  Created by Emre Değirmenci on 16.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

final class SavedTodoWorker {
    let todos = [Int: Bool]()

    func saveTodo(id: Int?, completed: Bool?) -> Bool {
        guard let id = id, let completed = completed else { return false }
        return todos[id] == completed
    }

    func saveID(_ id: Int?) {
        UserDefaults.standard.set(id, forKey: "id")
    }

    func getID() -> Int? {
        return UserDefaults.standard.integer(forKey: "id")
    }
}
