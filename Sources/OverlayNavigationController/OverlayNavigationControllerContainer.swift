//
//  OverlayNavigationControllerContainer.swift
//  OverlayNavigationController
//
//  Copyright (c) 2024 Savva Shuliatev
//  This code is covered by the MIT License.
//

import UIKit

open class OverlayNavigationControllerContainer: UIView {

  open private(set) var navigationController: OverlayNavigationController

  public init(
    parentViewController: UIViewController,
    navigationController: OverlayNavigationController = OverlayNavigationController()
  ) {
    self.navigationController = navigationController
    super.init(frame: .zero)
    addNavigationController(on: parentViewController)
  }

  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    guard let lastViewController = navigationController.viewControllers.last else {
      return false
    }

    if let touchProvider = lastViewController as? OverlayViewController {
      return touchProvider.customPoint(inside: point, with: event)
    }

    return lastViewController.view.point(inside: point, with: event)
  }

  private func addNavigationController(on parentViewController: UIViewController) {
    parentViewController.addChild(navigationController)
    addSubview(navigationController.view)
    navigationController.didMove(toParent: parentViewController)

    navigationController.view.translatesAutoresizingMaskIntoConstraints = false
    navigationController.view.topAnchor.constraint(equalTo: topAnchor).isActive = true
    navigationController.view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    navigationController.view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    navigationController.view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }

}
