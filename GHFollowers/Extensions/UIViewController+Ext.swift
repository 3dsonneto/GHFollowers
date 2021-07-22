//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 30/06/21.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!   //private = no escopo da classe, fileprivate = tudo nesse arquivo pode usar essa variable | nesse caso é uma variavel global, mas por ser fileprivate só pode ser acessado nesse arquivo

extension UIViewController{ //foi criado uma extension porque queremos que todos os alerts com esse comportamento
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String){ //nao pode chamar elemento do background thread
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve //fade para aparecer e sumir
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(with url: URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }

    }
    
    
    func showEmptyStateView(with message: String, in view: UIView){ //view pra saber onde vai aplicar os constraints e qual view vai adicionar o subview
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds //preenche a tela toda
        view.addSubview(emptyStateView)
        
    }
        
}
