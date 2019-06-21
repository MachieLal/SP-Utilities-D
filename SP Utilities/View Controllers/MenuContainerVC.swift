//
//  MenuContainerVC.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/18/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit

class MenuContainerVC: UIViewController {

    private let utils = UIUtils.sharedInstance
    
    @IBOutlet weak var menuContainerTabBarItem: UITabBarItem! {
        didSet {
            menuContainerTabBarItem.image = utils.menuNavIconImage?.customResized(to: 0.25)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
