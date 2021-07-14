//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 13/07/21.
//

import UIKit

struct UIHelper{
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout { //static pra na chamada ser UIHelper.createThree...
        let width                       = view.bounds.width //largura total da tela
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40) //altura + espaco da label
        
        
        
        return flowLayout
    }
    
}
