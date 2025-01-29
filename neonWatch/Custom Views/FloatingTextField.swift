//
//  FloatingTextField.swift
//  neonWatch
//
//  Created by Eymen Varilci on 29.01.2025.
//

import SwiftUI


fileprivate extension View {
    @ViewBuilder func reverseMask<Mask: View>(alignment: Alignment = .center, @ViewBuilder _ mask:() -> Mask) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    mask()
                        .blendMode(.destinationOut)
                }
        }
    }
}


struct FloatingTextField: View {
    @Binding var text: String
    let placeholder: String
    @FocusState var focused: Bool
    
    let fgColor = Color.primary
    let placeholderColor = Color.secondary
    let outlinenotFocusedColor = Color.secondary.opacity(0.3)
    let labelColor = Color.primary
    
    
    var body: some View {
        let isFilled = text.count > 0
        ZStack {
            TextField("", text: $text)
                .frame(height: 24)
                .focused($focused)
                .padding(.horizontal)
                .foregroundStyle(fgColor)
        }
        .frame(height: 56)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(focused ? Color.accentColor : outlinenotFocusedColor, lineWidth: 2)
                .padding(2)
                .reverseMask(alignment: .leading) {
                    Text(placeholder)
                        .frame(height: 16)
                        .font(isFilled ? .caption : .body)
                        .background {
                            Rectangle()
                                .fill()
                                .stroke(.red, lineWidth: 8)
                        }
                        .padding(.leading)
                        .offset(y: isFilled ? -28 : 0)
                }
                .overlay(alignment: .leading) {
                    Text(placeholder)
                        .frame(height: 16)
                        .padding(.leading)
                        .font(isFilled ? .caption : .body)
                        .offset(y: isFilled ? -28 : 0)
                        .foregroundStyle(isFilled ? labelColor : placeholderColor)
                }
        }
        .onTapGesture {
            focused = true
        }
        .animation(.smooth, value: isFilled)
    }
}

//#Preview {
//    FloatingTextField(text: .constant(""), placeholder: "text gir")
//}
