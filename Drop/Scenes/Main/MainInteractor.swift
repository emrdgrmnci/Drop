//
//  MainInteractor.swift
//  Drop
//
//  Created by Emre Değirmenci on 14.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

protocol MainBusinessLogic {
    func fetchTodayInTodos()
    func saveTodayInTodos()
}

protocol MainDataStore {
}

class MainInteractor: MainBusinessLogic, MainDataStore {
    var presenter: MainPresentationLogic?
    var mainWorker: MainWorker?
    var savedTodoWorker: SavedTodoWorker?
    var todo: [Todo]?

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
//        savedTodoWorker = SavedTodoWorker()
//        savedTodoWorker?.saveTodo(id: <#T##Int?#>, completed: <#T##Bool?#>)
    }
}
