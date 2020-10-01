//
//  MainWorker.swift
//  Drop
//
//  Created by Emre Değirmenci on 14.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class MainWorker {

    func fetchTodayInTodos(completion: @escaping (Result<[Todo], Error>) -> ()) {
        if let jsonFilePath = Bundle.main.url(forResource: "todo", withExtension: "json"){
            do {
                let jsonData = try Data(contentsOf: jsonFilePath)
                let decoder = JSONDecoder()
                let todoData = try decoder.decode([Todo].self, from: jsonData)
                completion(.success(todoData))
            } catch {
                completion(.failure(error))
            }
        }
    }

    //MARK: - saveTodoState
    private func saveTodoState(_ isSelected: Bool?)
    {
        UserDefaults.standard.set(isSelected, forKey: "saveTodo")
    }

    //MARK: - getTodoState
    private func getTodoState() -> Bool?
    {
        return UserDefaults.standard.bool(forKey: "saveTodo")
    }
}

