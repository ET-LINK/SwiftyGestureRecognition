//
//  SwiftyGestureRecognition.swift
//  SwiftyGestureRecognition
//
//  Created by Adam Bell on 1/26/16.
//  Copyright © 2016 Adam Bell. All rights reserved.
//

import ObjectiveC
import UIKit

public typealias UIGestureRecognizerStateChangeBlock = ((_ gestureRecognizer: UIGestureRecognizer) -> Void)

private class UIGestureRecognizerStateChangeBlockHost {
  
  weak var gestureRecognizer: UIGestureRecognizer?
  
  var block: [UIGestureRecognizer.State: UIGestureRecognizerStateChangeBlock] = [:]
  
  init(gestureRecognizer: UIGestureRecognizer) {
    self.gestureRecognizer = gestureRecognizer
    gestureRecognizer.addTarget(self, action: #selector(gestureRecognizerStateChanged))
  }
  
  deinit {
    gestureRecognizer?.removeTarget(self, action: #selector(gestureRecognizerStateChanged))
  }
  
  @objc fileprivate func gestureRecognizerStateChanged(_ gestureRecognizer: UIGestureRecognizer) {
    if let stateChangeBlock = block[gestureRecognizer.state] {
      stateChangeBlock(gestureRecognizer)
    }
  }
  
}

public extension UIGestureRecognizer {
  
  fileprivate struct AssociatedBlockHost {
    static var blockHost = "blockHost"
  }
  
  fileprivate var blockHost: UIGestureRecognizerStateChangeBlockHost {
    get {
      if let blockHost = objc_getAssociatedObject(self, &AssociatedBlockHost.blockHost) as? UIGestureRecognizerStateChangeBlockHost {
        return blockHost
      } else {
        let blockHost = UIGestureRecognizerStateChangeBlockHost(gestureRecognizer: self)
        objc_setAssociatedObject(self, &AssociatedBlockHost.blockHost, blockHost, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return blockHost
      }
    }
  }
  
  convenience init(view: UIView) {
    self.init()
    view.addGestureRecognizer(self)
  }
  
  func didBegin(_ didBegin: UIGestureRecognizerStateChangeBlock?) -> UIGestureRecognizer {
    blockHost.block[.began] = didBegin
    return self
  }
  
  func didChange(_ didChange: UIGestureRecognizerStateChangeBlock?) -> UIGestureRecognizer {
    blockHost.block[.changed] = didChange
    return self
  }
  
  func didEnd(_ didEnd: UIGestureRecognizerStateChangeBlock?) -> UIGestureRecognizer {
    blockHost.block[.ended] = didEnd
    return self
  }
  
  func didCancel(_ didCancel: UIGestureRecognizerStateChangeBlock?) -> UIGestureRecognizer {
    blockHost.block[.cancelled] = didCancel
    return self
  }
  
  func didFail(_ didFail: UIGestureRecognizerStateChangeBlock?) -> UIGestureRecognizer {
    blockHost.block[.failed] = didFail
    return self
  }
  
}
