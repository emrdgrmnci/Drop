//
//  MockTableView.swift
//  DropTests
//
//  Created by Emre Değirmenci on 17.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit.UITableView

class TableViewSpy: UITableView {
    var reloadDataCalled = false
    override func reloadData() {
         reloadDataCalled = true
    }
}
