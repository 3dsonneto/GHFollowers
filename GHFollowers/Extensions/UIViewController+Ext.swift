//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 30/06/21.
//

import UIKit

extension UIViewController{ //foi criado uma extension porque queremos que todos os alerts com esse comportamento
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String){ //nao pode chamar elemento do background thread
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve //fade para aparecer e sumir
            self.present(alertVC, animated: true)
        }
    }
        
}
