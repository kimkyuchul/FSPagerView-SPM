// BasicPagerViewController.swift
// A minimal UIKit example of FSPagerView with infinite scrolling and auto-sliding.

import UIKit
import FSPagerViewSwift

final class BasicPagerViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {

    private let pagerView = FSPagerView()
    private let pageControl = FSPageControl()
    private let images = ["photo", "star.fill", "heart.fill", "bell.fill", "bookmark.fill"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Configure pager view
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.isInfinite = true                  // Enable infinite loop scrolling
        pagerView.automaticSlidingInterval = 3.0     // Auto-slide every 3 seconds

        // Configure page control indicator colors
        pageControl.numberOfPages = images.count
        pageControl.setFillColor(.white, for: .selected)
        pageControl.setFillColor(.gray, for: .normal)

        pagerView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pagerView)
        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pagerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagerView.heightAnchor.constraint(equalToConstant: 300),
            pageControl.bottomAnchor.constraint(equalTo: pagerView.bottomAnchor, constant: -16),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    // MARK: - FSPagerViewDataSource

    func numberOfItems(in pagerView: FSPagerView) -> Int { images.count }

    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        // imageView and textLabel are lazily created on first access
        cell.imageView?.image = UIImage(systemName: images[index])
        cell.imageView?.contentMode = .scaleAspectFit
        cell.textLabel?.text = images[index]
        return cell
    }

    // MARK: - FSPagerViewDelegate

    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }

    /// Sync page control with the current pager index on scroll.
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        pageControl.currentPage = pagerView.currentIndex
    }
}
