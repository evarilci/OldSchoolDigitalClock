//
//  WeatherResponse.swift
//  neonWatch
//
//  Created by Eymen Varilci on 29.01.2025.
//


struct WeatherResponse: Decodable {
    let currentObservation: CurrentObservation
    
    enum CodingKeys: String, CodingKey {
        case currentObservation = "current_observation"
    }
}

struct CurrentObservation: Decodable {
    let condition: Condition
}

struct Condition: Decodable {
    let temperature: Int
    let text: String
    let code: Int
}