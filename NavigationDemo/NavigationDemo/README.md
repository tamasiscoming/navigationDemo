# App Module README

This folder contains the standalone SwiftUI library navigation demo app.

## iOS Requirement
- Minimum supported version: **iOS 17.0**

## What is inside
- `LibraryModels.swift`: entities, routes, and mock data
- `LibraryNavigationManager.swift`: tab-aware navigation state and back option logic
- `LibraryToolbar.swift`: custom toolbar with tap/long-press back behavior
- `LibraryTabView.swift`: 5-tab root container with independent `NavigationStack` paths
- `Library*Screen.swift`: feature screens per tab
- `LibraryUIComponents.swift`: reusable view components
- `PreviewSupport.swift`: shared preview hosts

## Preview Coverage
All screens and reusable UI components include SwiftUI previews.

## Profile Shortcut Behavior
`openReaderProfileShortcut()` always does:
1. `LibraryNavigation.resetAccount()`
2. `LibraryNavigation.toAccount(.readerProfile)`

This ensures profile navigation is deterministic from any primary screen.
