//
//  AlarmList.swift
//  neonWatch
//
//  Created by Eymen Varilci on 28.01.2025.
//

import SwiftUI

struct AlarmList: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationView {
            List {
                FloatingTextField(text: $username, placeholder: "Username")
                FloatingTextField(text: $email, placeholder: "Email")
                FloatingTextField(text: $password, placeholder: "Password")
            }
            .navigationBarTitle("Alarms")
        }
    }
}
