// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flutter_lyra_ios",
    platforms: [
        .iOS("15.1")
    ],
    products: [
        .library(name: "flutter-lyra-ios", targets: ["flutter_lyra_ios"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/lyra/ios-sdk.git", .upToNextMinor(from: "4.0.5")),
    ],
    targets: [
        .target(
            name: "flutter_lyra_ios",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "LyraPaymentSDK", package: "ios-sdk"),
            ]
        )
    ]
)
