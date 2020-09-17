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

final class MainTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var todoSwitch: UISwitch!

    //MARK: - Class Properties
    var defaults = UserDefaults.standard

    weak var delegate: TableViewUpdater?

    override func awakeFromNib() {
        super.awakeFromNib()
        todoTitleLabel.adjustsFontSizeToFitWidth = true
        todoTitleLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK: - switchButtonAction
    @IBAction func switchButton(_ sender: UISwitch) {
        if sender.isOn {
            todoSwitch.isOn = true
        } else {
            todoSwitch.isOn = false
        }
    }

    //MARK: - configureCell
    func configureCell(data: Todo) {
        todoTitleLabel.text = data.title
    }

    //MARK: - updateTableView
    func updateTableView() {
        self.delegate?.updateTableView()
    }
}
