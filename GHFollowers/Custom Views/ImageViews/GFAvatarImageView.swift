//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 12/07/21.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache               = NetworkManager.shared.cache
    let placeholderImage    = Images.placeholder //como esta nos assets ta garantido que não vai ser nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        layer.cornerRadius  = 10 //borda arredondada
        clipsToBounds       = true //precisa para cortar a borda da imagem também
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
