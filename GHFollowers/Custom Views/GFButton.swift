//
//  GFButton.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 29/06/21.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) { //fazendo override do init porque vai ser um elemento custom
        super.init(frame: frame) //chama a superclasse(o init normal dentro do uibutton com as coisas padrao, ou seja, o GFButton herda as coisas do UIButton padrão) e depois vai o custom code
        
        //custom code
        configure()
    }
    
    required init?(coder: NSCoder) { //usado caso seja implementado com storyboard
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){ //private so pode ser chamado nessa classe
        layer.cornerRadius                         = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font                           = UIFont.preferredFont(forTextStyle: .headline) //dynamic type(se o aplicativo usa dynamic type significa que o tamanho da fonte vai                                                           mudar a depender da config do usuario, sem isso não funciona(da pra ver nas configs do iphone))
        translatesAutoresizingMaskIntoConstraints  = false //determina que autolayout vai ser usado
        
    }
    

}
