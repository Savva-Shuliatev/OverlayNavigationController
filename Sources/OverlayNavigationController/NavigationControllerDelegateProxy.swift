//
//  NavigationControllerDelegateProxy.swift
//  OverlayNavigationController
//
//  Copyright (c) 2024 Savva Shuliatev
//  This code is covered by the MIT License.
//

import UIKit

open class NavigationControllerDelegateProxy: NSObject, UINavigationControllerDelegate {

  open weak var originalDelegate: UINavigationControllerDelegate?

  public init(originalDelegate: UINavigationControllerDelegate?) {
    self.originalDelegate = originalDelegate
    super.init()
  }

  open func navigationController(
    _ navigationController: UINavigationController,
    willShow viewController: UIViewController,
    animated: Bool
  ) {
    originalDelegate?.navigationController?(
      navigationController,
      willShow: viewController,
      animated: animated
    )
  }

  open func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {
    originalDelegate?.navigationController?(
      navigationController,
      didShow: viewController,
      animated: animated
    )
  }

  open func navigationControllerSupportedInterfaceOrientations(
    _ navigationController: UINavigationController
  ) -> UIInterfaceOrientationMask {
    return originalDelegate?.navigationControllerSupportedInterfaceOrientations?(navigationController) ?? .all
  }

  open func navigationControllerPreferredInterfaceOrientationForPresentation(
    _ navigationController: UINavigationController
  ) -> UIInterfaceOrientation {
    return originalDelegate?.navigationControllerPreferredInterfaceOrientationForPresentation?(navigationController) ?? .portrait
  }

  open func navigationController(
    _ navigationController: UINavigationController,
    interactionControllerFor animationController: any UIViewControllerAnimatedTransitioning
  ) -> (any UIViewControllerInteractiveTransitioning)? {
    originalDelegate?.navigationController?(
      navigationController,
      interactionControllerFor: animationController
    )
  }

  open func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation: UINavigationController.Operation,
    from fromVC: UIViewController,
    to toVC: UIViewController
  ) -> (any UIViewControllerAnimatedTransitioning)? {
    if let transition = originalDelegate?.navigationController?(
      navigationController,
      animationControllerFor: operation,
      from: fromVC,
      to: toVC
    ) {
      return transition
    }

    return nil
  }

}
