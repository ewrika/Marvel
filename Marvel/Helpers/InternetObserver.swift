//
//  InternetObserber.swift
//  Marvel
//
//  Created by Георгий Борисов on 01.12.2024.
//

import Foundation
import Network

class InternetObserver {
    static let shared = InternetObserver()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    var isConnected:Bool = true
    
    private init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    
}
