//
//  MainTabBarVC.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/4/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit
import RxSwift

class MainTabBarVC: UITabBarController {
    private let disposeBag = DisposeBag()
    
    let viewModel = MainTabBarVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        repositionBadge()
    }
    
    private func setupNavBar() {
        navigationItem.title = viewModel.getTitleForSelectedIndex(TabBarScreenIndex.alarms.rawValue)

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        navigationItem.leftBarButtonItem?.rx.tap.asObservable().bind(onNext: { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
        
        self.rx.didSelect.asObservable()
            .map { _ in return self.selectedIndex}
            .bind(onNext: { [unowned self] index in
                let title = self.viewModel.getTitleForSelectedIndex(index)
                self.navigationItem.title = title
                self.navigationController?.setNavigationBarHidden(title.isEmpty, animated: title.isEmpty)
            }).disposed(by: disposeBag)
    }
    
    // STUPID HACK!!!
    // TO DO: Remove this!!
    // Till Apple gives a SDK API to do this badgeIcon repositioning
    func repositionBadge() {
        tabBar.subviews.forEach { buttonView in
            buttonView.subviews.forEach { (badgeView) in
                if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                    badgeView.layer.transform = CATransform3DIdentity
                    badgeView.layer.transform = CATransform3DMakeTranslation(-40.0, 0.0, 1.0)
                }
            }
        }
    }
}
