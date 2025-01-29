//
//  ClockView.swift
//  neonWatch
//
//  Created by Eymen Varilci on 28.01.2025.
//

import SwiftUI

struct ClockView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    
    @State private var didAppear = false  // Tracks if we've already called loadWeather
    let colors:[Color] = [.red, .blue, .pink, .purple, .green, .orange]
    //    @Environment(\.modelContext) private var modelContext
    //    @Query private var items: [Item]
    @State private var weatherText: String = "Sunny, 24°C"
    private  var digitalWatch = DigitalClockView()
    var body: some View {
        
        VStack(spacing: -24) {
            Spacer()
            Spacer()
            HStack {
                Spacer()
                Spacer()
                
                DotMatrixLabel(text: weatherText)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                DotMatrixLabel(text: "No Alarm set")
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            digitalWatch
                .frame(maxWidth: .infinity, maxHeight: 120)
                .padding()
                .onTapGesture {
                    Globals.neonColor = colors.randomElement()!
                }
                .padding()
            HStack {
                DaysOfWeekView()
            }
            
            Spacer()
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .onReceive(locationManager.$cityName) { newCity in
            // Whenever we get a new city, fetch the weather
            if !newCity.isEmpty {
                viewModel.loadWeather(for: newCity)
            }
        }
        .onReceive(viewModel.$condition) { newCondition in
            guard let newCondition else {
                weatherText = "No Weather Data"
                return
            }
            weatherText = "\(newCondition.text), \(newCondition.temperature)°C"
        }
    }
}

#Preview {
    ContentView()
    
}
