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
}

protocol MainDataStore {
}

class MainInteractor: MainBusinessLogic, MainDataStore {
    var presenter: MainPresentationLogic?
    var mainWorker: MainWorker?
    var todo: Todo?

    func fetchTodayInHistory(request: ListToday.FetchToday.Request) {
        mainWorker = MainWorker()
        mainWorker?.fetchTodayInTodos(completion: { (today, err) in
            self.today = today
            let response = ListToday.FetchToday.Response(today: today)
            //        print(response)
            self.presenter?.presentFetchedToday(response: response)
        })
    }
}
