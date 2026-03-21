//
//  ContentView.swift
//  NavigationDemo
//
//  Created by Nguyen Van Nam Tamás on 2026. 03. 21..
//

import SwiftUI

/// Convenience entry view that hosts the library tab root.
struct ContentView: View {
    @StateObject private var navigationManager = LibraryNavigationManager()

    var body: some View {
        LibraryTabView()
            .environmentObject(navigationManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDisplayName("Content View")
    }
}
