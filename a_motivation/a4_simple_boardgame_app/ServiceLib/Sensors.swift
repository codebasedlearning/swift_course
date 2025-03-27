// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

/*
 Here we use a 'protocol', 'inheritance' and the special ?-optional-syntax.
 Moreover, we open the door for the async-stuff as in 'DispatchQueue.main.async'.
 */

import Foundation

protocol SensorProtocol {
    var sensorDataReceiver: SensorDataReceiver? { get set }
    func startMonitoring()
    func stopMonitoring()
}

protocol SensorDataReceiver {
    func didReceiveSensorData(_ data: Int)
}

/*
 We simulate a 1D hardware sensor that provides sensor data over time, with limited variation and in a specific range, i.e. the readings may flicker but do not jump.
 */

class SimulatedSensor: SensorProtocol {
    private(set) var lastSensorData: Int
    var sensorDataReceiver: SensorDataReceiver?

    private let minValue: Int
    private let maxValue: Int
    private let variation: Int
    private let timeInterval: Double
    private var timer: Timer?   // consider DispatchSourceTimer
    
    init(minValue: Int, maxValue: Int, startValue: Int, variation: Int = 1, timeInterval: Double = 1.0) {
        self.lastSensorData = startValue
        self.minValue = minValue
        self.maxValue = maxValue
        self.variation = variation
        self.timeInterval = timeInterval
    }

    func startMonitoring() {
        guard timer == nil else { return }

        self.sensorDataReceiver?.didReceiveSensorData(self.lastSensorData)
        timer = Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true) { [weak self] _ in
            guard let strongSelf = self else { return }
            let newValue = strongSelf.lastSensorData + Int.random(in: -strongSelf.variation...strongSelf.variation)
            strongSelf.lastSensorData = min(strongSelf.maxValue,max(strongSelf.minValue, newValue))
            // could be a problem if updating UI directly, hence use @MainActor or DispatchQueue.main.async
            // @MainActor forces all access to a function, property, or type to happen on the main thread — automatically and safely.
            DispatchQueue.main.async {
                strongSelf.sensorDataReceiver?.didReceiveSensorData(strongSelf.lastSensorData)
            }
        }
    }
    
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }
}

class HeartbeatSensor: SimulatedSensor {
    init() {
        super.init(minValue: 40, maxValue: 200, startValue: 60, variation: 2)
    }
}
