import SwiftUI

/// Root Authors screen with spotlight links.
struct LibraryAuthorsHomeScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AppSection(title: "Author Legends") {
                    ForEach(LibraryMockData.authors) { author in
                        Button {
                            nav.toAuthors(.authorSpotlight(author))
                        } label: {
                            PersonRow(name: author.name, imageURL: author.portraitURL)
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
            principalTitle: "Authors"
        )
    }
}

/// Author spotlight screen with bibliography and interview actions.
struct AuthorSpotlightScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let author: LibraryAuthor

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: author.name,
                    subtitle: author.bio,
                    imageURL: author.portraitURL,
                    systemImage: "star"
                )

                Button("Open Bibliography") {
                    nav.toAuthors(.authorBibliography(author))
                }
                .buttonStyle(.bordered)

                Button("Listen to Interview") {
                    nav.toAuthors(.interview(author))
                }
                .buttonStyle(.bordered)
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: author.name
        )
    }
}

/// Bibliography screen for a selected author.
struct AuthorBibliographyScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let author: LibraryAuthor

    private var books: [LibraryBook] {
        LibraryMockData.books(for: author)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AppSection(title: "Books") {
                    ForEach(books) { book in
                        Button {
                            nav.toAuthors(.legendBook(book))
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
            principalTitle: "Bibliography"
        )
    }
}

/// Book detail screen inside the Authors stack.
struct LegendBookScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let book: LibraryBook

    private var author: LibraryAuthor? {
        LibraryMockData.author(for: book)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: book.title,
                    subtitle: book.subtitle,
                    imageURL: book.coverURL,
                    systemImage: "book.closed"
                )

                if let author {
                    Button("Open Interview with \(author.name)") {
                        nav.toAuthors(.interview(author))
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Legend Book"
        )
    }
}

/// Interview screen for a selected author.
struct AuthorInterviewScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let author: LibraryAuthor

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: "Interview",
                    subtitle: author.name,
                    imageURL: author.portraitURL,
                    systemImage: "mic"
                )
                TextCard(text: "Mock interview screen for deeper navigation testing.")
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Interview"
        )
    }
}

struct LibraryAuthorsScreens_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LibraryScreenPreviewHost {
                LibraryAuthorsHomeScreen()
            }
            .previewDisplayName("Authors Home")

            LibraryScreenPreviewHost {
                AuthorSpotlightScreen(author: LibraryMockData.authors[0])
            }
            .previewDisplayName("Author Spotlight")

            LibraryScreenPreviewHost {
                AuthorBibliographyScreen(author: LibraryMockData.authors[0])
            }
            .previewDisplayName("Author Bibliography")

            LibraryScreenPreviewHost {
                LegendBookScreen(book: LibraryMockData.books[0])
            }
            .previewDisplayName("Legend Book")

            LibraryScreenPreviewHost {
                AuthorInterviewScreen(author: LibraryMockData.authors[0])
            }
            .previewDisplayName("Author Interview")
        }
    }
}
