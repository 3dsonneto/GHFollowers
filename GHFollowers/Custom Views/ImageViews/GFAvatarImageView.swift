//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 12/07/21.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache               = NetworkManager.shared.cache
    let placeholderImage    = UIImage(named: "avatar-placeholder")! //como esta nos assets ta garantido que não vai ser nil

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
    
    func downloadImage(from urlString: String){ //não lida com erros aqui pois ja tem o placeholder que representa erros, alem de que caso seja um erro pra cada cell vai ficar com varios erros de uma vez só
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){ //se ja temos a imagem em cache
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return } //nao fizemos a chamada no network manager porque la tem o padrao de lidar com o erro, coisa que nao fizemos aqui
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }

}
