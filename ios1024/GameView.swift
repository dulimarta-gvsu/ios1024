//
//  ContentView.swift
//  ios1024
//
//  Created by Hans Dulimarta for CIS357
//

import SwiftUI

func determineSwipeDirection(_ swipe: DragGesture.Value) -> SwipeDirection {
    if abs(swipe.translation.width) > abs(swipe.translation.height) {
        return swipe.translation.width < 0 ? .left : .right
    } else {
        return swipe.translation.height < 0 ? .up : .down
    }
}

struct GameView: View {
    @State var swipeDirection: SwipeDirection? = .none
    var body: some View {
        VStack {
            Text("Welcome to 1024 by YourName!").font(.title2)
            NumberGrid(size: 4)
                .gesture(DragGesture().onEnded {
                    swipeDirection = determineSwipeDirection($0)
                })
                .padding()
                .frame(
                    maxWidth: .infinity
                )
            if let swipeDirection {
                Text("You swiped \(swipeDirection)")
            }
        }.frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NumberGrid: View {
    let size: Int
    
    var body: some View {
        VStack(spacing:4) {
            ForEach(0..<size, id: \.self) { row in
                HStack (spacing:4) {
                    ForEach(0..<size, id: \.self) { column in
                        Text("\(row*size+column)")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding(4)
        .background(Color.gray.opacity(0.4))
    }
}

#Preview {
    GameView()
}
