import SwiftUI

/// Root account screen with shortcuts to profile and account sections.
struct LibraryAccountHomeScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: LibraryMockData.user.name,
                    subtitle: "Library account",
                    imageURL: LibraryMockData.user.avatarURL,
                    systemImage: "person.crop.circle"
                )

                AppSection(title: "My Space") {
                    Button("Open Reader Profile") {
                        nav.toAccount(.readerProfile)
                    }
                    Button("Reading History") {
                        nav.toAccount(.readingHistory)
                    }
                    Button("Saved List") {
                        nav.toAccount(.savedList)
                    }
                }
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(
                remoteImageURL: LibraryMockData.user.avatarURL,
                text: LibraryMockData.user.name,
                action: { openReaderProfileShortcut() }
            ),
            principalTitle: "Account"
        )
    }
}

/// Reader profile destination used by the global avatar shortcut.
struct ReaderProfileScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: LibraryMockData.user.name,
                    subtitle: "Library Reader",
                    imageURL: LibraryMockData.user.avatarURL,
                    systemImage: "person.crop.circle"
                )

                Button("Open Reading History") {
                    nav.toAccount(.readingHistory)
                }
                .buttonStyle(.bordered)

                TextCard(text: "Profile shortcut target from every main tab.")
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Reader Profile"
        )
    }
}

/// Reading history list screen.
struct ReadingHistoryScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        List {
            Text("Orbit City")
            Text("Fog Over Bridge Street")
            Text("Danube Diaries")
            Button("Account Settings") {
                nav.toAccount(.accountSettings)
            }
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Reading History"
        )
    }
}

/// Saved books list screen.
struct SavedListScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        List {
            Text("Lunar Archive")
            Text("The Last Red Key")
            Button("Account Settings") {
                nav.toAccount(.accountSettings)
            }
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Saved List"
        )
    }
}

/// Account settings placeholder screen.
struct AccountSettingsScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        List {
            Text("Notifications")
            Text("Language")
            Text("Privacy")
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Account Settings"
        )
    }
}

struct LibraryAccountScreens_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LibraryScreenPreviewHost {
                LibraryAccountHomeScreen()
            }
            .previewDisplayName("Account Home")

            LibraryScreenPreviewHost {
                ReaderProfileScreen()
            }
            .previewDisplayName("Reader Profile")

            LibraryScreenPreviewHost {
                ReadingHistoryScreen()
            }
            .previewDisplayName("Reading History")

            LibraryScreenPreviewHost {
                SavedListScreen()
            }
            .previewDisplayName("Saved List")

            LibraryScreenPreviewHost {
                AccountSettingsScreen()
            }
            .previewDisplayName("Account Settings")
        }
    }
}
