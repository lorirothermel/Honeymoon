//
//  ContentView.swift
//  Honeymoon
//
//  Created by Lori Rothermel on 7/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var showAlert: Bool = false
    @State var showGuide: Bool = false
    @State var showInfo: Bool = false
    @GestureState private var dragState = DragState.inactive
    @State private var lastCardIndex: Int = 1
    @State private var cardRemovalTransition = AnyTransition.trailingBottom
    
    
    private var dragAreaThreshold: CGFloat = 65.0
    let haptics = UINotificationFeedbackGenerator()
    
    
    // MARK: - Card Views
    @State var cardViews: [CardView] = {
        var views = [CardView]()
        
        for index in 0..<2 {
            views.append(CardView(honeymoon: honeymoonData[index]))
        }
        return views
    }()
    
    
    // MARK: - Move the Card
    private func moveCards() {
        cardViews.removeFirst()
        
        lastCardIndex += 1
        let honeymoon = honeymoonData[lastCardIndex % honeymoonData.count]
        let newCardView = CardView(honeymoon: honeymoon)
        cardViews.append(newCardView)
    }
    
    
    
    // MARK: - Top Card
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else {
            return false
        }
        return index == 0
    }
    
    
    // MARK: - Drag States
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }  // switch
        }  // translation
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
            }  // switch
        }  // isDragging
        
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }  // switch
        }  // isPressing
        
    }  // enum
    
    
    var body: some View {
        VStack {
            // MARK: - Header
            HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default, value: showInfo)
            
            Spacer()
            
            // MARK: - Cards
            ZStack {
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                        .overlay(
                            ZStack {
                               // MARK: - X-Mark Symbol
                                Image(systemName: "x.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(self.dragState.translation.width < -self.dragAreaThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)

                                // MARK: - Heart Symbol
                                Image(systemName: "heart.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(dragState.translation.width > dragAreaThreshold && isTopCard(cardView: cardView) ? 1.0 : 0.0)

                            }  // ZStack
                        )  // .overlay
                        .offset(x: self.isTopCard(cardView: cardView) ? self.dragState.translation.width : 0, y: self.isTopCard(cardView: cardView) ? self.dragState.translation.height : 0)
                        .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: cardView) ? 0.85 : 1.0)
                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: cardView) ? Double(self.dragState.translation.width / 12) : 0))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120), value: dragState.isDragging)
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                            .sequenced(before: DragGesture())
                            .updating(self.$dragState, body: {(value, state, transaction) in
                                switch value {
                                case .first(true):
                                    state = .pressing
                                case .second(true, let drag):
                                    state = .dragging(translation: drag?.translation ?? .zero)
                                default:
                                    break
                                }  // switch
                            })  // updating
                            .onChanged({ (value) in
                                guard case .second(true, let drag?) = value else {
                                    return
                                }  // guard case
                                
                                if drag.translation.width < -self.dragAreaThreshold {
                                    self.cardRemovalTransition = .leadingBottom
                                }  // if
                                
                                if drag.translation.width > dragAreaThreshold {
                                    cardRemovalTransition = .trailingBottom
                                }  // if
                            })  // .onChanged
                            .onEnded({ value in
                                guard case .second(true, let drag?) = value else {
                                    return
                                }  // guard case
                                if drag.translation.width < -self.dragAreaThreshold || drag.translation.width > dragAreaThreshold {
                                    playSound(sound: "sound-rise", type: "mp3")
                                    haptics.notificationOccurred(.success)
                                    moveCards()
                                }  // if drag
                            })  // .onEnded
                        )  // gesture
                        .transition((self.cardRemovalTransition))
                }  // ForEach
            }  // ZStack
            .padding(.horizontal)
            
            Spacer()
            
            // MARK: - Footer
            FooterView(showBookingAlert: $showAlert)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default, value: dragState.isDragging)
            
        }  // VStack
        .alert(isPresented: $showAlert) {
            Alert(title: Text("SUCCESS"),
                  message: Text("Wishing a lovely and most precious of times together for the amazing couple."),
                  dismissButton: .default(Text("Happy Honeymoon!")))
        }  // .alert
        
    }  // some View
}  // ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




//    .onAppear {
//        Thread.sleep(forTimeInterval: 8.0)
//    }  // .onAppear
