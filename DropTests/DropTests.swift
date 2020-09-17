//
//  DropTests.swift
//  DropTests
//
//  Created by Emre Değirmenci on 16.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import XCTest
@testable import Drop

class DropTests: XCTestCase {

    // MARK: — Test lifecycle
    var sut: MainViewController!
    var mainInteractorSpy: MainInteractorSpy!

    override func setUp() {
        super.setUp()
        mainInteractorSpy = MainInteractorSpy()
        sut = MainViewController()
        sut.interactor = mainInteractorSpy as? MainBusinessLogic
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
    }

    func testShouldFetchMoviesWhenViewDidLoad() {
        // When
        sut.viewDidLoad()
        // Then
    }

    func testFetchTodosCallsWorkerToFetch() {
        // Given
        let mainWorkerSpy = MainWorkerSpy()
        let presenterSpy = MainPresenterSpy()
        let sut = MainInteractor()
        sut.mainWorker = mainWorkerSpy
        sut.presenter = presenterSpy
        // When
        sut.fetchTodayInTodos()
        // Then
        XCTAssert(mainWorkerSpy.fetchTodosCalled, "fetchTodos() should ask the worker to fetch todos")
    }

    func testFetchMoviesCallsPresenterToFormatMovies() {
        // Given
        let mainWorkerSpy = MainWorkerSpy()
        let presenterSpy = MainPresenterSpy()
        let sut = MainInteractor()
        sut.mainWorker = mainWorkerSpy
        sut.presenter = presenterSpy
        // When
        sut.fetchTodayInTodos()
        // Then
        XCTAssert(presenterSpy.fetchTodosCalled, "fetchTodos() should ask the presenter to format the movies")
    }

    func testFetchTodosCallsPresenterToFormatFetchedTodos() {
        // Given
        let todos = Seeds.Todos.all
        let presenterSpy = MainPresenterSpy()
        let mainWorkerSpy = MainWorkerSpy(todos: todos)
        let sut = MainInteractor()
        sut.mainWorker = mainWorkerSpy
        sut.presenter = presenterSpy
        // When
        sut.fetchTodayInTodos()
        // Then
        XCTAssertEqual(presenterSpy.todos.count, todos.count, "fetchTodos() should ask the presenter to format the same amount of todos it fetched")
        XCTAssertEqual(presenterSpy.todos, todos, "fetchTodos() should ask the presenter to format the same todos it fetched")
    }

    // MARK: - Tests
    func testDisplayFetchedMoviesCalledByPresenter() {
        // Given
        let viewControllerSpy = ViewControllerSpy()
        let sut = MainPresenter()
        sut.viewController = viewControllerSpy
        let response = ListToday.FetchToday.Response()
        // When
        sut.presentFetchedToday(response: response)
    }

    func testPresentFetchedTodosShouldFormatFetchedTodosForDisplay() {
        // Given
        let todos = Seeds.Todos.all
        let viewControllerSpy = ViewControllerSpy()
        let sut = MainPresenter()
        sut.viewController = viewControllerSpy
        // When
        let response = ListToday.FetchToday.Response()
        sut.presentFetchedToday(response: response)
        // Then
        let displayedTodos = viewControllerSpy.displayedTodos

        XCTAssertEqual(displayedTodos.count, todos.count, "presentFetchedMovies() should ask the view controller to display same amount of movies it receive")

        for (_, displayedTodo) in displayedTodos.enumerated() {
            XCTAssertEqual(displayedTodo.displayedTodos[0].title, "Kahvaltı")
            XCTAssertEqual(displayedTodo.displayedTodos[0].id, 1)
            XCTAssertEqual(displayedTodo.displayedTodos[0].isCompleted, false)
        }
    }

    func testShouldDisplayFetchedTodos() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        let viewModels: [ListToday.FetchToday.ViewModel] = []
        // When
        sut.displayTodayData(viewModel: viewModels.first!)
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched movies should reload the table view")
    }

    func testNumberOfRowsInAnySectionShouldEqualNumberOfTodosToDisplay() {
        // Given
        let tableView = sut.tableView
        let displayedTodos = [Todo(id: 1, title: "Kahvaltı", isCompleted: false)]
        let viewModels: [ListToday.FetchToday.ViewModel] = [ListToday.FetchToday.ViewModel.init(displayedTodos: displayedTodos)]
        sut.displayTodayData(viewModel: viewModels.first!)
        // When
        let numberOfRows = sut.tableView(tableView!,
                                         numberOfRowsInSection: 1)
        // Then
        XCTAssertEqual(numberOfRows, viewModels.count, "The number of tableview rows should equal the number of movies to display")
    }

    func testShouldConfigureTableViewCellToDisplayOrder() {
        // Given
        let tableView = sut.tableView
        let displayedTodos = [Todo(id: 1, title: "Kahvaltı", isCompleted: false)]
        let viewModels: [ListToday.FetchToday.ViewModel] = [ListToday.FetchToday.ViewModel.init(displayedTodos: displayedTodos)]
        sut.displayTodayData(viewModel: viewModels.first!)
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(tableView!, cellForRowAt: indexPath)
            as! MainTableViewCell
        // Then
        XCTAssertEqual(cell.todoTitleLabel.text, "Kahvaltı", "A properly configured table view cell should display the todo title")
    }
}
