//
//  MainTableViewCell.swift
//  Drop
//
//  Created by Emre Değirmenci on 15.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

protocol TableViewUpdater: class {
    func updateTableView()
}

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var todoSwitch: UISwitch!

     weak var delegate: TableViewUpdater?

    override func awakeFromNib() {
        super.awakeFromNib()
        todoTitleLabel.adjustsFontSizeToFitWidth = true
        todoTitleLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(dailyData: Todo) {
        todoTitleLabel.text = dailyData.title
//        todoSwitch.isOn = dailyData.completed
    }

    func updateTableView() {
      self.delegate?.updateTableView()
    }
}
