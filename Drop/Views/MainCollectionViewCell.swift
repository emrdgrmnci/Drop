//
//  MainCollectionViewCell.swift
//  Drop
//
//  Created by Emre Değirmenci on 15.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

protocol CollectionViewUpdater: class {
    func updateCollectionView()
}

final class MainCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var dayLabel: UILabel!

    weak var delegate: CollectionViewUpdater?

    func configureCell(dailyData: Day) {
        dayLabel.text = dailyData.name
    }

    func updateCollectionView() {
      self.delegate?.updateCollectionView()
    }
}
