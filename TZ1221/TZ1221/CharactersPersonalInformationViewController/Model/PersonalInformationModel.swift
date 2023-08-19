//
//  PersonalInformationModel.swift
//  TZ1221
//
//  Created by Stanislav on 17.08.2023.
//

import Foundation

struct PersonalInformationModel {
    

    
    let characterName: String
    let characteStatus: String
    let characterURLImage: String
    let characterInfo: Info
    let characterOrigin: Origin
    let characterEpisodes: Episodes
    
    static var personalInformationList = [PersonalInformationModel]()
    
    static func setupDatainPersonalInformList() {
        let networkService = NetworkService()
        let count = NetworkService.JSONModel.results.count-1
        for i in 0...count {
            guard let characterName = NetworkService.JSONModel.results[i].name else { return }
            guard let characterStatus = NetworkService.JSONModel.results[i].status else { return }
            guard let characterImageURL = NetworkService.JSONModel.results[i].image else { return }
            guard let characterSpecies = NetworkService.JSONModel.results[i].species else { return }
            guard let characterType = NetworkService.JSONModel.results[i].type else { return }
            guard let characterGender = NetworkService.JSONModel.results[i].gender else { return }
            guard let characterPlanet = NetworkService.JSONModel.results[i].origin.name else { return }
            guard let characterPlanetURL = NetworkService.JSONModel.results[i].origin.url else { return }
            guard let characterEpisode = NetworkService.JSONModel.results[i].episode else { return }
            guard let characterEpisode = NetworkService.JSONModel.results[i].episode else { return }
            
            let info = Info(characterSpecies: characterSpecies, characterType: characterType, characterGender: characterGender)
            let origin = Origin(characterPlanet: characterPlanet, characterPlanetURL: characterPlanetURL)
            let episodes = Episodes(characterEpisode: characterEpisode)
            
            let newElement = PersonalInformationModel(characterName: characterName,
                                                      characteStatus: characterStatus,
                                                      characterURLImage: characterImageURL,
                                                      characterInfo: info,
                                                      characterOrigin: origin,
                                                      characterEpisodes: episodes)
            
            personalInformationList.append(newElement)
            
        }
    }
}

struct Info {
    let characterSpecies: String
    let characterType: String
    let characterGender: String
}

struct Origin {
    let characterPlanet: String
    var characterPlanetURL: String
}

struct Episodes {
    var characterEpisode: [String]
}

struct EpisodeInformation {
    let episodeName: String
    let air_date: String
    let episodeNumber: String
}


