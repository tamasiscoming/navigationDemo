import SwiftUI

/// Reusable toolbar item descriptor for custom navigation bars.
struct ToolbarActionItem {
    var systemImage: String? = nil
    var remoteImageURL: String? = nil
    var text: String? = nil
    var action: (() -> Void)? = nil
}

/// Custom toolbar modifier with single-tap and long-press back navigation.
struct CustomToolbarModifier: ViewModifier {
    let leading: ToolbarActionItem?
    let principalTitle: String?
    let trailing: ToolbarActionItem?
    let trailingSecondary: ToolbarActionItem?

    @EnvironmentObject private var nav: LibraryNavigationManager

    private var backOptions: [BackNavigationOption] {
        nav.currentBackNavigationOptions()
    }

    private func isBackButton(_ item: ToolbarActionItem) -> Bool {
        let icon = (item.systemImage ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        return icon == "chevron.backward" || icon == "chevron.left"
    }

    private func normalizedURL(_ value: String?) -> URL? {
        guard let value else { return nil }
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        return URL(string: trimmed)
    }

    @ViewBuilder
    private func itemLabel(_ item: ToolbarActionItem) -> some View {
        HStack(spacing: 8) {
            if let remoteURL = normalizedURL(item.remoteImageURL) {
                AsyncImage(url: remoteURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle().fill(Color.gray.opacity(0.2))
                }
                .frame(width: 28, height: 28)
                .clipShape(Circle())
            } else if let icon = item.systemImage {
                Image(systemName: icon)
                    .font(.body.weight(.semibold))
            }

            if let text = item.text {
                Text(text)
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)
            }
        }
    }

    @ViewBuilder
    private func backOptionLabel(_ option: BackNavigationOption) -> some View {
        HStack(spacing: 8) {
            if let remoteURL = normalizedURL(option.remoteImageURL) {
                AsyncImage(url: remoteURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                }
                .frame(width: 20, height: 20)
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
            } else {
                Image(systemName: option.systemImage)
                    .font(.caption.weight(.semibold))
                    .frame(width: 20)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(option.title)
                    .lineLimit(1)
                if let subtitle = option.subtitle {
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
        }
    }

    private func handlePrimaryBack(fallbackAction: (() -> Void)?) {
        if let fallbackAction {
            fallbackAction()
        } else {
            nav.popCurrent(by: 1)
        }
    }

    @ViewBuilder
    private func leadingControl(_ item: ToolbarActionItem) -> some View {
        if isBackButton(item), !backOptions.isEmpty {
            Menu {
                ForEach(backOptions) { option in
                    Button {
                        nav.popCurrent(by: option.steps)
                    } label: {
                        backOptionLabel(option)
                    }
                }
            } label: {
                itemLabel(item)
            } primaryAction: {
                handlePrimaryBack(fallbackAction: item.action)
            }
        } else {
            Button {
                item.action?()
            } label: {
                itemLabel(item)
            }
        }
    }

    @ViewBuilder
    private func trailingControl(_ item: ToolbarActionItem) -> some View {
        Button {
            item.action?()
        } label: {
            itemLabel(item)
        }
    }

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if let leading {
                    ToolbarItem(placement: .topBarLeading) {
                        leadingControl(leading)
                    }
                }

                if let principalTitle {
                    ToolbarItem(placement: .principal) {
                        Text(principalTitle)
                            .font(.headline)
                            .lineLimit(1)
                    }
                }

                if trailing != nil || trailingSecondary != nil {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(spacing: 12) {
                            if let trailingSecondary {
                                trailingControl(trailingSecondary)
                            }
                            if let trailing {
                                trailingControl(trailing)
                            }
                        }
                    }
                }
            }
    }
}

extension View {
    /// Applies the custom library toolbar configuration.
    func customToolbar(leading: ToolbarActionItem? = nil,
                       principalTitle: String? = nil,
                       trailing: ToolbarActionItem? = nil,
                       trailingSecondary: ToolbarActionItem? = nil) -> some View
    {
        modifier(
            CustomToolbarModifier(
                leading: leading,
                principalTitle: principalTitle,
                trailing: trailing,
                trailingSecondary: trailingSecondary
            )
        )
    }
}

private struct ToolbarShowcaseView: View {
    @EnvironmentObject private var nav: LibraryNavigationManager

    var body: some View {
        Text("Toolbar Preview")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .customToolbar(
                leading: ToolbarActionItem(systemImage: "chevron.backward", action: { nav.popCurrent(by: 1) }),
                principalTitle: "Toolbar",
                trailing: ToolbarActionItem(systemImage: "magnifyingglass", action: {}),
                trailingSecondary: ToolbarActionItem(systemImage: "bell", action: {})
            )
    }
}

struct LibraryToolbar_Previews: PreviewProvider {
    static var previews: some View {
        LibraryScreenPreviewHost {
            ToolbarShowcaseView()
        }
        .previewDisplayName("Toolbar")
    }
}
