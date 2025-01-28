//
//  ClockView.swift
//  neonWatch
//
//  Created by Eymen Varilci on 28.01.2025.
//

import SwiftUI

struct ClockView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
 
    private  var digitalWatch = DigitalClockView()
    var body: some View {
      
        VStack(spacing: -24) {
            Spacer()
            Spacer()
            HStack {
                Spacer()
                Spacer()
                DotMatrixLabel(text: "Sunny, 24°C")
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
                        print(digitalWatch.timer.count())
                    }
                .padding()
            HStack {
                DaysOfWeekView()
            }
            
         Spacer()
              
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        
    }
}

#Preview {
    ContentView()
      
}
