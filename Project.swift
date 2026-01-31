import ProjectDescription

let deploymentTargets: DeploymentTargets = .iOS("17.0")

let project = Project(
    name: "GudaoClock",
    organizationName: "Example",
    settings: .settings(
        base: [
            "DEVELOPMENT_TEAM": "<YOUR_DEVELOPMENT_TEAM_ID>",
            "CODE_SIGN_STYLE": "Automatic",
            "CODE_SIGN_IDENTITY": "Apple Development",
            "TARGETED_DEVICE_FAMILY": "1",
            "ENABLE_USER_SCRIPT_SANDBOXING": "NO"
        ],
        defaultSettings: .recommended
    ),
    targets: [
        .target(
            name: "GudaoClock",
            destinations: .iOS,
            product: .app,
            bundleId: "com.gudao.clock",
            deploymentTargets: deploymentTargets,
            infoPlist: .file(path: "GudaoClock/Info.plist"),
            sources: ["GudaoClock/**/*.swift"],
            resources: ["GudaoClock/Assets.xcassets"]
        )
    ]
)
