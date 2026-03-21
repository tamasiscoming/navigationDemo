import SwiftUI

/// Opens the reader profile from anywhere by resetting the account stack first.
@MainActor
func openReaderProfileShortcut() {
    LibraryNavigation.resetAccount()
    LibraryNavigation.toAccount(.readerProfile)
}

/// Generic titled section used by most demo screens.
struct AppSection<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            VStack(alignment: .leading, spacing: 10) {
                content
            }
        }
    }
}

/// Compact information card with optional remote image.
struct InfoCard: View {
    let title: String
    let subtitle: String
    var imageURL: String? = nil
    var systemImage: String = "book"

    var body: some View {
        HStack(spacing: 12) {
            if let imageURL,
               let url = URL(string: imageURL)
            {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                }
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            } else {
                Image(systemName: systemImage)
                    .font(.title3)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

/// Basic text container card.
struct TextCard: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.subheadline)
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            )
    }
}

/// Row representation for a genre entity.
struct GenreRow: View {
    let genre: LibraryGenre

    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: genre.logoURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.gray.opacity(0.2))
            }
            .frame(width: 24, height: 24)
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))

            VStack(alignment: .leading, spacing: 2) {
                Text(genre.name)
                    .font(.subheadline.weight(.semibold))
                Text(genre.description)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

/// Row representation for a book entity.
struct BookRow: View {
    let book: LibraryBook

    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: book.coverURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.gray.opacity(0.2))
            }
            .frame(width: 28, height: 38)
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))

            VStack(alignment: .leading, spacing: 2) {
                Text(book.title)
                    .font(.subheadline.weight(.semibold))
                Text(book.subtitle)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

/// Row representation for a reading club.
struct ClubRow: View {
    let club: ReadingClub

    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: club.coverURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
            }
            .frame(width: 44, height: 32)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            Text(club.name)
                .font(.subheadline.weight(.semibold))

            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

/// Row representation for a club event.
struct EventRow: View {
    let event: ClubEvent

    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: event.imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
            }
            .frame(width: 44, height: 32)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            VStack(alignment: .leading, spacing: 2) {
                Text(event.title)
                    .font(.subheadline.weight(.semibold))
                Text(event.details)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

/// Row representation for a person-like item with avatar.
struct PersonRow: View {
    let name: String
    let imageURL: String

    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Circle().fill(Color.gray.opacity(0.2))
            }
            .frame(width: 24, height: 24)
            .clipShape(Circle())

            Text(name)
                .font(.subheadline.weight(.semibold))
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

struct LibraryUIComponents_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                AppSection(title: "Section") {
                    Text("Preview content")
                }
                InfoCard(
                    title: LibraryMockData.books[0].title,
                    subtitle: LibraryMockData.books[0].subtitle,
                    imageURL: LibraryMockData.books[0].coverURL
                )
                TextCard(text: "Reusable text card preview.")
                GenreRow(genre: LibraryMockData.genres[0])
                BookRow(book: LibraryMockData.books[0])
                ClubRow(club: LibraryMockData.clubs[0])
                EventRow(event: LibraryMockData.events[0])
                PersonRow(name: LibraryMockData.authors[0].name, imageURL: LibraryMockData.authors[0].portraitURL)
            }
            .padding()
        }
        .previewDisplayName("UI Components")
    }
}
