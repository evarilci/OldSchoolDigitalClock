//
//  WeatherViewModel.swift
//  neonWatch
//
//  Created by Eymen Varilci on 29.01.2025.
//

import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var condition: Condition?
    @Published var conditionText: String = "Loading..."
    @Published var errorMessage: String?
    
    // This function calls your existing async fetch
    func loadWeather(for city: String) {
        Task {
            do {
                let condition = try await fetchWeather(for: city)
                conditionText = condition.text
                self.condition = condition
            } catch {
                errorMessage = error.localizedDescription
                conditionText = "Error"
            }
        }
    }
}

// Example of your weather fetching function that takes the city parameter:
func fetchWeather(for city: String) async throws -> Condition {
    // Encode city to handle spaces or special characters (like "Beşiktaş")
    guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        throw URLError(.badURL)
    }
    
    let urlString = "https://yahoo-weather5.p.rapidapi.com/weather?location=\(encodedCity)&format=json&u=c"
    
    guard let url = URL(string: urlString) else {
        throw URLError(.badURL)
    }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("yahoo-weather5.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
    request.setValue("b9717c6ef4mshbcdd4b1e8b9b4f5p146d3ajsn26c35657fcc9", forHTTPHeaderField: "x-rapidapi-key")

    let (data, response) = try await URLSession.shared.data(for: request)
    
    if let httpResponse = response as? HTTPURLResponse,
       httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 {
        throw URLError(.badServerResponse)
    }

    let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
    return decodedResponse.currentObservation.condition
}
