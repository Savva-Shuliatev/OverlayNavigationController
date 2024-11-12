//
//  OverlayNavigationController.swift
//  OverlayNavigationController
//
//  Copyright (c) 2024 Savva Shuliatev
//  This code is covered by the MIT License.
//

import UIKit

open class OverlayNavigationController: UINavigationController {

  private lazy var proxyDelegate = NavigationControllerDelegateProxy(originalDelegate: nil)

  open override var delegate: UINavigationControllerDelegate? {
    get {
      return proxyDelegate.originalDelegate
    }
    set {
      proxyDelegate.originalDelegate = newValue
      super.delegate = proxyDelegate
    }
  }

}
