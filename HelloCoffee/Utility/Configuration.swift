//
//  Configuration.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import Foundation

enum AppEnvironment: String {
    case dev
    case test
}

extension AppEnvironment {
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://island-bramble.glitch.me")!
        case .test:
            return URL(string: "https://island-bramble.glitch.me")!
        }
    }
}

struct Configuration {
    lazy var environment: AppEnvironment = {
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return AppEnvironment.dev
        }
        if env == "TEST" {
            return AppEnvironment.test
        } else {
            return AppEnvironment.dev
        }
    }()
}
