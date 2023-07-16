//
//  ButtonModifier.swift
//  Honeymoon
//
//  Created by Lori Rothermel on 7/16/23.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(.pink)
              )  // .background
            .foregroundColor(.white)
    }
}

