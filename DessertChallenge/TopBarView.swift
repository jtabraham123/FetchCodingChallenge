//
//  TopBarView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import SwiftUI

struct TopBarView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        if (viewModel.isVisible) {
            Rectangle()
                .fill(Color.green)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 75) // Flexible size
                .overlay(Text("Dessert Recipes").foregroundColor(.white).font(.system(size: 24, weight: .bold, design: .default)))
                .border(Color.black, width: 2)
        }
    }
}

#Preview {
    TopBarView(viewModel: TopBarView.ViewModel())
}