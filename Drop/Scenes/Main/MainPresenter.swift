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
}

class MainPresenter: MainPresentationLogic {
  weak var viewController: MainDisplayLogic?

  func presentFetchedToday(response: ListToday.FetchToday.Response) {
    if let displayedTodo = response.todo {
        let viewModel = ListToday.FetchToday.ViewModel(displayedTodos: displayedTodo)
      viewController?.displayTodayData(viewModel: viewModel)
    }else{
      print("error")
    }
  }
}
