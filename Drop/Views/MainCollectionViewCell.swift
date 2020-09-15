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

class MainCollectionViewCell: UICollectionViewCell {

    weak var delegate: CollectionViewUpdater?

    func updateCollectionView() {
      self.delegate?.updateCollectionView()
    }
}
