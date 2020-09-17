//
//  MockMainPresenter.swift
//  DropTests
//
//  Created by Emre Değirmenci on 17.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
@testable import Drop

// MARK: - Test doubles
class ViewControllerSpy: MainDisplayLogic {
    var displayFetchedTodosCalled = false
    var displayedTodos: [ListToday.FetchToday.ViewModel] = []

    func displayTodayData(viewModel: ListToday.FetchToday.ViewModel) {
        displayFetchedTodosCalled = true
        displayedTodos = [viewModel]
    }

    func displaySavedData(viewModel: ListToday.FetchToday.ViewModel) { }
}

class MainPresenterSpy: MainPresenter {
    var fetchTodosCalled = false
    var todos: [Todo]
    init(todos : [Todo] = []) {
        self.todos = todos
    }
}
