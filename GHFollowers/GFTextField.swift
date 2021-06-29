//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 29/06/21.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth  = 2
        layer.borderColor  = UIColor.systemGray4.cgColor
        
        textColor     = .label //preto em light mode e branco em dark mode
        tintColor     = .label
        textAlignment = .center
        font          = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true //fonte diminui a depender da quantidade
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no //sem autocorrect porque é com username
        
        placeholder = "Enter a username"
    }
    
}
