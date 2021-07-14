//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 01/07/21.
//

import UIKit

class NetworkManager {
    static let shared           = NetworkManager() //static = todos os networkmanagers vao ter essa variavel
    private let baseURL         = "https://api.github.com/users/"
    let cache                   = NSCache<NSString, UIImage>()
    
    private init() {} //so pode ter uma instancia, por isso o private init
    
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {     //for username - argument labels, completed(completion handler) - retorna uma lista de followers ou a string de erro(do enum) | Implementando o Result enum ele retorna um case de success(array de followers) e um case de erro(GFError) e ao implementar o completion handler não preciso passar os dois de uma vez, ja que não são mais optionals
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else { //se ta valido retorna o url, senao retorna erro
            completed(.failure(.invalidUsername)) // completion handler da funcao(foi completado, entao tem que passar array de followers ou string de erro)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error{ //se o erro existir(_ porque nao estamos nomeando a variavel(nao vamos usar), so checando se existe ou não
                completed(.failure(.unableToComplete)) //completion handler da funcao get followers(nil porque tem erro(string))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{ //mesmo nome porque estamos criando uma variavel para usar fora do escopo do guard let  |  se a response nao for nil guarda em response e se a response nao é nil verifica o status code
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data) //tenta decodar, queremos um array de follower de data
                completed(.success(followers))
            } catch { //se o try falhar
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
