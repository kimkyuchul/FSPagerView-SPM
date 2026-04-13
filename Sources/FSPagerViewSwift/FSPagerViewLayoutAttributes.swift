//
//  FSPagerViewLayoutAttributes.swift
//  FSPagerViewExample
//
//  Created by Wenchao Ding on 26/02/2017.
//  Copyright © 2017 Wenchao Ding. All rights reserved.
//

import UIKit

open class FSPagerViewLayoutAttributes: UICollectionViewLayoutAttributes {
      // CGFloat is a value type and layout attributes follow a copy-on-use pattern,
      // so there is no risk of concurrent access from different threads.
      nonisolated(unsafe) open var position: CGFloat = 0

      open override func isEqual(_ object: Any?) -> Bool {
          guard let object = object as? FSPagerViewLayoutAttributes else {
              return false
          }
          return super.isEqual(object) && (self.position == object.position)
      }

      open override func copy(with zone: NSZone? = nil) -> Any {
          let copy = super.copy(with: zone) as! FSPagerViewLayoutAttributes
          copy.position = self.position
          return copy
      }
  }
