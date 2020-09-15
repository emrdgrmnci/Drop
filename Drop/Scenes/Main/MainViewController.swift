//
//  MainViewController.swift
//  Drop
//
//  Created by Emre Değirmenci on 14.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

protocol MainDisplayLogic: class {
    func displayTodayData(viewModel: ListToday.FetchToday.ViewModel)
}

class MainViewController: UIViewController, MainDisplayLogic {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

    var interactor: MainBusinessLogic?

    var displayedData: [Todo] = []
    var displayedTodoData: [Todo] = []

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        fetchTodayInTodos()
    }

    // MARK: Fetch today in the history data
    func fetchTodayInTodos() {
        let request = ListToday.FetchToday.Request()
        interactor?.fetchTodayInTodos(request: request)
    }

    //MARK: - reloadTableView
    fileprivate func reloadTableView() {
        displayedData = displayedTodoData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }

    func displayTodayData(viewModel: ListToday.FetchToday.ViewModel) {

    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    }
}

extension MainViewController: UITableViewDelegate {

}
