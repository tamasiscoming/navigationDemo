import SwiftUI

/// Root Insights screen with trend cards and an insight lab shortcut.
struct LibraryInsightsHomeScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AppSection(title: "Reading Trends") {
                    ForEach(LibraryMockData.trends) { trend in
                        Button {
                            nav.toInsights(.trendDetail(trend))
                        } label: {
                            InfoCard(title: trend.title, subtitle: trend.subtitle, imageURL: trend.imageURL, systemImage: "sparkles")
                        }
                        .buttonStyle(.plain)
                    }
                }

                Button("Open Insight Lab") {
                    nav.toInsights(.insightLab)
                }
                .buttonStyle(.bordered)
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(
                remoteImageURL: LibraryMockData.user.avatarURL,
                text: LibraryMockData.user.name,
                action: { openReaderProfileShortcut() }
            ),
            principalTitle: "Insights"
        )
    }
}

/// Trend detail screen showing related collections.
struct TrendDetailScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let trend: VisionTrend

    private var collections: [VisionCollection] {
        LibraryMockData.collections(for: trend)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: trend.title,
                    subtitle: trend.subtitle,
                    imageURL: trend.imageURL,
                    systemImage: "waveform.path.ecg"
                )

                AppSection(title: "Collections") {
                    ForEach(collections) { collection in
                        Button {
                            nav.toInsights(.collectionDetail(collection))
                        } label: {
                            InfoCard(title: collection.title, subtitle: "Curated from this trend", imageURL: collection.imageURL, systemImage: "square.stack")
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Trend"
        )
    }
}

/// Collection detail screen showing featured books.
struct CollectionDetailScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let collection: VisionCollection

    private var books: [LibraryBook] {
        LibraryMockData.featuredBooks(for: collection)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: collection.title,
                    subtitle: "Books picked for this insight",
                    imageURL: collection.imageURL,
                    systemImage: "square.stack"
                )

                AppSection(title: "Featured Books") {
                    ForEach(books) { book in
                        Button {
                            nav.toInsights(.featuredBook(book))
                        } label: {
                            BookRow(book: book)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Collection"
        )
    }
}

/// Featured book details for an insight collection.
struct FeaturedBookScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let book: LibraryBook

    private var authorName: String {
        LibraryMockData.author(for: book)?.name ?? "Unknown Author"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: book.title,
                    subtitle: "\(authorName) • \(book.subtitle)",
                    imageURL: book.coverURL,
                    systemImage: "book"
                )
                TextCard(text: "Third depth example in Insights navigation.")
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Featured Book"
        )
    }
}

/// Lightweight analytics mock screen.
struct InsightLabScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TextCard(text: "Simple mock analytics space. Tap any trend to go 3 levels deep.")
                ForEach(LibraryMockData.trends) { trend in
                    Button(trend.title) {
                        nav.toInsights(.trendDetail(trend))
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Insight Lab"
        )
    }
}

struct LibraryInsightsScreens_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LibraryScreenPreviewHost {
                LibraryInsightsHomeScreen()
            }
            .previewDisplayName("Insights Home")

            LibraryScreenPreviewHost {
                TrendDetailScreen(trend: LibraryMockData.trends[0])
            }
            .previewDisplayName("Trend Detail")

            LibraryScreenPreviewHost {
                CollectionDetailScreen(collection: LibraryMockData.collections[0])
            }
            .previewDisplayName("Collection Detail")

            LibraryScreenPreviewHost {
                FeaturedBookScreen(book: LibraryMockData.books[0])
            }
            .previewDisplayName("Featured Book")

            LibraryScreenPreviewHost {
                InsightLabScreen()
            }
            .previewDisplayName("Insight Lab")
        }
    }
}
