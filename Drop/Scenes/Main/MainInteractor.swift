//
//  MainInteractor.swift
//  Drop
//
//  Created by Emre Değirmenci on 14.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

protocol MainBusinessLogic {
    func fetchTodayInTodos(request: ListToday.FetchToday.Request)
    func saveTodayInTodos(response: ListToday.FetchToday.Response)
}

protocol MainDataStore {
}

class MainInteractor: MainBusinessLogic, MainDataStore {

    var presenter: MainPresentationLogic?
    var mainWorker: MainWorker?
    var todo: [Todo]?

    func fetchTodayInTodos(request: ListToday.FetchToday.Request) {
        mainWorker = MainWorker()
        mainWorker?.fetchTodayInTodos(completion: {(todo, err) in
            self.todo = todo
            let response = ListToday.FetchToday.Response(todo: todo)
            self.presenter?.presentFetchedToday(response: response)
        })
    }

    func saveTodayInTodos(response: ListToday.FetchToday.Response) {
        mainWorker = MainWorker()
        mainWorker?.saveTodoState(response.todo?.first?.completed)
    }
}
