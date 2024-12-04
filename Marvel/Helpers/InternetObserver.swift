//
//  InternetObserber.swift
//  Marvel
//
//  Created by Георгий Борисов on 01.12.2024.
//

import Foundation
import Network

final class InternetObserver {
    static let shared = InternetObserver()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)

    private(set) var isConnected: Bool = false

    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected = true
                print("Internet connection is available.")
            } else {
                self.isConnected = false
                print("Internet connection is not available.")
            }
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }

}
