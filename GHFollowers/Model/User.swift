//
//  User.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 01/07/21.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String? //optional porque pode voltar null, não são obrigatorios no github
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
