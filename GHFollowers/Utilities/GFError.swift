//
//  GFError.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 20/07/21.
//

import Foundation

enum GFError: String, Error { //string é raw value(todos os cases conformam a esse tipo) ao contrario de associated value(cada caso tem seu tipo)
    
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request, please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them."
}
