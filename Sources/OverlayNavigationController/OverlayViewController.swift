//
//  OverlayViewController.swift
//  OverlayNavigationController
//
//  Copyright (c) 2024 Savva Shuliatev
//  This code is covered by the MIT License.
//

import UIKit

@MainActor
public protocol OverlayViewController: UIViewController {
  func customPoint(inside point: CGPoint, with event: UIEvent?) -> Bool
}
