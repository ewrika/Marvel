//
//  Environment.swift
//  Marvel
//
//  Created by Георгий Борисов on 24.11.2024.
//

import Foundation

public enum Environment {
    enum Keys {
        static let apiKey = "API_KEY"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            assertionFailure("Plist file not found")
            return [:]
        }
        return dict
    }()

    static let apiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[Keys.apiKey] as? String else {
            return("Api key not set in plist")
        }
        return apiKeyString
    }()
}
