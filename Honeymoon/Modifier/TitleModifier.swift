//
//  TitleModifier.swift
//  Honeymoon
//
//  Created by Lori Rothermel on 7/15/23.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.pink)
    }
}
