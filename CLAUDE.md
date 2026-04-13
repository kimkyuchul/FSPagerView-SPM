# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

FSPagerView-SPM is a Swift Package Manager fork of [FSPagerView](https://github.com/WenchaoD/FSPagerView), updated for **Swift 6.0** compatibility. It provides a UICollectionView-based pager/slider library for iOS (banners, carousels, onboarding screens).

## Architecture

The library is a single SPM package with two targets:

- **FSPagerViewObjC** — Minimal Objective-C target (`FSPagerViewObjcCompat.{h,m}`) that defines two constants (`FSPagerViewAutomaticDistance`, `FSPagerViewAutomaticSize`) for Obj-C interop.
- **FSPagerViewSwift** — The main Swift target, depends on FSPagerViewObjC. All public API lives here. Import as `import FSPagerViewSwift`.

### Key Swift types (all in `Sources/FSPagerViewSwift/`)

| File | Type | Role |
|---|---|---|
| `FSPagerView.swift` | `FSPagerView` | Core UIView subclass. Wraps a `UICollectionView`, owns the data source/delegate pattern (`FSPagerViewDataSource`, `FSPagerViewDelegate`), manages infinite scrolling via multiplied sections, and drives auto-sliding with a `Timer`. |
| `FSPagerViewCell.swift` | `FSPagerViewCell` | UICollectionViewCell subclass with built-in `imageView` and `textLabel`. |
| `FSPageViewLayout.swift` | `FSPagerViewLayout` | Custom `UICollectionViewLayout` that computes item frames, spacing, and content offsets for both horizontal/vertical scroll directions. |
| `FSPagerViewLayoutAttributes.swift` | `FSPagerViewLayoutAttributes` | Custom layout attributes carrying a `position` value used by transformers. |
| `FSPageViewTransformer.swift` | `FSPagerViewTransformer` | Applies visual transforms (crossFading, zoomOut, depth, overlap, linear, coverFlow, ferrisWheel, invertedFerrisWheel, cubic) to cells during scrolling. |
| `FSPagerCollectionView.swift` | `FSPagerCollectionView` | Thin UICollectionView subclass. |
| `FSPageControl.swift` | `FSPageControl` | Custom page indicator control with configurable dot shapes, sizes, and colors. |

### Infinite scrolling model

`FSPagerView` achieves infinite scroll by creating `Int16.max / numberOfItems` sections, each containing the same items. The `centermostIndexPath` and `nearbyIndexPath(for:)` methods handle mapping between the multiplied index space and the logical item index.

## Platform & Toolchain

- iOS 15.0+ minimum deployment target
- Swift tools version 6.0
- No test suite
