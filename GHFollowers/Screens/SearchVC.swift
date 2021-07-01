//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 28/06/21.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUserNameEntered: Bool { return !usernameTextField.text!.isEmpty } //propriedade computada, retorna true se o nome foi inputado
    

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground //varia junto com dark e light mode
        
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true) //sendo implementado no viewWillAppear porque tem que sumir toda vez que voltar na pagina de search(viewDidLoad só roda na primeira vez)
    }
    

    func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing)) //selector é o action
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowerListVC(){ //chamado pelo go do teclado ou pelo botao get followers
        guard isUserNameEntered else { //username foi adicionado? se não print e return se sim segue o codigo
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😀.", buttonTitle: "Ok")
            return
        }
        let followerListVC      = FollowerListVC()
        followerListVC.username = usernameTextField.text
        followerListVC.title    = usernameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    // MARK: - UI Configuration

    
    func configureLogoImageView(){
        view.addSubview(logoImageView) //equivalente a arrastar o elemento da biblioteca do storyboard e jogando na tela
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")! //stringly typed (escrita errada quebra com facilidade, mesmo sendo apenas uma letra errada. o ideal é criar constants(como o localizable do SB)
        
        //Constraints
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80), //80 pontos da safearea da view no topo
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), //centro da imagem = centro da view
            logoImageView.heightAnchor.constraint(equalToConstant: 200), //200 pontos de altura
            logoImageView.widthAnchor.constraint(equalToConstant: 200) //200 pontos de largura
        ]) //height, width, x e y. Regra não oficial
    }
    
    
    func configureTextField(){
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        //Constraints
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), //50 pontos pro lado contrario, por isso negativo
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallToActionButton(){
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside) //quando o botao git followers button vai chamar a func pushFollowersListVC
        
        //Constraints
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


}

extension SearchVC: UITextFieldDelegate{ //o delegate espera pra ouvir alguem(nesse caso o textfield)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //funciona quando o botao de return(go) é apertado
        pushFollowerListVC()
        
        return true
    }
    
    
    
}
