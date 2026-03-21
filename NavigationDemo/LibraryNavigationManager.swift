import Foundation
import Combine

/// Drives tab selection and independent navigation paths for each tab.
final class LibraryNavigationManager: ObservableObject {
    /// Currently selected tab.
    @Published var selectedTab: LibraryTab = .catalog

    /// Navigation path for the Catalog tab.
    @Published var catalogPath: [LibraryCatalogRoute] = []
    /// Navigation path for the Clubs tab.
    @Published var clubsPath: [LibraryClubRoute] = []
    /// Navigation path for the Account tab.
    @Published var accountPath: [LibraryAccountRoute] = []
    /// Navigation path for the Insights tab.
    @Published var insightsPath: [LibraryInsightRoute] = []
    /// Navigation path for the Authors tab.
    @Published var authorsPath: [LibraryAuthorRoute] = []

    /// Navigates to a Catalog destination.
    func toCatalog(_ route: LibraryCatalogRoute) {
        selectedTab = .catalog
        catalogPath.append(route)
    }

    /// Navigates to a Clubs destination.
    func toClubs(_ route: LibraryClubRoute) {
        selectedTab = .clubs
        clubsPath.append(route)
    }

    /// Navigates to an Account destination.
    func toAccount(_ route: LibraryAccountRoute) {
        selectedTab = .account
        accountPath.append(route)
    }

    /// Navigates to an Insights destination.
    func toInsights(_ route: LibraryInsightRoute) {
        selectedTab = .insights
        insightsPath.append(route)
    }

    /// Navigates to an Authors destination.
    func toAuthors(_ route: LibraryAuthorRoute) {
        selectedTab = .authors
        authorsPath.append(route)
    }

    /// Clears the Catalog stack to root.
    func resetCatalog() {
        catalogPath.removeAll()
    }

    /// Clears the Clubs stack to root.
    func resetClubs() {
        clubsPath.removeAll()
    }

    /// Clears the Account stack to root.
    func resetAccount() {
        accountPath.removeAll()
    }

    /// Clears the Insights stack to root.
    func resetInsights() {
        insightsPath.removeAll()
    }

    /// Clears the Authors stack to root.
    func resetAuthors() {
        authorsPath.removeAll()
    }

    /// Pops the currently selected tab path by a given number of steps.
    func popCurrent(by steps: Int) {
        let safeSteps = max(0, steps)
        guard safeSteps > 0 else { return }

        switch selectedTab {
        case .catalog:
            popLast(&catalogPath, count: safeSteps)
        case .clubs:
            popLast(&clubsPath, count: safeSteps)
        case .account:
            popLast(&accountPath, count: safeSteps)
        case .insights:
            popLast(&insightsPath, count: safeSteps)
        case .authors:
            popLast(&authorsPath, count: safeSteps)
        }
    }

    /// Builds the long-press back menu options for the current tab.
    func currentBackNavigationOptions() -> [BackNavigationOption] {
        switch selectedTab {
        case .catalog:
            return backOptions(for: catalogPath, tab: .catalog, mapper: mapCatalog)
        case .clubs:
            return backOptions(for: clubsPath, tab: .clubs, mapper: mapClubs)
        case .account:
            return backOptions(for: accountPath, tab: .account, mapper: mapAccount)
        case .insights:
            return backOptions(for: insightsPath, tab: .insights, mapper: mapInsights)
        case .authors:
            return backOptions(for: authorsPath, tab: .authors, mapper: mapAuthors)
        }
    }

    private func popLast<T>(_ path: inout [T], count: Int) {
        let safeCount = min(path.count, count)
        guard safeCount > 0 else { return }
        path.removeLast(safeCount)
    }

    private func destinationRoute<T>(in path: [T], afterPopping steps: Int) -> T? {
        let index = path.count - steps - 1
        guard index >= 0, index < path.count else { return nil }
        return path[index]
    }

    private func backOptions<T>(for path: [T],
                                tab: LibraryTab,
                                mapper: (T, Int) -> BackNavigationOption) -> [BackNavigationOption]
    {
        guard !path.isEmpty else { return [] }

        return (1...path.count).map { steps in
            if let destination = destinationRoute(in: path, afterPopping: steps) {
                return mapper(destination, steps)
            }
            return rootOption(for: tab, steps: steps)
        }
    }

    private func rootOption(for tab: LibraryTab, steps: Int) -> BackNavigationOption {
        BackNavigationOption(
            steps: steps,
            title: "\(tab.title) Home",
            subtitle: backSubtitle(kind: "Root", steps: steps),
            systemImage: tab.icon,
            remoteImageURL: nil
        )
    }

    private func backSubtitle(kind: String, steps: Int) -> String {
        if steps == 1 {
            return "\(kind) • 1 screen back"
        }
        return "\(kind) • \(steps) screens back"
    }

    private func mapCatalog(_ route: LibraryCatalogRoute, steps: Int) -> BackNavigationOption {
        switch route {
        case let .genreDetail(genre):
            return BackNavigationOption(
                steps: steps,
                title: genre.name,
                subtitle: backSubtitle(kind: "Genre", steps: steps),
                systemImage: "books.vertical",
                remoteImageURL: genre.logoURL
            )
        case let .bookDetail(book):
            return BackNavigationOption(
                steps: steps,
                title: book.title,
                subtitle: backSubtitle(kind: "Book", steps: steps),
                systemImage: "book",
                remoteImageURL: book.coverURL
            )
        case let .authorDetail(author):
            return BackNavigationOption(
                steps: steps,
                title: author.name,
                subtitle: backSubtitle(kind: "Author", steps: steps),
                systemImage: "person",
                remoteImageURL: author.portraitURL
            )
        case .catalogSearch:
            return BackNavigationOption(
                steps: steps,
                title: "Catalog Search",
                subtitle: backSubtitle(kind: "Search", steps: steps),
                systemImage: "magnifyingglass",
                remoteImageURL: nil
            )
        case .newArrivals:
            return BackNavigationOption(
                steps: steps,
                title: "New Arrivals",
                subtitle: backSubtitle(kind: "Books", steps: steps),
                systemImage: "sparkles",
                remoteImageURL: nil
            )
        }
    }

    private func mapClubs(_ route: LibraryClubRoute, steps: Int) -> BackNavigationOption {
        switch route {
        case let .clubDetail(club):
            return BackNavigationOption(
                steps: steps,
                title: club.name,
                subtitle: backSubtitle(kind: "Reading Club", steps: steps),
                systemImage: "person.3",
                remoteImageURL: club.coverURL
            )
        case let .eventDetail(event):
            return BackNavigationOption(
                steps: steps,
                title: event.title,
                subtitle: backSubtitle(kind: "Event", steps: steps),
                systemImage: "calendar",
                remoteImageURL: event.imageURL
            )
        case let .memberDetail(member):
            return BackNavigationOption(
                steps: steps,
                title: member.name,
                subtitle: backSubtitle(kind: "Member", steps: steps),
                systemImage: "person.crop.circle",
                remoteImageURL: member.avatarURL
            )
        case let .clubSettings(club):
            return BackNavigationOption(
                steps: steps,
                title: "\(club.name) Settings",
                subtitle: backSubtitle(kind: "Settings", steps: steps),
                systemImage: "gearshape",
                remoteImageURL: club.coverURL
            )
        }
    }

    private func mapAccount(_ route: LibraryAccountRoute, steps: Int) -> BackNavigationOption {
        switch route {
        case .readerProfile:
            return BackNavigationOption(
                steps: steps,
                title: "Reader Profile",
                subtitle: backSubtitle(kind: "Account", steps: steps),
                systemImage: "person.crop.circle",
                remoteImageURL: LibraryMockData.user.avatarURL
            )
        case .readingHistory:
            return BackNavigationOption(
                steps: steps,
                title: "Reading History",
                subtitle: backSubtitle(kind: "Account", steps: steps),
                systemImage: "clock.arrow.circlepath",
                remoteImageURL: nil
            )
        case .savedList:
            return BackNavigationOption(
                steps: steps,
                title: "Saved List",
                subtitle: backSubtitle(kind: "Account", steps: steps),
                systemImage: "bookmark",
                remoteImageURL: nil
            )
        case .accountSettings:
            return BackNavigationOption(
                steps: steps,
                title: "Account Settings",
                subtitle: backSubtitle(kind: "Account", steps: steps),
                systemImage: "gearshape",
                remoteImageURL: nil
            )
        }
    }

    private func mapInsights(_ route: LibraryInsightRoute, steps: Int) -> BackNavigationOption {
        switch route {
        case let .trendDetail(trend):
            return BackNavigationOption(
                steps: steps,
                title: trend.title,
                subtitle: backSubtitle(kind: "Trend", steps: steps),
                systemImage: "waveform.path.ecg",
                remoteImageURL: trend.imageURL
            )
        case let .collectionDetail(collection):
            return BackNavigationOption(
                steps: steps,
                title: collection.title,
                subtitle: backSubtitle(kind: "Collection", steps: steps),
                systemImage: "square.stack",
                remoteImageURL: collection.imageURL
            )
        case let .featuredBook(book):
            return BackNavigationOption(
                steps: steps,
                title: book.title,
                subtitle: backSubtitle(kind: "Featured Book", steps: steps),
                systemImage: "book",
                remoteImageURL: book.coverURL
            )
        case .insightLab:
            return BackNavigationOption(
                steps: steps,
                title: "Insight Lab",
                subtitle: backSubtitle(kind: "Insights", steps: steps),
                systemImage: "lightbulb",
                remoteImageURL: nil
            )
        }
    }

    private func mapAuthors(_ route: LibraryAuthorRoute, steps: Int) -> BackNavigationOption {
        switch route {
        case let .authorSpotlight(author):
            return BackNavigationOption(
                steps: steps,
                title: author.name,
                subtitle: backSubtitle(kind: "Spotlight", steps: steps),
                systemImage: "star",
                remoteImageURL: author.portraitURL
            )
        case let .authorBibliography(author):
            return BackNavigationOption(
                steps: steps,
                title: "\(author.name) Books",
                subtitle: backSubtitle(kind: "Bibliography", steps: steps),
                systemImage: "books.vertical",
                remoteImageURL: author.portraitURL
            )
        case let .legendBook(book):
            return BackNavigationOption(
                steps: steps,
                title: book.title,
                subtitle: backSubtitle(kind: "Legend Book", steps: steps),
                systemImage: "book.closed",
                remoteImageURL: book.coverURL
            )
        case let .interview(author):
            return BackNavigationOption(
                steps: steps,
                title: "Interview: \(author.name)",
                subtitle: backSubtitle(kind: "Interview", steps: steps),
                systemImage: "mic",
                remoteImageURL: author.portraitURL
            )
        }
    }
}

/// Static convenience wrapper around the active `LibraryNavigationManager`.
enum LibraryNavigation {
    private static weak var manager: LibraryNavigationManager?

    /// Binds the active manager instance used by static navigation calls.
    static func bind(_ manager: LibraryNavigationManager) {
        self.manager = manager
    }

    /// Static Catalog navigation entry point.
    static func toCatalog(_ route: LibraryCatalogRoute) {
        manager?.toCatalog(route)
    }

    /// Static Clubs navigation entry point.
    static func toClubs(_ route: LibraryClubRoute) {
        manager?.toClubs(route)
    }

    /// Static Account navigation entry point.
    static func toAccount(_ route: LibraryAccountRoute) {
        manager?.toAccount(route)
    }

    /// Static Insights navigation entry point.
    static func toInsights(_ route: LibraryInsightRoute) {
        manager?.toInsights(route)
    }

    /// Static Authors navigation entry point.
    static func toAuthors(_ route: LibraryAuthorRoute) {
        manager?.toAuthors(route)
    }

    /// Static reset call for Catalog path.
    static func resetCatalog() {
        manager?.resetCatalog()
    }

    /// Static reset call for Clubs path.
    static func resetClubs() {
        manager?.resetClubs()
    }

    /// Static reset call for Account path.
    static func resetAccount() {
        manager?.resetAccount()
    }

    /// Static reset call for Insights path.
    static func resetInsights() {
        manager?.resetInsights()
    }

    /// Static reset call for Authors path.
    static func resetAuthors() {
        manager?.resetAuthors()
    }

    /// Static pop call for the selected tab path.
    static func popCurrent(by steps: Int) {
        manager?.popCurrent(by: steps)
    }

    /// Static accessor for current back navigation options.
    static func currentBackNavigationOptions() -> [BackNavigationOption] {
        manager?.currentBackNavigationOptions() ?? []
    }
}
