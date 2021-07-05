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
    private var tickerTimer: Timer?
    private var remainingSeconds: Int32 = 0;
    public var timeoutCallback: (() -> Void)?
    public var tickerCallback:((_: String) -> Void)?
    
    func start(_ delaySeconds: TimeInterval) {
        self.timer = Timer.scheduledTimer(
            timeInterval: TimeInterval(delaySeconds),
            target: self,
            selector: #selector(invoke),
            userInfo: nil,
            repeats: false
        )
        self.tickerTimer = Timer.scheduledTimer(
            timeInterval: TimeInterval(1),
            target: self,
            selector: #selector(ticker),
            userInfo: nil,
            repeats: true
        )
        remainingSeconds = Int32(delaySeconds)
        ticker()
    }
    
    @objc func ticker() {
        remainingSeconds -= 1
        tickerCallback?(self.secondsToString(seconds: remainingSeconds))
    }

    @objc func invoke() {
        self.timeoutCallback?()
        self.timeoutCallback = nil
        self.tickerCallback = nil
        self.timer = nil
        self.tickerTimer?.invalidate()
        self.tickerTimer = nil
    }

    func cancel() {
        self.timer?.invalidate()
        self.tickerTimer?.invalidate()
        self.tickerTimer = nil
        self.timer = nil
    }
}

extension TimeoutHandler {
    func secondsToString(seconds: Int32) -> String {
        if seconds < 60 {
            return "\(seconds)s"
        } else {
            
            let minutesRemaining = Double(seconds)/60.0
            let minutes = round(minutesRemaining)
            return "\(Int(minutes))m"
        }

    }
}
