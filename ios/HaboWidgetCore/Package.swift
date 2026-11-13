// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "HaboWidgetCore",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "HaboWidgetCore", targets: ["HaboWidgetCore"]),
    ],
    targets: [
        .target(name: "HaboWidgetCore"),
        .testTarget(
            name: "HaboWidgetCoreTests",
            dependencies: ["HaboWidgetCore"],
            resources: [.copy("Fixtures")]
        ),
    ]
)
