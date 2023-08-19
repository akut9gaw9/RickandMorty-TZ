//
//  NetworkService.swift
//  TZ1221
//
//  Created by Stanislav on 17.08.2023.
//

import Foundation
import UIKit
protocol NetworkServiceProtocol: AnyObject {
    func getCharactersData(data: JSONDataModel)
}

class NetworkService {
    
    static var JSONModel = JSONDataModel(results: [])
    weak var delegate: NetworkServiceProtocol?
    
    func getCharactersData() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(JSONDataModel.self, from: data) else { return }
            NetworkService.JSONModel = model
            self.delegate?.getCharactersData(data: model)
        }
        dataTask.resume()
    }
    
    func getData(url: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            completion(data)
        }
        dataTask.resume()
    }
}
