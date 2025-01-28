//
//  CustomTabItem.swift
//  neonWatch
//
//  Created by Eymen Varilci on 28.01.2025.
//


import SwiftUI

struct CustomTabItem {
    let title: String
    let imageName: String
    /// A view to display when this tab is selected
    let content: AnyView
}

struct CustomTabView: View {
    let items: [CustomTabItem]
    @State private var selectedIndex: Int = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            // 1. Show the content of the selected tab
            if !items.isEmpty {
                items[selectedIndex].content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    // (Optional) add a transition or custom styling
                    .transition(.slide)
            }

            // 2. Custom tab bar
            HStack {
                ForEach(items.indices, id: \.self) { idx in
                    let isSelected = (idx == selectedIndex)
                    Button {
                        selectedIndex = idx
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: items[idx].imageName)
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(isSelected ? .blue : .red)

                            Text(items[idx].title)
                                .font(.caption)
                                .foregroundColor(isSelected ? .blue : .red)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.vertical, 8)
            .background(.thinMaterial) // or any custom background
        }
        // (Optional) make sure the tab bar extends to the screen’s bottom
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
