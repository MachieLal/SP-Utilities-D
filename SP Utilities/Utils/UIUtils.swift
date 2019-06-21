//
//  UIUtils.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/4/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import Foundation
import UIKit

public class UIUtils {
    static let sharedInstance = UIUtils()
    
    private init() { } // a perfect singleton in swift
    
    let alarmNavIconImage = UIImage(named: "alarm")
    let menuNavIconImage = UIImage(named: "menu")
    let mapViewNavIconImage = UIImage(named: "map")
    let searchIconImage = UIImage(named: "search")
    let viewPasswordIconImage = UIImage(named: "view")
    let hidePasswordIconImage = UIImage(named: "hide")
    let downloadIconImage = UIImage(named: "download")
    
    let mandatoryAsteriskMark = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    
    lazy var activitySpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(frame: AppConstant.loadingIndicatorDimension)
        spinner.style = .whiteLarge
        spinner.color = UIColor.spBlue
        spinner.hidesWhenStopped = true
        spinner.isHidden = true
        return spinner
    } ()
    
    lazy var dimView: UIView = {
        let dimView = UIView()
        dimView.backgroundColor = UIColor.spGray1
        dimView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return dimView
    }()
    
    func startSpinner(on view: UIView, withShade shaded: Bool = false) {
        guard !view.subviews.contains(activitySpinner) else { return }
        activitySpinner.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height / 2)
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        if shaded {
            view.addSubview(dimView)
            dimView.frame.size = view.frame.size
        }
        view.addSubview(activitySpinner)
        view.isUserInteractionEnabled = false
    }
    
    func stopSpinner(on view: UIView) {
        guard view.subviews.contains(activitySpinner) else { return }
        activitySpinner.stopAnimating()
        if dimView.superview != nil {
            dimView.removeFromSuperview()
        }
        activitySpinner.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }
    
    public func showErrorAlert(message: String, on vc: UIViewController) {
        let alert = UIAlertController(title: "Error".localized(),
                                      message: message.localized(),
                                      preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok".localized(),
                                     style: .default,
                                     handler: nil)
        alert.addAction(okButton)
        vc.present(alert, animated: true, completion: nil)
    }
    
    public func showCustomAlert(title: String, message: String,
                                on vc: UIViewController,
                                cancels: Bool = true,
                                handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok".localized(),
                                     style: .default,
                                     handler: handler)
        alert.addAction(okButton)
        
        if cancels {
            let cancelButton = UIAlertAction(title: "Cancel".localized(),
                                             style: .cancel,
                                             handler: nil)
            alert.addAction(cancelButton)
        }
        vc.present(alert, animated: true, completion: nil)
    }
    
    public func showTextFieldAlert(title: String, message: String, on vc: UIViewController, handler: ((String) -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addTextField { customTextField in
            customTextField.keyboardType = .alphabet
        }

        let okButton = UIAlertAction(title: "Go".localized(), style: .default) { [unowned alert] _ in
            if let text = alert.textFields?.first?.text {
                handler?(text)
            }
        }
        alert.addAction(okButton)
        
        let cancelButton = UIAlertAction(title: "Cancel".localized(),
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(cancelButton)

        vc.present(alert, animated: true, completion: nil)
    }
    
    func setCustomBorderAppearance(onView view: UIView) {
        view.layer.borderColor = UIColor.spBlue.cgColor
        view.layer.borderWidth = 0.8
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
    
    func getAppVersion() -> String {
        var result = ""
        if let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            result += shortVersion
        }
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            result += ".\(version)"
        }
        return result
    }
    
    func getRoundedBadgeButton() -> UIButton {
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        button.layer.borderColor = UIColor.spRed.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = button.bounds.size.height * 0.77
        button.layer.masksToBounds = true
        
        button.backgroundColor = .spRed
        button.setTitle("00", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }
    
}
