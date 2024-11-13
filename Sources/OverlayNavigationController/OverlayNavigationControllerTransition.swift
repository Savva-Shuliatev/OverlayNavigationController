//
//  OverlayNavigationControllerTransition.swift
//  OverlayNavigationController
//
//  Copyright (c) 2024 Savva Shuliatev
//  This code is covered by the MIT License.
//

import UIKit

@MainActor
open class OverlayNavigationControllerTransition {

  public init() {}

  open func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation: UINavigationController.Operation,
    from fromVC: UIViewController,
    to toVC: UIViewController
  ) -> (any UIViewControllerAnimatedTransitioning)? {
    switch operation {

    case .push:
      if fromVC is OverlayViewController || toVC is OverlayViewController {
        return OverlayNavigationControllerPushAnimation()
      } else {
        return nil
      }

    case .pop:
      if fromVC is OverlayViewController || toVC is OverlayViewController {
        return OverlayNavigationControllerPopAnimation()
      } else {
        return nil
      }

    case .none:
      return nil

    @unknown default:
      return nil
    }

  }


}

public class OverlayNavigationControllerPushAnimation: NSObject, UIViewControllerAnimatedTransitioning {

  public override init() {
    super.init()
  }

  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.35
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard
      let fromViewController = transitionContext.viewController(forKey: .from),
      let toViewController = transitionContext.viewController(forKey: .to)
    else { return }

    if let fromViewController = fromViewController as? OverlayViewController, let toViewController = toViewController as? OverlayViewController {
      transition(
        fromOverlayViewController: fromViewController,
        toOverlayViewController: toViewController,
        using: transitionContext
      )

    } else if let fromViewController = fromViewController as? OverlayViewController {
      transition(
        fromOverlayViewController: fromViewController,
        toViewController: toViewController,
        using: transitionContext
      )

    } else if let toViewController = toViewController as? OverlayViewController {
      transition(
        fromViewController: fromViewController,
        toOverlayViewController: toViewController,
        using: transitionContext
      )
    }
  }

  private func transition(
    fromOverlayViewController: OverlayViewController,
    toOverlayViewController: OverlayViewController,
    using transitionContext: UIViewControllerContextTransitioning
  ) {
    let containerView = transitionContext.containerView
    let duration = transitionDuration(using: transitionContext)

    containerView.addSubview(toOverlayViewController.view)

    fromOverlayViewController.hideContent(duration: duration)

    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      transitionContext.completeTransition(true)
    }
  }

  private func transition(
    fromOverlayViewController: OverlayViewController,
    toViewController: UIViewController,
    using transitionContext: UIViewControllerContextTransitioning
  ) {
    let containerView = transitionContext.containerView
    let duration = transitionDuration(using: transitionContext)

    containerView.addSubview(toViewController.view)

    fromOverlayViewController.hideContent(duration: duration)

    toViewController.view.transform = CGAffineTransform(
      translationX: containerView.frame.width,
      y: 0
    )

    UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
      toViewController.view.transform = .identity
    } completion: { _ in
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }

  private func transition(
    fromViewController: UIViewController,
    toOverlayViewController: OverlayViewController,
    using transitionContext: UIViewControllerContextTransitioning
  ) {
    let containerView = transitionContext.containerView
    let duration = transitionDuration(using: transitionContext)

    containerView.insertSubview(toOverlayViewController.view, belowSubview: fromViewController.view)

    UIView.animate(withDuration: duration) {
      fromViewController.view.transform = CGAffineTransform(translationX: -containerView.frame.width, y: 0)
    } completion: { _ in
      fromViewController.view.transform = .identity
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }

}

public class OverlayNavigationControllerPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {

  public override init() {
    super.init()
  }

  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.35
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard
      let fromViewController = transitionContext.viewController(forKey: .from),
      let toViewController = transitionContext.viewController(forKey: .to)
    else { return }

    if let fromViewController = fromViewController as? OverlayViewController, let toViewController = toViewController as? OverlayViewController {
      transition(
        fromOverlayViewController: fromViewController,
        toOverlayViewController: toViewController,
        using: transitionContext
      )

    } else if let fromViewController = fromViewController as? OverlayViewController {
      transition(
        fromOverlayViewController: fromViewController,
        toViewController: toViewController,
        using: transitionContext
      )

    } else if let toViewController = toViewController as? OverlayViewController {
      transition(
        fromViewController: fromViewController,
        toOverlayViewController: toViewController,
        using: transitionContext
      )
    }
  }

  private func transition(
    fromOverlayViewController: OverlayViewController,
    toOverlayViewController: OverlayViewController,
    using transitionContext: UIViewControllerContextTransitioning
  ) {
    let containerView = transitionContext.containerView
    containerView.insertSubview(toOverlayViewController.view, belowSubview: fromOverlayViewController.view)
    let duration = transitionDuration(using: transitionContext)

    fromOverlayViewController.hideContent(duration: duration)
    toOverlayViewController.showContent(duration: duration)

    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      transitionContext.completeTransition(true)
    }
  }

  private func transition(
    fromOverlayViewController: OverlayViewController,
    toViewController: UIViewController,
    using transitionContext: UIViewControllerContextTransitioning
  ) {
    let containerView = transitionContext.containerView
    let duration = transitionDuration(using: transitionContext)

    containerView.addSubview(toViewController.view)

    fromOverlayViewController.hideContent(duration: duration)

    toViewController.view.transform = CGAffineTransform(
      translationX: -containerView.frame.width,
      y: 0
    )

    UIView.animate(withDuration: duration) {
      toViewController.view.transform = .identity
    } completion: { _ in
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }

  private func transition(
    fromViewController: UIViewController,
    toOverlayViewController: OverlayViewController,
    using transitionContext: UIViewControllerContextTransitioning
  ) {
    let containerView = transitionContext.containerView
    let duration = transitionDuration(using: transitionContext)

    containerView.insertSubview(toOverlayViewController.view, belowSubview: fromViewController.view)

    toOverlayViewController.showContent(duration: duration)

    UIView.animate(withDuration: duration) {
      fromViewController.view.transform = CGAffineTransform(
        translationX: containerView.frame.width,
        y: 0
      )
    } completion: { _ in
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }

}
