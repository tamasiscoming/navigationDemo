import SwiftUI

/// Root container that hosts five independent tab navigation stacks.
struct LibraryTabView: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch nav.selectedTab {
                case .catalog:
                    catalogStack
                case .clubs:
                    clubsStack
                case .account:
                    accountStack
                case .insights:
                    insightsStack
                case .authors:
                    authorsStack
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Divider()
            tabBar
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            LibraryNavigation.bind(nav)
        }
    }

    private var catalogStack: some View {
        NavigationStack(path: $nav.catalogPath) {
            LibraryCatalogHomeScreen()
                .navigationDestination(for: LibraryCatalogRoute.self) { route in
                    switch route {
                    case let .genreDetail(genre):
                        GenreDetailScreen(genre: genre)
                    case let .bookDetail(book):
                        BookDetailScreen(book: book)
                    case let .authorDetail(author):
                        AuthorDetailScreen(author: author)
                    case .catalogSearch:
                        CatalogSearchScreen()
                    case .newArrivals:
                        NewArrivalsScreen()
                    }
                }
        }
    }

    private var clubsStack: some View {
        NavigationStack(path: $nav.clubsPath) {
            LibraryClubsHomeScreen()
                .navigationDestination(for: LibraryClubRoute.self) { route in
                    switch route {
                    case let .clubDetail(club):
                        ClubDetailScreen(club: club)
                    case let .eventDetail(event):
                        EventDetailScreen(event: event)
                    case let .memberDetail(member):
                        MemberDetailScreen(member: member)
                    case let .clubSettings(club):
                        ClubSettingsScreen(club: club)
                    }
                }
        }
    }

    private var accountStack: some View {
        NavigationStack(path: $nav.accountPath) {
            LibraryAccountHomeScreen()
                .navigationDestination(for: LibraryAccountRoute.self) { route in
                    switch route {
                    case .readerProfile:
                        ReaderProfileScreen()
                    case .readingHistory:
                        ReadingHistoryScreen()
                    case .savedList:
                        SavedListScreen()
                    case .accountSettings:
                        AccountSettingsScreen()
                    }
                }
        }
    }

    private var insightsStack: some View {
        NavigationStack(path: $nav.insightsPath) {
            LibraryInsightsHomeScreen()
                .navigationDestination(for: LibraryInsightRoute.self) { route in
                    switch route {
                    case let .trendDetail(trend):
                        TrendDetailScreen(trend: trend)
                    case let .collectionDetail(collection):
                        CollectionDetailScreen(collection: collection)
                    case let .featuredBook(book):
                        FeaturedBookScreen(book: book)
                    case .insightLab:
                        InsightLabScreen()
                    }
                }
        }
    }

    private var authorsStack: some View {
        NavigationStack(path: $nav.authorsPath) {
            LibraryAuthorsHomeScreen()
                .navigationDestination(for: LibraryAuthorRoute.self) { route in
                    switch route {
                    case let .authorSpotlight(author):
                        AuthorSpotlightScreen(author: author)
                    case let .authorBibliography(author):
                        AuthorBibliographyScreen(author: author)
                    case let .legendBook(book):
                        LegendBookScreen(book: book)
                    case let .interview(author):
                        AuthorInterviewScreen(author: author)
                    }
                }
        }
    }

    private var tabBar: some View {
        HStack {
            ForEach(LibraryTab.allCases) { tab in
                Button {
                    nav.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 17, weight: .semibold))
                        Text(tab.title)
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundStyle(nav.selectedTab == tab ? Color.blue : Color.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 8)
        .background(Color(.secondarySystemBackground))
    }
}

struct LibraryTabView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryRootPreviewHost {
            LibraryTabView()
        }
        .previewDisplayName("Library Tab Root")
    }
}
