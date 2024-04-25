//
//  ContentView.swift
//  Memorize
//
//  Created by Ricky Kwong on 2024-04-23.
//

import SwiftUI

struct ContentView: View {
    
    @State var cardCount: Int = 4
    
    let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱"]
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }

    func cardCountAdjuster(by offset: Int, symbol:String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid (columns: [GridItem(.adaptive(minimum:90))]) {
            
            ForEach(0..<cardCount, id:\.self) { index in
                    CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
                    
        }.foregroundColor(.orange)
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth:2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0:1)
        }
        .onTapGesture{
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
