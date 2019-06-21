//
//  AlarmsVC.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/17/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit

class AlarmsVC: UIViewController {

    private let utils = UIUtils.sharedInstance
    let viewModel = AlarmsVM()
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var alarmTabBarItem: UITabBarItem! {
        didSet {
            alarmTabBarItem.image = utils.alarmNavIconImage?.customResized(to: 0.25)
            updateAlarmTabBarItemBadge(for: viewModel.alarms)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        viewModel.alarmsObserver = { [weak self] alarms in
            self?.updateAlarmTabBarItemBadge(for: alarms)
        }
        
        viewModel.populateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupAddAlarmButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "presentAlarmDetails":
            if let destinationVC = segue.destination as? AlarmDetailsVC {
                destinationVC.modalPresentationStyle = .popover
                destinationVC.preferredContentSize = CGSize(width: view.bounds.size.width * 0.90,
                                                            height: view.bounds.size.height * 0.75)
                if let popOverController = destinationVC.popoverPresentationController,
                    let sourceView = tabBarController?.navigationItem.rightBarButtonItem?.customView {
                    popOverController.delegate = self
                    popOverController.sourceView = sourceView
                    popOverController.sourceRect = sourceView.bounds
                    popOverController.canOverlapSourceViewRect = false
                    popOverController.backgroundColor = .spGreen
                }
                if let titleText = sender as? String {
                    destinationVC.viewModel.title = titleText
                }
            }
        default:
            break
        }
    }
    
    private func setupAddAlarmButton() {
        let addAlarmbutton = UIButton(type: .contactAdd)
        addAlarmbutton.addTarget(self, action: Selector(("handleAddAlarmButtonAction")), for: UIControl.Event.touchUpInside)
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addAlarmbutton)
    }
    
    private func updateAlarmTabBarItemBadge(for list: [String]) {
        alarmTabBarItem.badgeValue = "\(list.count)"
        alarmTabBarItem.badgeColor = list.isEmpty ? .blue : .red
    }
    
    @objc func handleAddAlarmButtonAction() {
        utils.showTextFieldAlert(title: "Alert".localized(), message: "Do you want to add a new ⏰? \n Yes? \n Give a name 😃".localized(), on: self) { [weak self] fieldText in
            self?.performSegue(withIdentifier: "presentAlarmDetails", sender: fieldText)
        }
    }
}

extension AlarmsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.alarms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alarmsCollectionViewCell", for: indexPath) as! AlarmsCollectionViewCell
        
        cell.setup(title: viewModel.alarms[indexPath.row])
        return cell
    }
    
}

extension AlarmsVC: UICollectionViewDelegate {

}

extension AlarmsVC: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - UIPopoverControllerDelegate methods.
extension AlarmsVC: UIPopoverPresentationControllerDelegate {
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        print("Popover dismissed")
    }
    
}
