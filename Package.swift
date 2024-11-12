// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "OverlayNavigationController",
  platforms: [.iOS(.v12)],
  products: [
    .library(
      name: "OverlayNavigationController",
      targets: ["OverlayNavigationController"]
    ),
  ],
  targets: [
    .target(
      name: "OverlayNavigationController"),
    .testTarget(
      name: "OverlayNavigationControllerTests",
      dependencies: ["OverlayNavigationController"]
    ),
  ]
)
