//
//  ContentView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import SwiftUI

struct DessertView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView()
            Spacer()
            DessertListView()
        }
    }
}

#Preview {
    DessertView()
}
