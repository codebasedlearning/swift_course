// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

/*
 Here we see 'static' and 'private init' in action. Moreover, 'lazy' comes into play: “Sleep until you’re needed.” It only initializes once. And 'static' is lazy by design.
 */

import Foundation

class ServiceLocator {
    static let shared = ServiceLocator()

    private init() {}

    lazy var heartbeatSensor: HeartbeatSensor = HeartbeatSensor()
}

