//
//  ContentView.swift
//  Honeymoon
//
//  Created by Lori Rothermel on 7/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HeaderView()
            Spacer()
            CardView(honeymoon: honeymoonData[2])
                .padding()
            Spacer()
            FooterView()
            
        }  // VStack
        
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
