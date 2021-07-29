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
}
