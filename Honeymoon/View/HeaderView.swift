//
//  HeaderView.swift
//  Honeymoon
//
//  Created by Lori Rothermel on 7/12/23.
//

import SwiftUI

struct HeaderView: View {
    
    var body: some View {
        HStack {
            Button {
                print("Information")
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular, design: .serif))
            }  // Button
            .accentColor(.primary)
            
            Spacer()
            
            Image("logo-honeymoon-pink")
                .resizable()
                .scaledToFit()
                .frame(height: 28)
            
            Spacer()
            
            Button {
                print("Guide")
            } label: {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 24, weight: .regular, design: .serif))
            }  // Button
            .accentColor(.primary)
            
        }  // HStack
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
