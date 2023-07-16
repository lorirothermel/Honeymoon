//
//  FooterView.swift
//  Honeymoon
//
//  Created by Lori Rothermel on 7/12/23.
//

import SwiftUI

struct FooterView: View {
    @Binding var showBookingAlert: Bool
    
    
    var body: some View {
        HStack {
            Image(systemName: "xmark.circle")
                .font(.system(size: 42, weight: .light, design: .serif))
            
            Spacer()
            
            Button {
                showBookingAlert.toggle()
            } label: {
                Text("Book Destination")
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.heavy)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .accentColor(.pink)
                    .background(
                        Capsule()
                            .stroke(.pink, lineWidth: 2)
                    )  // .background
            }  // Button
            
            Spacer()
            
            Image(systemName: "heart.circle")
                .font(.system(size: 42, weight: .light, design: .serif))
            
        }  // HStack
        .padding()
    }
}

struct FooterView_Previews: PreviewProvider {
    @State static var showAlert: Bool = false
    
    
    static var previews: some View {
        FooterView(showBookingAlert: $showAlert)
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
