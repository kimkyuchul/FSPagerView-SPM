// TransformerPagerViewController.swift
// Demonstrates FSPagerViewTransformer with switchable transform types.

import UIKit
import FSPagerViewSwift

final class TransformerPagerViewController: UIViewController, FSPagerViewDataSource {

    private let pagerView = FSPagerView()
    private let images = ["photo", "star.fill", "heart.fill", "bell.fill", "bookmark.fill"]

    private let types: [(String, FSPagerViewTransformerType)] = [
        ("ZoomOut", .zoomOut), ("Depth", .depth), ("CoverFlow", .coverFlow),
        ("Overlap", .overlap), ("FerrisWheel", .ferrisWheel), ("Cubic", .cubic)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let segment = UISegmentedControl(items: types.map(\.0))
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)

        pagerView.dataSource = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.isInfinite = true

        // itemSize must be smaller than the pager view to reveal adjacent cells.
        pagerView.itemSize = CGSize(width: 200, height: 260)

        segment.translatesAutoresizingMaskIntoConstraints = false
        pagerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segment)
        view.addSubview(pagerView)

        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            pagerView.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 16),
            pagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagerView.heightAnchor.constraint(equalToConstant: 300)
        ])

        applyTransformer(at: 0)
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        applyTransformer(at: sender.selectedSegmentIndex)
    }

    /// Switching transformer triggers an immediate layout recalculation.
    private func applyTransformer(at index: Int) {
        pagerView.transformer = FSPagerViewTransformer(type: types[index].1)
    }

    // MARK: - FSPagerViewDataSource

    func numberOfItems(in pagerView: FSPagerView) -> Int { images.count }

    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(systemName: images[index])
        cell.imageView?.contentMode = .scaleAspectFit
        cell.textLabel?.text = images[index]
        return cell
    }
}
