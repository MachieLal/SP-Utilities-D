//
//  LoginVC.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/4/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit
import RxSwift

class LoginVC: UIViewController {

    private let viewModel = LoginVM()
    private let disposeBag = DisposeBag()
    private let uiUtils = UIUtils.sharedInstance
    
    @IBOutlet weak var passcodeLabel: UILabel!
    @IBOutlet weak var passcodeTextField: UITextField!
    @IBOutlet weak var getInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupObservables()
        
        passcodeTextField.text = "1122"
        getInButton.sendActions(for: UIControl.Event.touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func setupObservables() {
        
        getInButton.rx.tap.asObservable()
            .map { [weak self] _ in return self?.passcodeTextField.text ?? "" }
            .bind(to: viewModel.fieldValidatorObserver)
            .disposed(by: disposeBag)
        
        viewModel.errorObserver
            .bind { [weak self] message in
                guard let strongSelf = self else { return }
                
                if !message.isEmpty {
                    strongSelf.uiUtils.showErrorAlert(message: message, on: strongSelf)
                    return
                }
                
                strongSelf.performSegue(withIdentifier: AppConstant.showMainTabBarVC, sender: nil)
            }.disposed(by: disposeBag)
        
    }

}
