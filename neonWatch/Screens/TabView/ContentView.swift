//
//  ContentView.swift
//  neonWatch
//
//  Created by Eymen Varilci on 23.01.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    private  var digitalWatch = DigitalClockView()
    @State var vi = ClockView()
    var body: some View {
        
        
        if #available(iOS 18.0, *) {
            TabView {
                Tab("Watch", systemImage: "applewatch.case.inset.filled") {
                    ClockView()
                       
                }
                

                Tab("Alarm", systemImage: "alarm.fill") {
                    AlarmList()
                }


                Tab("Music", systemImage: "music.note.list") {
                    MusicList()
                }
                
            }
            .tabViewStyle(.sidebarAdaptable)
            .tint(.green)
        } else {
            
            TabView {
                    ClockView()
                    .tabItem {
                        Label("Watch", systemImage: "applewatch.case.inset.filled")
                            
                    }
                AlarmList()
                    .tabItem {
                        Label("Alarm", systemImage: "alarm.fill")
                            
                    }
                MusicList()
                    .tabItem {
                        Label("Music", systemImage: "music.note.list")
                           
                    }
                
            }
            .tabViewStyle(.automatic)
            .accentColor(.green)

        }
    }
}

#Preview {
    ContentView()
      
}
