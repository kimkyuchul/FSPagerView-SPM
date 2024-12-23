//
//  FSPagerViewLayoutAttributes.swift
//  FSPagerViewExample
//
//  Created by Wenchao Ding on 26/02/2017.
//  Copyright © 2017 Wenchao Ding. All rights reserved.
//

import UIKit

open class FSPagerViewLayoutAttributes: UICollectionViewLayoutAttributes {
    open var position: CGFloat = 0

    open override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? FSPagerViewLayoutAttributes else {
            return false
        }
        
        var isEqual = super.isEqual(object)
        
        MainActor.assumeIsolated {
            isEqual = isEqual && (self.position == object.position)
        }
        
        return isEqual
    }

    open override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! FSPagerViewLayoutAttributes
        
        // MainActor.assumeIsolated로 메인 스레드에서 실행된다고 가정
        MainActor.assumeIsolated {
            copy.position = self.position
        }
        
        return copy
    }
}
