import SwiftUI

/// A shared environment host for previewing leaf screens with navigation chrome.
struct LibraryScreenPreviewHost<Content: View>: View {
    @StateObject private var navigationManager = LibraryNavigationManager()
    private let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        NavigationStack {
            content()
                .environmentObject(navigationManager)
        }
        .onAppear {
            LibraryNavigation.bind(navigationManager)
        }
    }
}

/// A shared environment host for previewing root-level container views.
struct LibraryRootPreviewHost<Content: View>: View {
    @StateObject private var navigationManager = LibraryNavigationManager()
    private let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        content()
            .environmentObject(navigationManager)
            .onAppear {
                LibraryNavigation.bind(navigationManager)
            }
    }
}
