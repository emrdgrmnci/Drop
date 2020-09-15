//
//  MainWorker.swift
//  Drop
//
//  Created by Emre Değirmenci on 14.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class MainWorker {
    // Worker function to retrive todo data from local json file
    func fetchTodayInTodos(completion: @escaping (Todo, Error?) -> ()) {
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "todo", withExtension: "json")!)
            let decoder = JSONDecoder()
            let todoData = try decoder.decode(Todo.self, from: data)
            completion(todoData, nil)
        } catch let error {
            print("Error", error)
        }
    }
}

