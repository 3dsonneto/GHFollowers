//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 30/06/21.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat){
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold) //Titulo sempre vai ser grande e bold
    }
    
    private func configure(){
        textColor                                  = .label
        adjustsFontSizeToFitWidth                  = true
        minimumScaleFactor                         = 0.9
        lineBreakMode                              = .byTruncatingTail //quebra a linha grande no final, bota um ...
        translatesAutoresizingMaskIntoConstraints  = false
    }

}
