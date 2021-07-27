//
//  User.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 01/07/21.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String? //optional porque pode voltar null, não são obrigatorios no github
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}
