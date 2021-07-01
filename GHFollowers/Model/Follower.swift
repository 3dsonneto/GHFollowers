//
//  Follower.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 01/07/21.
//

import Foundation

struct Follower: Codable {
    var login: String //não é opcional porque para o usuario existir tem que ter um login, e o avatar nunca volta null, porque o github coloca um placeholder se n tiver avatar
    var avatarUrl: String //por boas praticas o swift usa cammelCase em vez de snake_case, a resposta da api é avatar_url, mas o swift consegue converter usando avatarUrl
}
