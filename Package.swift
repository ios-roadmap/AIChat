// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AIChat",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "AIChat",
            targets: ["AIChat"]
        ),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "AIChat",
            dependencies: [
                
            ],
            path: "AIChat"
        ),
    ]
)
