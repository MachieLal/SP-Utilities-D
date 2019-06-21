//
//  LoginVM.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/4/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginVM {
    private let disposeBag = DisposeBag()
    
    let fieldValidatorObserver = PublishSubject<String>()
    let errorObserver = PublishSubject<String>()

    required init() {
        fieldValidatorObserver.asObservable()
            .bind { [weak self] value in
                if value.isEmpty {
                    self?.errorObserver.onNext("Empty field!!!")
                    return
                }
                
                if value.count != 4 {
                    self?.errorObserver.onNext("Invalid code. Please enter the code of 4 digits.")
                    return
                }

                let newValue = value.trimmingCharacters(in: CharacterSet.decimalDigits)
                if !newValue.isEmpty {
                    self?.errorObserver.onNext("Only English Decimal Digits!!")
                    return
                }
                
                if value != "1122" {
                    self?.errorObserver.onNext("Wrong passcode!!!")
                    return
                }
                self?.errorObserver.onNext("")
        }.disposed(by: disposeBag)
    }

}
