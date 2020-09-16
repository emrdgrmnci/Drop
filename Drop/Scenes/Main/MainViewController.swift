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

    var switchStates = [Bool]()

    private var selectedRow = -1

    let days = [Day(name: "Monday"),
                Day(name: "Tuesday"),
                Day(name: "Wednesday"),
                Day(name: "Thursday"),
                Day(name: "Friday"),
                Day(name: "Saturday"),
                Day(name: "Sunday")]


    var displayedTodoData: [Todo] = []

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        prepareTableView()
        setup()
        fetchTodayInTodos()

        if switchStates.isEmpty {
            switchStates = UserDefaults.standard.array(forKey: "switchStates") as? [Bool] ?? []
        }

        if switchStates.isEmpty {
            switchStates = (0..<displayedTodoData.count).map { $0 == $0 }
            UserDefaults.standard.set(switchStates, forKey: "switchStates")
        }
    }

    // MARK: Fetch today in the history data
    func fetchTodayInTodos() {
        let request = ListToday.FetchToday.Request()
        interactor?.fetchTodayInTodos(request: request)
    }

    //MARK: - reloadTableView
    fileprivate func reloadTableView() {
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

    //MARK: - switchButtonAction
    @IBAction func switchButton(_ sender: UISwitch) {
        switchStates[sender.tag].toggle()
        UserDefaults.standard.set(switchStates, forKey: "switchStates")
    }
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedTodoData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
        let data = displayedTodoData[indexPath.row]
        print("data: \(data)")
        cell.configureCell(dailyData: data)
        cell.delegate = self
        cell.todoSwitch.isOn = switchStates[indexPath.row]
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
        cell.configureCell(dailyData: data)

        if selectedRow == indexPath.row {
            cell.layer.borderColor = UIColor.blue.cgColor
            cell.layer.cornerRadius = 25
            cell.layer.borderWidth = 1
        }
        else {
            cell.layer.borderWidth = 0
        }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedRow == indexPath.row {
            selectedRow = -1
        } else {
            selectedRow = indexPath.row
        }
        updateCollectionView()
    }
}
