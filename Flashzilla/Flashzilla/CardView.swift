//
//  CardView.swift
//  Flashzilla
//
//  Created by Giorgio Latour on 6/13/23.
//

import SwiftUI

extension Shape {
    func fill(usingOffset offset: CGSize) -> some View {
        if offset.width == 0 {
            return self.fill(.white)
        } else if offset.width > 0 {
            return self.fill(.green)
        } else {
            return self.fill(.red)
        }
    }
}

struct CardView: View {
    let card: Card
    var removal: ((Bool) -> Void)? = nil
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State private var isShowingAnswer = false
    @State private var offset: CGSize = CGSize.zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(usingOffset: offset)
                )
                .shadow(radius: 10)
            
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 3, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        // remove the card
                        if offset.width < 0 {  // play haptic on error only
                            feedback.notificationOccurred(.error)
                            removal?(true)
                            offset = .zero
                        } else {
                            removal?(false)
                        }
                    } else {
                        withOptionalAnimation(.spring()) {
                            offset = .zero
                        }
                    }
                }
        )
        .onTapGesture {
            withOptionalAnimation(.spring()) {
                isShowingAnswer.toggle()
            }
        }
//        .onChange(of: offset) { newOffset in
//            print("Offset is now \(newOffset)")
//        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
