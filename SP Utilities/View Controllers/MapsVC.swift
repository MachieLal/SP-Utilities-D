//
//  MapsVC.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/17/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MapKit

class MapsVC: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let utils = UIUtils.sharedInstance
    let viewModel = MapsVM()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var mapTabBarItem: UITabBarItem! {
        didSet {
            mapTabBarItem.image = utils.mapViewNavIconImage?.customResized(to: 0.25)
            mapTabBarItem.selectedImage = mapTabBarItem.image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.navigationItem.rightBarButtonItem = nil
    }

}
