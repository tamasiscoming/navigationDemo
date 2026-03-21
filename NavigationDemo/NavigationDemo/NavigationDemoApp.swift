//
//  NavigationDemoApp.swift
//  NavigationDemo
//
//  Created by Nguyen Van Nam Tamás on 2026. 03. 21..
//

import SwiftUI

/// Main app entry point for the standalone library navigation demo.
@main
struct LibraryDemoApp: App {
    @StateObject private var navigationManager = LibraryNavigationManager()

    var body: some Scene {
        WindowGroup {
            LibraryTabView()
                .environmentObject(navigationManager)
        }
    }
}
