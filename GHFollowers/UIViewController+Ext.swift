//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 30/06/21.
//

import UIKit

extension UIViewController{
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String){ //nao pode chamar elemento do background thread
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
        
}
