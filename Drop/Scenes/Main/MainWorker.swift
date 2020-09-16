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
    func fetchTodayInTodos(completion: @escaping (Result<[Todo], Error>) -> ()) {
        if let jsonFilePath = Bundle.main.url(forResource: "todo", withExtension: "json"){
            do {
                //Read the raw JSON data from the local file
                let jsonData = try Data(contentsOf: jsonFilePath)

                //Decode the raw data using the typesafe DataModel struct
                let decoder = JSONDecoder()
                let todoData = try decoder.decode([Todo].self, from: jsonData)
                completion(.success(todoData))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func saveTodoState(_ isSelected: Bool?)
    {
        UserDefaults.standard.set(isSelected, forKey: "saveTodo")
    }

    func getTodoState() -> Bool?
    {
        return UserDefaults.standard.bool(forKey: "saveTodo")
    }
}

