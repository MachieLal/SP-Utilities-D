//
//  ContentDetailsVC.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/19/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit

class ContentDetailsVC: UIViewController {

    let viewModel = ContentDetailsVM()
    let messages = ""
    
    @IBOutlet weak var demarkationLabel: UILabel! {
        didSet {
            if !viewModel.viewStateTitle.isEmpty {
                demarkationLabel.text = "I am in \(viewModel.viewStateTitle)"
                
                if viewModel.viewStateTitle.hasPrefix("Motion") {
                    MotionSensorManager.sharedInstance.startDeviceMotionUpdates()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        MotionSensorManager.sharedInstance.stopDeviceMotionUpdates()
    }

}
