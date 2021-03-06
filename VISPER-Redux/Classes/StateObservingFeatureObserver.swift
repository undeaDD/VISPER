//
//  AppStateObservingFeatureObserver.swift
//  VISPER-Swift
//
//  Created by bartel on 23.04.18.
//

import Foundation
import VISPER_Reactive
import VISPER_Core

public class StateObservingFeatureObserver<ApplicationState,ObservedState>: StatefulFeatureObserver {
    
    public typealias AppState = ApplicationState
    
    var state: ObservableProperty<ObservedState>
    var observingFeatures = [StateObservingFeature<ObservedState>]()
    
    public init(state: ObservableProperty<ObservedState>) {
        self.state = state
    }
    
    public func featureAdded(application: AnyReduxApp<ApplicationState>, feature: Feature) throws {
        if let feature = feature as? StateObservingFeature<ObservedState> {
            try feature.observe(state: self.state)
            self.observingFeatures.append(feature)
        }
    }
}
