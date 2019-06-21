//
//  AlarmsCollectionViewCell.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/31/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit

class AlarmsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var alarmsButton: UIButton!
    
    func setup(title value: String) {
        layer.cornerRadius = 20
        alarmsButton.setTitle(value, for: .normal)
    }
}
