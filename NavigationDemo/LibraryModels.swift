import Foundation

/// Represents the five top-level tabs in the demo app.
enum LibraryTab: String, CaseIterable, Identifiable {
    case catalog
    case clubs
    case account
    case insights
    case authors

    /// Stable identifier for `ForEach` usage.
    var id: String { rawValue }

    /// Human-friendly title used in the custom tab bar.
    var title: String {
        switch self {
        case .catalog: return "Catalog"
        case .clubs: return "Clubs"
        case .account: return "Account"
        case .insights: return "Insights"
        case .authors: return "Authors"
        }
    }

    /// SF Symbol used for the tab icon.
    var icon: String {
        switch self {
        case .catalog: return "books.vertical"
        case .clubs: return "person.3"
        case .account: return "person.crop.circle"
        case .insights: return "sparkles"
        case .authors: return "book.closed"
        }
    }
}

/// Describes the current reader profile used in toolbar shortcuts.
struct LibraryUser: Hashable {
    let name: String
    let avatarURL: String
}

/// A high-level genre shown in the catalog.
struct LibraryGenre: Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String
    let logoURL: String
}

/// An author entity with short profile metadata.
struct LibraryAuthor: Identifiable, Hashable {
    let id: Int
    let name: String
    let portraitURL: String
    let bio: String
}

/// A book entity linked to both genre and author.
struct LibraryBook: Identifiable, Hashable {
    let id: Int
    let genreId: Int
    let authorId: Int
    let title: String
    let subtitle: String
    let coverURL: String
}

/// A reading club shown in the Clubs tab.
struct ReadingClub: Identifiable, Hashable {
    let id: String
    let name: String
    let coverURL: String
}

/// A scheduled event under a reading club.
struct ClubEvent: Identifiable, Hashable {
    let id: String
    let clubId: String
    let title: String
    let details: String
    let imageURL: String
}

/// A club member profile.
struct ClubMember: Identifiable, Hashable {
    let id: String
    let name: String
    let avatarURL: String
}

/// A trend card displayed in Insights.
struct VisionTrend: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let imageURL: String
}

/// A curated collection that belongs to an insight trend.
struct VisionCollection: Identifiable, Hashable {
    let id: String
    let trendId: String
    let title: String
    let imageURL: String
}

/// Navigation destinations for the Catalog stack.
enum LibraryCatalogRoute: Hashable {
    case genreDetail(LibraryGenre)
    case bookDetail(LibraryBook)
    case authorDetail(LibraryAuthor)
    case catalogSearch
    case newArrivals
}

/// Navigation destinations for the Clubs stack.
enum LibraryClubRoute: Hashable {
    case clubDetail(ReadingClub)
    case eventDetail(ClubEvent)
    case memberDetail(ClubMember)
    case clubSettings(ReadingClub)
}

/// Navigation destinations for the Account stack.
enum LibraryAccountRoute: Hashable {
    case readerProfile
    case readingHistory
    case savedList
    case accountSettings
}

/// Navigation destinations for the Insights stack.
enum LibraryInsightRoute: Hashable {
    case trendDetail(VisionTrend)
    case collectionDetail(VisionCollection)
    case featuredBook(LibraryBook)
    case insightLab
}

/// Navigation destinations for the Authors stack.
enum LibraryAuthorRoute: Hashable {
    case authorSpotlight(LibraryAuthor)
    case authorBibliography(LibraryAuthor)
    case legendBook(LibraryBook)
    case interview(LibraryAuthor)
}

/// Describes a single multi-step back menu option.
struct BackNavigationOption: Identifiable, Hashable {
    let steps: Int
    let title: String
    let subtitle: String?
    let systemImage: String
    let remoteImageURL: String?

    /// Stable identifier based on pop distance.
    var id: Int { steps }
}

/// Centralized mock data for the standalone demo.
enum LibraryMockData {
    static let user = LibraryUser(
        name: "Nora Reader",
        avatarURL: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=160&q=80"
    )

    static let genres: [LibraryGenre] = [
        LibraryGenre(
            id: 1,
            name: "Sci-Fi",
            description: "Future worlds and big ideas",
            logoURL: "https://images.unsplash.com/photo-1518770660439-4636190af475?w=160&q=80"
        ),
        LibraryGenre(
            id: 2,
            name: "Mystery",
            description: "Detectives and hidden clues",
            logoURL: "https://images.unsplash.com/photo-1521587760476-6c12a4b040da?w=160&q=80"
        ),
        LibraryGenre(
            id: 3,
            name: "History",
            description: "Stories from real events",
            logoURL: "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=160&q=80"
        )
    ]

    static let authors: [LibraryAuthor] = [
        LibraryAuthor(
            id: 1,
            name: "Isaac Dalton",
            portraitURL: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=160&q=80",
            bio: "Award-winning speculative fiction author."
        ),
        LibraryAuthor(
            id: 2,
            name: "Elena Ward",
            portraitURL: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=160&q=80",
            bio: "Known for layered mysteries and strong characters."
        ),
        LibraryAuthor(
            id: 3,
            name: "Milan Kovacs",
            portraitURL: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=160&q=80",
            bio: "Historian and storyteller of Central Europe."
        )
    ]

    static let books: [LibraryBook] = [
        LibraryBook(
            id: 100,
            genreId: 1,
            authorId: 1,
            title: "Orbit City",
            subtitle: "A colony at the edge of silence",
            coverURL: "https://images.unsplash.com/photo-1512820790803-83ca734da794?w=200&q=80"
        ),
        LibraryBook(
            id: 101,
            genreId: 1,
            authorId: 1,
            title: "Lunar Archive",
            subtitle: "Secrets buried in frozen code",
            coverURL: "https://images.unsplash.com/photo-1532012197267-da84d127e765?w=200&q=80"
        ),
        LibraryBook(
            id: 102,
            genreId: 2,
            authorId: 2,
            title: "Fog Over Bridge Street",
            subtitle: "One night, three suspects",
            coverURL: "https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=200&q=80"
        ),
        LibraryBook(
            id: 103,
            genreId: 2,
            authorId: 2,
            title: "The Last Red Key",
            subtitle: "A code no one should solve",
            coverURL: "https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=200&q=80"
        ),
        LibraryBook(
            id: 104,
            genreId: 3,
            authorId: 3,
            title: "Danube Diaries",
            subtitle: "Cities, empires, and memory",
            coverURL: "https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?w=200&q=80"
        ),
        LibraryBook(
            id: 105,
            genreId: 3,
            authorId: 3,
            title: "Letters from Buda",
            subtitle: "A century through personal notes",
            coverURL: "https://images.unsplash.com/photo-1516979187457-637abb4f9353?w=200&q=80"
        )
    ]

    static let clubs: [ReadingClub] = [
        ReadingClub(
            id: "club-1",
            name: "Friday Fiction Club",
            coverURL: "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=600&q=80"
        ),
        ReadingClub(
            id: "club-2",
            name: "History Circle",
            coverURL: "https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=600&q=80"
        )
    ]

    static let events: [ClubEvent] = [
        ClubEvent(
            id: "event-1",
            clubId: "club-1",
            title: "Sci-Fi Night",
            details: "Panel + quick review challenge",
            imageURL: "https://images.unsplash.com/photo-1484417894907-623942c8ee29?w=240&q=80"
        ),
        ClubEvent(
            id: "event-2",
            clubId: "club-1",
            title: "Mystery Debate",
            details: "Best ending in modern mysteries",
            imageURL: "https://images.unsplash.com/photo-1455885666463-9dca8f2d93f7?w=240&q=80"
        ),
        ClubEvent(
            id: "event-3",
            clubId: "club-2",
            title: "Archive Walk",
            details: "Photo notes from old city libraries",
            imageURL: "https://images.unsplash.com/photo-1455390582262-044cdead277a?w=240&q=80"
        )
    ]

    static let members: [ClubMember] = [
        ClubMember(
            id: "member-1",
            name: "Anna Kovacs",
            avatarURL: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=160&q=80"
        ),
        ClubMember(
            id: "member-2",
            name: "Bence Toth",
            avatarURL: "https://images.unsplash.com/photo-1504593811423-6dd665756598?w=160&q=80"
        ),
        ClubMember(
            id: "member-3",
            name: "Lea Simon",
            avatarURL: "https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=160&q=80"
        )
    ]

    static let trends: [VisionTrend] = [
        VisionTrend(
            id: "trend-1",
            title: "Short Chapter Trend",
            subtitle: "Readers finish more in under 20 minutes",
            imageURL: "https://images.unsplash.com/photo-1476275466078-4007374efbbe?w=240&q=80"
        ),
        VisionTrend(
            id: "trend-2",
            title: "Retro Mystery Boom",
            subtitle: "Vintage detective stories are back",
            imageURL: "https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=240&q=80"
        ),
        VisionTrend(
            id: "trend-3",
            title: "Local History Picks",
            subtitle: "Regional stories gain momentum",
            imageURL: "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=240&q=80"
        )
    ]

    static let collections: [VisionCollection] = [
        VisionCollection(
            id: "collection-1",
            trendId: "trend-1",
            title: "Quick Sci-Fi",
            imageURL: "https://images.unsplash.com/photo-1512820790803-83ca734da794?w=240&q=80"
        ),
        VisionCollection(
            id: "collection-2",
            trendId: "trend-2",
            title: "Noir Essentials",
            imageURL: "https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=240&q=80"
        ),
        VisionCollection(
            id: "collection-3",
            trendId: "trend-3",
            title: "Budapest Archives",
            imageURL: "https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?w=240&q=80"
        )
    ]

    /// Returns books belonging to the given genre.
    static func books(for genre: LibraryGenre) -> [LibraryBook] {
        books.filter { $0.genreId == genre.id }
    }

    /// Returns books written by the given author.
    static func books(for author: LibraryAuthor) -> [LibraryBook] {
        books.filter { $0.authorId == author.id }
    }

    /// Looks up the author of a given book.
    static func author(for book: LibraryBook) -> LibraryAuthor? {
        authors.first { $0.id == book.authorId }
    }

    /// Returns events for a given reading club.
    static func events(for club: ReadingClub) -> [ClubEvent] {
        events.filter { $0.clubId == club.id }
    }

    /// Returns collections tied to a trend.
    static func collections(for trend: VisionTrend) -> [VisionCollection] {
        collections.filter { $0.trendId == trend.id }
    }

    /// Returns featured books associated with a collection.
    static func featuredBooks(for collection: VisionCollection) -> [LibraryBook] {
        switch collection.id {
        case "collection-1":
            return books.filter { $0.genreId == 1 }
        case "collection-2":
            return books.filter { $0.genreId == 2 }
        default:
            return books.filter { $0.genreId == 3 }
        }
    }
}
