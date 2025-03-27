// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

/*
 Hidden in the Model we find optional closure property or callback closure 'onNewBPM', holding a function to be called if set.
 */

import Foundation
import Combine


/*
 Again an observable (view)model, but no storage.
 
 The challenge here is the asynchronous detection of heartbeats from a sensor. HeartbeatModel implements itself as a data receiver. Copying this data to an observed property is all we need to do.
 */

@Observable
class HeartbeatViewModel: SensorDataReceiver {
    var onNewReading: ((Int) -> Void)?
    var currentBPM: Int = -1    // is observed by UI, but onNewReading enables to update non-UI

    var isActive: Bool = false {
        didSet {
            if isActive { startMonitoring() } else { stopMonitoring() }
        }
    }

    private var sensor = ServiceLocator.shared.heartbeatSensor

    init() {
        sensor.sensorDataReceiver = self
    }
    
    func didReceiveSensorData(_ data: Int) {
        currentBPM = data
        onNewReading?(data)
    }

    private func startMonitoring() {
        sensor.startMonitoring()
    }

    private func stopMonitoring() {
        sensor.stopMonitoring()
        currentBPM = -1
    }
}

/*
 More on MVVM:
 - https://dev.to/vtsen/mvc-vs-mvp-vs-mvvm-design-patterns-443n?comments_sort=latest
 
 Model-View-ViewModel (MVVM)
 - Dependencies direction: View -> View Model -> Model
    View knows about View Model, View Model knows about Model, Model knows nothing.
    When there is a UI event, View informs the View Model about the UI event.
    View Model performs some logics and writes data to the Model
    View Model observes the data changes from Model and update its own data.
    View observes the data changes from View Model. If there are any changes, View is responsible to update the UI
 */

