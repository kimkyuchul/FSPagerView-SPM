// FSPagerRepresentable.swift
// A reusable UIViewRepresentable wrapper for FSPagerView and FSPageControl.

import SwiftUI
import FSPagerViewSwift

struct FSPagerBannerView<Item: Hashable>: UIViewRepresentable {

    let items: [Item]
    @Binding var currentPage: Int
    var isInfinite: Bool = true
    var automaticSlidingInterval: CGFloat = 0
    var transformerType: FSPagerViewTransformerType? = nil
    var itemSize: CGSize? = nil
    let configureCell: (Item, FSPagerViewCell) -> Void

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIView(context: Context) -> FSPagerView {
        let view = FSPagerView()
        view.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        view.dataSource = context.coordinator
        view.delegate = context.coordinator
        return view
    }

    /// Called on every SwiftUI state change — keep coordinator in sync and reapply configuration.
    func updateUIView(_ view: FSPagerView, context: Context) {
        context.coordinator.parent = self
        view.isInfinite = isInfinite
        view.automaticSlidingInterval = automaticSlidingInterval
        // Falls back to automaticSize (fills entire pager) when nil.
        view.itemSize = itemSize ?? FSPagerView.automaticSize

        if let transformerType {
            view.transformer = FSPagerViewTransformer(type: transformerType)
        }

        view.reloadData()
    }

    /// @MainActor is required for Swift 6 strict concurrency since Coordinator accesses UIKit views.
    @MainActor
    final class Coordinator: NSObject, FSPagerViewDataSource, FSPagerViewDelegate {
        var parent: FSPagerBannerView

        init(_ parent: FSPagerBannerView) { self.parent = parent }

        func numberOfItems(in pagerView: FSPagerView) -> Int { parent.items.count }

        func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
            parent.configureCell(parent.items[index], cell)
            return cell
        }

        func pagerViewDidScroll(_ pagerView: FSPagerView) {
            parent.currentPage = pagerView.currentIndex
        }
    }
}

struct FSPageControlRepresentable: UIViewRepresentable {

    var numberOfPages: Int
    var currentPage: Int

    func makeUIView(context: Context) -> FSPageControl {
        let control = FSPageControl()
        control.setFillColor(.white, for: .selected)
        control.setFillColor(.gray, for: .normal)
        return control
    }

    func updateUIView(_ control: FSPageControl, context: Context) {
        control.numberOfPages = numberOfPages
        control.currentPage = currentPage
    }
}
