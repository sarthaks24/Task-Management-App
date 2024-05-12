//
//  ContentView.swift
//  Slider
//
//  Created by Sarthak on 26/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.2))
            .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
