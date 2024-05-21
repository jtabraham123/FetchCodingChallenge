//
//  ContentView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import SwiftUI

struct DessertView: View {
    
    @StateObject private var viewModel  = ViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView()
            Spacer()
            List(viewModel.desserts) { dessert in
                Text(dessert.name).font(.headline)
            }
        }.onAppear {
            viewModel.getDesserts()
        }
    }
}

#Preview {
    DessertView()
}
