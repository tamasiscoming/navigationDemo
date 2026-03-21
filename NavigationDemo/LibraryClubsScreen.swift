import SwiftUI

/// Root screen for reading clubs.
struct LibraryClubsHomeScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AppSection(title: "Reading Clubs") {
                    ForEach(LibraryMockData.clubs) { club in
                        Button {
                            nav.toClubs(.clubDetail(club))
                        } label: {
                            ClubRow(club: club)
                        }
                        .buttonStyle(.plain)
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
            principalTitle: "Clubs"
        )
    }
}

/// Club overview with event links and settings shortcut.
struct ClubDetailScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let club: ReadingClub

    private var events: [ClubEvent] {
        LibraryMockData.events(for: club)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: club.name,
                    subtitle: "Events and discussion threads",
                    imageURL: club.coverURL,
                    systemImage: "person.3"
                )

                AppSection(title: "Upcoming Events") {
                    ForEach(events) { event in
                        Button {
                            nav.toClubs(.eventDetail(event))
                        } label: {
                            EventRow(event: event)
                        }
                        .buttonStyle(.plain)
                    }
                }

                Button("Club Settings") {
                    nav.toClubs(.clubSettings(club))
                }
                .buttonStyle(.bordered)
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: club.name
        )
    }
}

/// Event detail screen with member drill-down.
struct EventDetailScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let event: ClubEvent

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: event.title,
                    subtitle: event.details,
                    imageURL: event.imageURL,
                    systemImage: "calendar"
                )

                AppSection(title: "Members") {
                    ForEach(LibraryMockData.members) { member in
                        Button {
                            nav.toClubs(.memberDetail(member))
                        } label: {
                            PersonRow(name: member.name, imageURL: member.avatarURL)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Event"
        )
    }
}

/// Club member detail screen.
struct MemberDetailScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let member: ClubMember

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: member.name,
                    subtitle: "Active reader and reviewer",
                    imageURL: member.avatarURL,
                    systemImage: "person.crop.circle"
                )
                TextCard(text: "This screen gives the 3rd depth level for Clubs flows.")
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: member.name
        )
    }
}

/// Simple club settings placeholder.
struct ClubSettingsScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let club: ReadingClub

    var body: some View {
        List {
            Text("Meeting cadence: weekly")
            Text("Visibility: public")
            Text("Book voting: enabled")
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "\(club.name) Settings"
        )
    }
}

struct LibraryClubsScreens_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LibraryScreenPreviewHost {
                LibraryClubsHomeScreen()
            }
            .previewDisplayName("Clubs Home")

            LibraryScreenPreviewHost {
                ClubDetailScreen(club: LibraryMockData.clubs[0])
            }
            .previewDisplayName("Club Detail")

            LibraryScreenPreviewHost {
                EventDetailScreen(event: LibraryMockData.events[0])
            }
            .previewDisplayName("Event Detail")

            LibraryScreenPreviewHost {
                MemberDetailScreen(member: LibraryMockData.members[0])
            }
            .previewDisplayName("Member Detail")

            LibraryScreenPreviewHost {
                ClubSettingsScreen(club: LibraryMockData.clubs[0])
            }
            .previewDisplayName("Club Settings")
        }
    }
}
