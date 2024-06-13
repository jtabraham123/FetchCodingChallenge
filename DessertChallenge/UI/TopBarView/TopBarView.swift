//
//  TopBarView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import SwiftUI

// top bar view, shows top bar
struct TopBarView: View {
    
    var body: some View {
        Rectangle()
            .fill(Color.green)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 75) // Flexible size
            .overlay(Text("Dessert Recipes").foregroundColor(.white).font(.system(size: 24, weight: .bold, design: .default)))
            .border(Color.black, width: 2)
    }
}

#Preview {
    TopBarView()
}
