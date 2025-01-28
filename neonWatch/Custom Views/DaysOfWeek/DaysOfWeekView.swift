//
//  DaysOfWeekView.swift
//  neonWatch
//
//  Created by Eymen Varilci on 28.01.2025.
//


import SwiftUI

struct DaysOfWeekView: View {
    private let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    // 1) Figure out today's short weekday in English, like "Mon", "Tue", etc.
    private var today: String {
        let formatter = DateFormatter()
        // "EEE" gives short weekdays: "Mon", "Tue", "Wed", etc.
        formatter.dateFormat = "EEE"
        return formatter.string(from: Date())
    }
    
    var body: some View {
        HStack {
            // 2) For each day, compare with `today` and set opacity
            ForEach(days, id: \.self) { day in
                DotMatrixLabel(text: day)
                    .font(.headline)
                  
                    // If it matches today, full opacity; otherwise 0.3
                    .opacity(day == today ? 1.0 : 0.3)
                   
            }
        }
        .padding()
        .background(Color.black)
    }
}

struct DaysOfWeekView_Previews: PreviewProvider {
    static var previews: some View {
        DaysOfWeekView()
            .previewLayout(.sizeThatFits)
    }
}
