// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platinum",
    platforms: [
        .macOS(.v11),
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Platinum",
            targets: ["Platinum"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(
            name: "Platinum", 
            url: "https://github.com/OrzGeeker/Platinum/releases/download/0.0.1/Platinum.xcframework.zip", 
            checksum: "e90dd7c4251442ad6436afc81f4d575fccc8ad4a79ae940187d68737d8b86077"
        ),
    ]
)
