// FSPagerSwiftUIExample.swift
// SwiftUI usage examples for FSPagerView.

import SwiftUI
import FSPagerViewSwift

// MARK: - Basic

struct BasicPagerExampleView: View {

    @State private var currentPage = 0
    private let items = ["photo", "star.fill", "heart.fill", "bell.fill", "bookmark.fill"]

    var body: some View {
        ZStack(alignment: .bottom) {
            FSPagerBannerView(
                items: items,
                currentPage: $currentPage,
                automaticSlidingInterval: 3.0
            ) { item, cell in
                cell.imageView?.image = UIImage(systemName: item)
                cell.imageView?.contentMode = .scaleAspectFit
                cell.textLabel?.text = item
            }

            FSPageControlRepresentable(numberOfPages: items.count, currentPage: currentPage)
                .frame(height: 20)
                .padding(.bottom, 16)
        }
        .frame(height: 300)
    }
}

// MARK: - Transformer

struct TransformerPagerExampleView: View {

    @State private var currentPage = 0
    private let items = ["photo", "star.fill", "heart.fill", "bell.fill", "bookmark.fill"]

    var body: some View {
        // itemSize must be smaller than the pager view to reveal adjacent cells.
        FSPagerBannerView(
            items: items,
            currentPage: $currentPage,
            transformerType: .coverFlow,
            itemSize: CGSize(width: 200, height: 260)
        ) { item, cell in
            cell.imageView?.image = UIImage(systemName: item)
            cell.imageView?.contentMode = .scaleAspectFit
        }
        .frame(height: 300)
    }
}

#Preview("Basic") { BasicPagerExampleView() }
#Preview("Transformer") { TransformerPagerExampleView() }
