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

    let days = [Day(name: "Monday"),
                Day(name: "Tuesday"),
                Day(name: "Wednesday"),
                Day(name: "Thursday"),
                Day(name: "Friday"),
                Day(name: "Saturday"),
                Day(name: "Sunday")]

    var displayedData: [Todo] = []
    var displayedTodoData: [Todo] = []

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        prepareCollectionView()
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

    //MARK: - prepareTableView
    func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        //        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }

    //MARK: - prepareCollectionView
    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    //MARK: - displayTodayData
    func displayTodayData(viewModel: ListToday.FetchToday.ViewModel) {
        displayedTodoData = viewModel.displayedTodos
        reloadTableView()
    }
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
        let data = displayedData[indexPath.row]
        print("data: \(data)")
        cell.configureCell(dailyData: data)
        cell.delegate = self
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {

}

//MARK: - TableViewUpdater
extension MainViewController: TableViewUpdater {
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        let data = days[indexPath.row]
        cell..text = data.name
        //        print("data: \(data)")
        //        cell.configureCell(dailyData: data)
        //        cell.delegate = self
        return cell
    }
}

//MARK: - CollectionViewUpdater
extension MainViewController: CollectionViewUpdater {
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {

}
