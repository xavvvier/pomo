//
//  TimeoutHandler.swift
//  Pomo
//
//  Created by Javier on 2021-07-05.
//

import Foundation

/// Timeout wrapps a callback deferral that may be cancelled.
///
/// Usage:
/// Timeout(1.0) { println("1 second has passed.") }
///
class TimeoutHandler: NSObject {
    private var timer: Timer?
    public var callback: (() -> Void)?
    
    func start(_ delaySeconds: TimeInterval) {
        self.timer = Timer.scheduledTimer(
            timeInterval: TimeInterval(delaySeconds),
            target: self,
            selector: #selector(invoke),
            userInfo: nil,
            repeats: false
        )
    }

    @objc func invoke() {
        self.callback?()
        self.callback = nil
        self.timer = nil
    }

    func cancel() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
