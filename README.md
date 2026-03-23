# Library Navigation Demo (SwiftUI)

A standalone iOS SwiftUI navigation demo built around a library theme, with realistic mock data and multi-step back navigation.

## iOS Requirement
- Minimum supported version: **iOS 16.0**
- Built and tested with modern Xcode toolchains (project format may be newer, but deployment target is iOS 16.0)

## Highlights
- 5 independent tab stacks: `Catalog`, `Clubs`, `Account`, `Insights`, `Authors`
- Central manager: `LibraryNavigationManager`
- Per-tab paths for safe tab switching without losing navigation state
- Custom back behavior via `Menu(primaryAction:)`
  - Tap: pop 1 screen
  - Long press: choose a specific pop depth
- Context-aware back labels and optional remote thumbnails
- Global profile shortcut from top-left avatar/name to `Reader Profile`

## Project Structure
- Xcode project: `NavigationDemo/NavigationDemo.xcodeproj`
- App sources: `NavigationDemo/NavigationDemo/`

## Main Files
- `LibraryModels.swift`
- `LibraryNavigationManager.swift`
- `LibraryToolbar.swift`
- `LibraryUIComponents.swift`
- `LibraryTabView.swift`
- `LibraryCatalogScreen.swift`
- `LibraryClubsScreen.swift`
- `LibraryAccountScreen.swift`
- `LibraryInsightsScreen.swift`
- `LibraryAuthorsScreen.swift`
- `PreviewSupport.swift`

## Documentation & Previews
- English inline `///` documentation is included across core models, navigation logic, and views.
- SwiftUI previews are provided for all screens and reusable UI components.

## Run
1. Open `NavigationDemo/NavigationDemo.xcodeproj` in Xcode.
2. Select the `NavigationDemo` scheme.
3. Run on an iOS simulator.
