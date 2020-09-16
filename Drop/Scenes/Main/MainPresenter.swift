//
//  MainPresenter.swift
//  Drop
//
//  Created by Emre Değirmenci on 14.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

protocol MainPresentationLogic {
    func presentFetchedToday(response: ListToday.FetchToday.Response)
    func presentSavedTodoItems(response: [String: Bool])
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?

    var savedTodoItems = [String: Bool]()

    func presentFetchedToday(response: ListToday.FetchToday.Response) {
        if let displayedTodo = response.todo {
            let viewModel = ListToday.FetchToday.ViewModel(displayedTodos: displayedTodo)
            viewController?.displayTodayData(viewModel: viewModel)
        } else {
            print("error")
        }
    }

    func presentSavedTodoItems(response: [String : Bool]) {
        savedTodoItems = response
    }
}
