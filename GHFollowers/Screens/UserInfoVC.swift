//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 20/07/21.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        print(username)
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }

}
