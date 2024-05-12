//
//  SliderApp.swift
//  Slider
//
//  Created by Sarthak on 26/04/24.
//

import SwiftUI



@main
struct SliderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self)
    }
}
