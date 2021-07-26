//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 28/06/21.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        PersistanceManager.retrieveFavorites { result in
            switch result{
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }
    


}
