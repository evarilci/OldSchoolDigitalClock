//
//  NeonDigitalWatchView.swift
//  neonWatch
//
//  Created by Eymen Varilci on 23.01.2025.
//


import SwiftUI

struct NeonDigitalWatchView: View {
    @State private var currentTime = Date()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
            
            ZStack {
                // Background
                Color(.black)
                    .edgesIgnoringSafeArea(.all)
                
                // Digital Time Display
                VStack {
                    Spacer()
                HStack(spacing: 4) {
                    Text(timeString(from: currentTime))
                        .font(.system(size: 59, weight: .bold, design: .monospaced))
                        .foregroundColor(.neonGreen)
                        .shadow(color: .neonGreen, radius:15, x: 0, y: 0)
                }
                .padding()
                .background(Color.clear)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.neonGreen, lineWidth: 5)
                        .shadow(color: .neonGreen, radius: 10, x: 0, y: 0)
                )
                .padding(.vertical,24)
            }
            .onReceive(timer) { input in
                currentTime = input
            }
        }
    }
    
    func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
}

extension Color {
    static let neonGreen = Color(red: 0.0, green: 1.0, blue: 0.0)
}

struct NeonDigitalWatchView_Previews: PreviewProvider {
    static var previews: some View {
        NeonDigitalWatchView()
    }
}
