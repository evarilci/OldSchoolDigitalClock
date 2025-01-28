//
//  DigitalClockView.swift
//  neonWatch
//
//  Created by Eymen Varilci on 28.01.2025.
//


import SwiftUI

struct DigitalClockView: View {
    @State private var currentTime = CurrentTime()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        HStack(spacing: 4) {  // Reduced spacing between digits
            // Hours
            DigitView(digit: currentTime.hours / 10)
            DigitView(digit: currentTime.hours % 10)
            
            // Colon
            Text(":")
                .foregroundStyle(Globals.neonColor)
                .font(.system(size: 32, weight: .heavy))
            
            // Minutes
            DigitView(digit: currentTime.minutes / 10)
            DigitView(digit: currentTime.minutes % 10)
            
            Text(":")
                .foregroundStyle(Globals.neonColor)
                .font(.system(size: 32, weight: .heavy))
            
            // Seconds
            DigitView(digit: currentTime.seconds / 10)
            DigitView(digit: currentTime.seconds % 10)
        }
        
        .onReceive(timer) { _ in
            currentTime = CurrentTime()
        }
        // Example fixed size to see the digits more clearly:
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.black)
        .clipShape(.rect(cornerRadius: 15))
        
        
    }
}

// MARK: - Digit View
struct DigitView: View {
    let digit: Int
 

    /// Segments order: [top, upperLeft, upperRight, middle, lowerLeft, lowerRight, bottom]
    private let segmentsForDigit: [Int: [Bool]] = [
        0: [true,  true,  true,  false, true,  true,  true ],
        1: [false, false, true,  false, false, true,  false],
        2: [true,  false, true,  true,  true,  false, true ],
        3: [true,  false, true,  true,  false, true,  true ],
        4: [false, true,  true,  true,  false, true,  false],
        5: [true,  true,  false, true,  false, true,  true ],
        6: [true,  true,  false, true,  true,  true,  true ],
        7: [true,  false, true,  false, false, true,  false],
        8: [true,  true,  true,  true,  true,  true,  true ],
        9: [true,  true,  true,  true,  false, true,  true ]
    ]
    
    var body: some View {
        GeometryReader { geo in
            // We'll base everything off the smaller dimension
            let dimension = min(geo.size.width, geo.size.height)
            
            // Thickness of each segment
            let thickness = dimension * 0.12
            // Horizontal segment length
            let hLength = dimension * 0.7
            // Vertical segment length
            let vLength = dimension * 0.9
            
            let pattern = segmentsForDigit[digit] ?? [false, false, false, false, false, false, false]
            
            ZStack {
                // -- Top Segment
                SegmentView(isLit: pattern[0], orientation: .horizontal)
                    .frame(width: hLength, height: thickness)
                    .position(x: geo.size.width / 2,
                              y: thickness / 2)
                
                // -- Upper Left
                SegmentView(isLit: pattern[1], orientation: .vertical)
                    .frame(width: thickness, height: vLength)
                    .position(x: thickness / 2,
                              y: (thickness / 2) + (vLength / 2) + 1)
                
                // -- Upper Right
                SegmentView(isLit: pattern[2], orientation: .vertical)
                    .frame(width: thickness, height: vLength)
                    .position(x: geo.size.width - (thickness / 2),
                              y: (thickness / 2) + (vLength / 2) + 1)
                
                // -- Middle
                SegmentView(isLit: pattern[3], orientation: .horizontal)
                    .frame(width: hLength, height: thickness)
                    .position(x: geo.size.width / 2,
                              y: geo.size.height * 0.50)
                
                // -- Lower Left
                SegmentView(isLit: pattern[4], orientation: .vertical)
                    .frame(width: thickness, height: vLength)
                    .position(x: thickness / 2,
                              y: geo.size.height - (thickness / 2) - (vLength / 2) - 1)
                
                // -- Lower Right
                SegmentView(isLit: pattern[5], orientation: .vertical)
                    .frame(width: thickness, height: vLength)
                    .position(x: geo.size.width - (thickness / 2),
                              y: geo.size.height - (thickness / 2) - (vLength / 2) - 1)
                
                // -- Bottom
                SegmentView(isLit: pattern[6], orientation: .horizontal)
                    .frame(width: hLength, height: thickness)
                    .position(x: geo.size.width / 2,
                              y: geo.size.height - (thickness / 2))
            }
        }
        .aspectRatio(0.5, contentMode: .fit) // Adjust aspect ratio to taste
    }
}

// MARK: - Single Segment View
struct SegmentView: View {
    let isLit: Bool
    let orientation: Orientation

    enum Orientation {
        case horizontal, vertical
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(isLit ? Globals.neonColor : Color.init(uiColor: .darkGray.withAlphaComponent(0.15)))
            
        // Add a subtle glow if lit
            .shadow(color: isLit ? Globals.neonColor.opacity(0.9) : .clear, radius: isLit ? 10 : 0)
    }
}

// MARK: - Current Time Helper
struct CurrentTime {
    let hours: Int
    let minutes: Int
    let seconds: Int
    
    init() {
        let now = Date()
        let calendar = Calendar.current
        hours = calendar.component(.hour, from: now)
        minutes = calendar.component(.minute, from: now)
        seconds = calendar.component(.second, from: now)
    }
}

// MARK: - Preview
struct DigitalClockView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalClockView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
