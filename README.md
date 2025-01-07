# FSPagerView-SPM (Swift 6.0)

A Swift Package Manager version of FSPagerView, fully compatible with **Swift 6.0**. This package provides an elegant slider library for iOS applications with various customization options and transition effects.

## Features
- Infinite scrolling
- Automatic sliding
- Custom transitions and transformations
- Customizable cell content
- Page control integration
- Support for both UIKit and SwiftUI

## Requirements
- iOS 15.0+
- Swift 6.0+
- Xcode 15.0+

## Installation

### Swift Package Manager

1. In Xcode, select `File` → `Add Packages...`
2. Enter the package URL: `https://github.com/kimkyuchul/FSPagerView-SPM`
3. Select the version or branch you want to use
4. Click `Add Package`

Alternatively, you can add the following dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/kimkyuchul/FSPagerView-SPM", from: "1.3.5")
]
```

## Usage

### Import the package
```swift
import FSPagerViewSwift
```

### Basic UIKit Implementation
```swift
class ViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    private let pagerView = FSPagerView()
    private let pageControl = FSPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure PagerView
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.dataSource = self
        pagerView.delegate = self
        
        // Configure PageControl
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
    }
    
    // MARK: - FSPagerView DataSource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 5
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: "image\(index)")
        return cell
    }
}
```

### SwiftUI Implementation
```swift
import SwiftUI
import FSPagerViewSwift

public struct FSPagerBannerView: UIViewRepresentable {
  private let bannerView = FSPagerView()
...
...
...
```

## Credits
This package is a Swift Package Manager compatible version of [FSPagerView](https://github.com/WenchaoD/FSPagerView), updated for Swift 6.0 compatibility.

## License
FSPagerView-SPM is available under the MIT license.

## Author
Maintained by [kimkyuchul](https://github.com/kimkyuchul)

---

Feel free to open issues or submit pull requests on the [GitHub repository](https://github.com/kimkyuchul/FSPagerView-SPM).
