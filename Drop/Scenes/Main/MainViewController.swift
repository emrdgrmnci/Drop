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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    func displayTodayData(viewModel: ListToday.FetchToday.ViewModel) {

    }
}
