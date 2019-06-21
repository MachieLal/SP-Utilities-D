//
//  UserNotificationsManager.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/4/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit
import UserNotifications

class UserNotificationManager: NSObject, UNUserNotificationCenterDelegate {
    private let requestIdentifier = Bundle.main.bundleIdentifier ?? "SP-Utilities"
    let notificationCenter = UNUserNotificationCenter.current()
  
    let app = UIApplication.shared
    let uiUtils = UIUtils.sharedInstance
    
    public func publishNotification(identifier:String, title: String, body: String, time: TimeInterval, repeats: Bool, sound: UNNotificationSound = UNNotificationSound.default) {
        notificationCenter.delegate = self
        
        //notificationCenter.getNotificationSettings { settings in print("DEBUG:::settings\(settings)") }
        // synthesize content
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = ""
        content.body = body
        content.sound = sound
        content.categoryIdentifier = identifier
        content.userInfo["MESSAGE"] = body
        
        // Trigger action
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: repeats)
        
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        //add request to notification center
        notificationCenter.add(request) { requestError in
            if let error = requestError {
                print("DEBUG:::UNNotificationRequest add request error! - \(error.localizedDescription)")
            }
        }
        
        // Set actions and categories
        let snoozeAction = UNNotificationAction(identifier: "SNOOZE", title: "Snooze", options: [.foreground])
        let declineAction = UNNotificationAction(identifier: "DECLINE", title: "Decline", options: [.destructive])
        let category = UNNotificationCategory(identifier: identifier,
                                              actions: [snoozeAction, declineAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.content.categoryIdentifier == "PENDING_WO_CHECKOUT" {
            
            let message = notification.request.content.userInfo["MESSAGE"] as? String ?? ""
            
            print("DEBUG:::willPresent:::\(message)")
            
            notificationCenter.removeDeliveredNotifications(withIdentifiers: [requestIdentifier])
            
            //Action
            handleForegroundReceiptAction(message)
            
            // Play a sound to let the user know about the invitation.
            completionHandler(.sound)
            return
        }
        
        completionHandler(UNNotificationPresentationOptions(rawValue: 0))
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.content.categoryIdentifier == "PENDING_WO_CHECKOUT" {
            
            let message = response.notification.request.content.userInfo["MESSAGE"] as? String ?? ""
            
            notificationCenter.removeDeliveredNotifications(withIdentifiers: [requestIdentifier])
            
            print("DEBUG:::didReceive:::\(message)")
            
            switch response.actionIdentifier {
            case "SNOOZE":
                print("DEBUG:::didReceive:::SNOOZE")
                //Action
                handleBackGroundSnoozeAction(message)
                
            case "DECLINE": // TBD: Handle the Action
                break
                
            case UNNotificationDefaultActionIdentifier,
                 UNNotificationDismissActionIdentifier:
                // TBD: Handle the Action
                break
                
            default:
                break
            }
        }
        
        completionHandler()
    }
    
    private func handleForegroundReceiptAction(_ message: String) {
        showAlert(message: message, forStateActive: true)
    }
    
    private func handleBackGroundSnoozeAction(_ message: String) {
        showAlert(message: message, forStateActive: false)
    }
    
    private func showAlert(message: String, forStateActive isActive: Bool) {
        if let visibleVC = app.delegate?.window??.rootViewController {
            uiUtils.showCustomAlert(title: (isActive ? "Alert" : "SNOOZE").localized(), message: message, on: visibleVC)
        }
    }
    
//    private func getCurrentPendingCheckoutMessage() -> String {
//        var message = ""
//        let wos = workOrderManager.fetchCachedCheckedInWOs()
//        if !wos.isEmpty {
//            let wosCount = wos.count
//            if let firstWO = wos.first {
//                message = "WO \(firstWO.title) is pending for checkout"
//                if wosCount > 1 {
//                    message = "WOs \(firstWO.title) and \(wosCount-1) are pending for checkout"
//                }
//            }
//        }
//        print("DEBUG:::getCurrentPendingCheckoutMessage \(message)")
//
//        return message
//    }
//
//    public func publishForegroundNotication() {
//        disposeBag = DisposeBag()
//        notificationCenter.removePendingNotificationRequests(withIdentifiers: [requestIdentifier])
//
//        // if the user is not logged in, this value is 0 hence no notifications would be shown
//        //        let time = userManager.getLoneWorkerResponseTime()
//        let time = userManager.getLoneWorkerResponseTime() * (60)
//        print("DEBUG:::time tiger \(time)")
//
//        guard time > 1.0 && userManager.shouldMonitorLoneWorker() else { return }
//
//        // manual repeat
//        Observable<Int>.interval(time, scheduler: MainScheduler.asyncInstance)
//            .map { [weak self] _ in return self?.getCurrentPendingCheckoutMessage() ?? "" }
//            .filter { !$0.isEmpty }
//            .bind { message in
//                self.publishNotification(identifier: "PENDING_WO_CHECKOUT", title: "Reminder".localized(), body: message, time: 1.0, repeats: false)
//            }.disposed(by: disposeBag)
//    }
//
//    public func publishBackgroundNotication() {
//        let message = getCurrentPendingCheckoutMessage()
//        guard !message.isEmpty else { return }
//
//        //        let time = userManager.getLoneWorkerResponseTime()
//        let time = userManager.getLoneWorkerResponseTime() * (60)
//        print("DEBUG:::time tiger1 \(time)")
//
//        // time interval should be atleast 60 for repeating trigger; else it will crash!
//        publishNotification(identifier: "PENDING_WO_CHECKOUT", title: "Reminder".localized(), body: message + "!!", time: time < 60.0 ? 60.0 : time, repeats: true)
//    }
    
}
