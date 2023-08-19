//
//  JSONDataModel.swift
//  TZ1221
//
//  Created by Stanislav on 17.08.2023.
//

import Foundation

struct JSONDataModel: Codable {
    let results: [CharactersDataModel]
}

struct CharactersDataModel: Codable {
    let name: String?
    let status: String?
    let species: String?
    let gender: String?
    let image: String?
    let type: String?
    let origin: CharacterOriginDataModel
    let episode: [String]?
}

struct CharacterOriginDataModel: Codable {
    let name: String?
    let url: String?
}

struct PlanetDataModel: Codable {
    let type: String?
}

struct EpisodeDataModel: Codable  {
    let name: String?
    let air_date: String?
    let episode: String?
}
