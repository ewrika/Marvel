//
//  NetworkManager.swift
//  Marvel
//
//  Created by Георгий Борисов on 24.11.2024.
//

import Foundation
import CryptoKit
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let baseURL = "https://gateway.marvel.com/v1/public/"
    private let publicKey = "821e30f927f46bcbb34c5ccd31b654dd"
    private let privateKey = "\(Environment.apiKey)"

    private func generateHash(timestamp: String) -> String {
        let hashString = "\(timestamp)\(privateKey)\(publicKey)"
        return Insecure.MD5.hash(data: hashString.data(using: .utf8)!)
            .map { String(format: "%02hhx", $0) }
            .joined()
    }

    func fetchCharacters(completion: @escaping (Result<[HeroModel], Error>) -> Void) {
        

        
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = generateHash(timestamp: timestamp)
        let url = "\(baseURL)characters"

        let parameters: Parameters = [
            "ts": timestamp,
            "apikey": publicKey,
            "hash": hash
        ]

        AF.request(url, parameters: parameters).validate().responseDecodable(of: CharacterResponse.self) { response in
            switch response.result {
            case .success(let characterResponse):
                let heroes = characterResponse.data.results.map { character in
                    HeroModel(
                        id: character.id,
                        name: character.name,
                        description: character.description,
                        thumbnail: character.thumbnail
                    )
                }
                completion(.success(heroes))
            case .failure(let error):
                completion(.failure(NetworkError.error))
            }
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case noInternet
    case error

    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "Отсутсвует интернет подключение"
        case .error:
            return "Произошла ошибка, попробуйте позже."
        }
    }
}
