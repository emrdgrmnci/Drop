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

  // Presenter responsible to show wiewmodel data in the view.
  // Sending response which comes from interactor to view controller to present fetched today data
  func presentFetchedToday(response: ListToday.FetchToday.Response) {
    if let displayedTodo = response.todo {
      let viewModel = ListToday.FetchToday.ViewModel(displayedTodo: displayedTodo)
      viewController?.displayTodayData(viewModel: viewModel)
    }else{
      print("error")
    }
  }
}
