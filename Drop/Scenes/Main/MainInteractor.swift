//
//  MainInteractor.swift
//  Drop
//
//  Created by Emre Değirmenci on 14.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

protocol MainBusinessLogic: class {
    func fetchTodayInTodos()
    func saveTodayInTodos()
}

protocol MainDataStore: class {
}

final class MainInteractor: MainBusinessLogic, MainDataStore {
    var presenter: MainPresentationLogic?
    var mainWorker: MainWorker?
    var savedTodoWorker: SavedTodoWorker?
    private var todo: [Todo]?

    func fetchTodayInTodos() {
        mainWorker = MainWorker()
        mainWorker?.fetchTodayInTodos { [weak self] todo in
            guard let self = self else { return }
            switch(todo) {
            case .success(let response):
                let response = ListToday.FetchToday.Response(todo: response)
                self.presenter?.presentFetchedToday(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func saveTodayInTodos() {
        savedTodoWorker = SavedTodoWorker()
        savedTodoWorker?.saveTodo { todo in
            switch(todo) {
            case .success(let response):
                self.presenter?.presentSavedTodoItems(response: response)
            case .failure(_):
                self.presenter?.presentSavedTodoItems(response: [String: Bool]())
            }
        }
    }

    func setCompleted(id: String, completed: Bool) {
        savedTodoWorker?.setCompleted(id: id, completed: completed)
    }
}
