//
//  APIManager.swift
//  neonWatch
//
//  Created by Eymen Varilci on 29.01.2025.
//

import Foundation


struct APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func fetchWeather() async throws -> Condition {
        // The endpoint URL
        let urlString = "https://yahoo-weather5.p.rapidapi.com/weather?location=gebze&format=json&u=c"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Set required headers
        request.setValue("yahoo-weather5.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.setValue("b9717c6ef4mshbcdd4b1e8b9b4f5p146d3ajsn26c35657fcc9", forHTTPHeaderField: "x-rapidapi-key")
        
        // Perform the request using async/await
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Optional: Check for 2xx status code
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 {
            throw URLError(.badServerResponse)
        }

        // Decode only the part we need (condition)
        let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return decodedResponse.currentObservation.condition
    }
    
    
}
