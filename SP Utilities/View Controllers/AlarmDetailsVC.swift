//
//  AlarmDetailsVC.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 6/1/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit

class AlarmDetailsVC: UIViewController {

    let viewModel = AlarmDetailsVM()
    
    @IBOutlet weak var viewTitle: UILabel! {
        didSet {
            viewTitle.backgroundColor = .spGreen
            viewTitle.text = viewModel.title
        }
    }
    @IBOutlet weak var detailsScrollView: UIScrollView!
    @IBOutlet weak var detailsScrollContentStackView: UIStackView!
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var locationPicker: UIPickerView!
    
    @IBAction func panHandler(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true) {
            print("alarmDetailsVC dismissed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObserverActions()
    }
    
    private func setupObserverActions() {
        viewModel.titleObserver = { [weak self] text in
            self?.viewTitle.text = text
        }
    }
}

extension AlarmDetailsVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.locations.count
    }
    
}

extension AlarmDetailsVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.locations[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("DEBUG---location picker selected value - \(viewModel.locations[row])")
    }
}
