//
//  Match.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

struct Match: Decodable {
    let beginAt: String?
    let opponents: [OpponentMain]?
    let league: League?
    let serie: Serie?
    
    private enum CodingKeys: String, CodingKey {
        case beginAt = "begin_at"
        case opponents
        case league
        case serie
    }
}

// MARK: Inner objects of a Match

struct OpponentMain: Decodable {
    let opponent: Opponent?
}

struct Opponent: Decodable {
    let acronym: String?
    let name: String?
    let imageUrl: String?
    let id: Int?
    
    private enum CodingKeys: String, CodingKey {
        case acronym
        case name
        case imageUrl = "image_url"
        case id
    }
}

struct League: Decodable {
    let name: String?
    let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
    }
}

struct Serie: Decodable {
    let fullName: String?
    
    private enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}
