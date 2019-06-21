//
//  MenuSVC.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/16/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit

class MenuSVC: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("is Collapsed \(isCollapsed)")
        print("display mode \(displayMode.rawValue)")

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MenuSVC: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        print("P \(primaryViewController)... S \(secondaryViewController)")
        if let primary = viewControllers.first as? UINavigationController {
            print("Navigation stack \(primary.viewControllers)")
            return true
        }
        
        return false
        
    }

}
