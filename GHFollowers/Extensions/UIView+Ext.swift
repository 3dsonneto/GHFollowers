//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 29/07/21.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...){ //... = variatic parameter(posso passar quantas views eu quiser para o addSubviews e transforma em um array)
        for view in views {
            addSubview(view)
        }
    }
    
    func pinToEdges(of superview: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
    }
}
