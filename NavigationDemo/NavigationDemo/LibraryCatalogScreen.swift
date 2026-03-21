import SwiftUI

/// Root screen for browsing genres and quick catalog actions.
struct LibraryCatalogHomeScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AppSection(title: "Genres") {
                    ForEach(LibraryMockData.genres) { genre in
                        Button {
                            nav.toCatalog(.genreDetail(genre))
                        } label: {
                            GenreRow(genre: genre)
                        }
                        .buttonStyle(.plain)
                    }
                }

                AppSection(title: "Quick Actions") {
                    Button("New Arrivals") {
                        nav.toCatalog(.newArrivals)
                    }
                    Button("Catalog Search") {
                        nav.toCatalog(.catalogSearch)
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
            principalTitle: "Catalog"
        )
    }
}

/// Genre detail screen that lists books for the selected genre.
struct GenreDetailScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let genre: LibraryGenre

    private var books: [LibraryBook] {
        LibraryMockData.books(for: genre)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: genre.name,
                    subtitle: genre.description,
                    imageURL: genre.logoURL,
                    systemImage: "books.vertical"
                )

                AppSection(title: "Books") {
                    ForEach(books) { book in
                        Button {
                            nav.toCatalog(.bookDetail(book))
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
            principalTitle: genre.name
        )
    }
}

/// Book detail screen that optionally links to the author detail screen.
struct BookDetailScreen: View {
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
                    systemImage: "book"
                )

                if let author {
                    AppSection(title: "Author") {
                        Button {
                            nav.toCatalog(.authorDetail(author))
                        } label: {
                            PersonRow(name: author.name, imageURL: author.portraitURL)
                        }
                        .buttonStyle(.plain)
                    }
                }

                TextCard(text: "Simple mock detail screen for demoing multi-step back navigation.")
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Book Detail"
        )
    }
}

/// Author detail screen within the Catalog stack.
struct AuthorDetailScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager
    let author: LibraryAuthor

    private var books: [LibraryBook] {
        LibraryMockData.books(for: author)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoCard(
                    title: author.name,
                    subtitle: author.bio,
                    imageURL: author.portraitURL,
                    systemImage: "person"
                )

                AppSection(title: "Books by \(author.name)") {
                    ForEach(books) { book in
                        Button {
                            nav.toCatalog(.bookDetail(book))
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
            principalTitle: "Author"
        )
    }
}

/// Mock catalog search screen with quick drill-down links.
struct CatalogSearchScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TextCard(text: "Mock search: pick a genre to drill down into a 3-level path.")
                AppSection(title: "Popular Now") {
                    ForEach(LibraryMockData.genres) { genre in
                        Button {
                            nav.toCatalog(.genreDetail(genre))
                        } label: {
                            GenreRow(genre: genre)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(16)
        }
        .customToolbar(
            leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
            principalTitle: "Catalog Search"
        )
    }
}

/// Mock new arrivals list.
struct NewArrivalsScreen: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AppSection(title: "This Week") {
                    ForEach(LibraryMockData.books.prefix(4)) { book in
                        Button {
                            nav.toCatalog(.bookDetail(book))
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
            principalTitle: "New Arrivals"
        )
    }
}

struct LibraryCatalogScreens_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LibraryScreenPreviewHost {
                LibraryCatalogHomeScreen()
            }
            .previewDisplayName("Catalog Home")

            LibraryScreenPreviewHost {
                GenreDetailScreen(genre: LibraryMockData.genres[0])
            }
            .previewDisplayName("Genre Detail")

            LibraryScreenPreviewHost {
                BookDetailScreen(book: LibraryMockData.books[0])
            }
            .previewDisplayName("Book Detail")

            LibraryScreenPreviewHost {
                AuthorDetailScreen(author: LibraryMockData.authors[0])
            }
            .previewDisplayName("Author Detail")

            LibraryScreenPreviewHost {
                CatalogSearchScreen()
            }
            .previewDisplayName("Catalog Search")

            LibraryScreenPreviewHost {
                NewArrivalsScreen()
            }
            .previewDisplayName("New Arrivals")
        }
    }
}
