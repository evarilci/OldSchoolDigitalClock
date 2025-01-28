//
//  MusicList.swift
//  neonWatch
//
//  Created by Eymen Varilci on 28.01.2025.
//

import SwiftUI

struct MusicList: View {
    var body: some View {
        NavigationView {
            List {
                Text("Alarm 1")
                Text("Alarm 2")
                Text("Alarm 3")
            }
            .navigationBarTitle("Alarms")
        }
    }
}
