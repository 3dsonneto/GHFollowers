//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 02/08/21.
//

import UIKit

extension UITableView{
    
    func reloadDataOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
}
