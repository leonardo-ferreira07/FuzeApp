//
//  Team.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

struct Team: Decodable {
    let players: [Player]?
}

struct Player: Decodable {
    let firstName: String?
    let lastName: String?
    let name: String?
    let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case name
        case imageUrl = "image_url"
    }
}
