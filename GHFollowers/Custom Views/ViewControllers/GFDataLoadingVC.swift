//
//  GFDataLoadingVC.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 27/07/21.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    
    var containerView: UIView!   //private = no escopo da classe, fileprivate = tudo nesse arquivo pode usar essa variable | nesse caso é uma variavel global, mas por ser fileprivate só pode ser acessado nesse arquivo

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }

    }
    
    
    func showEmptyStateView(with message: String, in view: UIView){ //view pra saber onde vai aplicar os constraints e qual view vai adicionar o subview
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds //preenche a tela toda
        view.addSubview(emptyStateView)
        
    }

}
