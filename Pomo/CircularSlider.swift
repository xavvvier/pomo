//
//  CircularSlider.swift
//  Pomo
//
//  Created by Javier on 2021-07-06.
//

import Cocoa
import CoreFoundation
import CoreGraphics

@IBDesignable
final class CircularSlider: NSView {
    // MARK: - Properties
    
    @IBInspectable
    var startFocusMinute: Int = 0
    
    @IBInspectable
    var focusTime: Int = 25 {
        didSet {
            needsDisplay = true
        }
    }
    
    @IBInspectable
    var idleTime: Int = 5 {
        didSet {
            needsDisplay = true
        }
    }
    
    @IBInspectable
    var trackWidth: CGFloat = 20
    
    @IBInspectable
    var trackGap: CGFloat = 2
    
    @IBInspectable
    var activeSegmentColor: NSColor = .darkGray
    
    @IBInspectable
    var idleSegmentColor: NSColor = .white
    
    @IBInspectable
    var trackColor: NSColor = .black

    
    // MARK: - Private properties
    private var radius: CGFloat = 1
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let trackingArea = NSTrackingArea(rect: bounds, options: [ .activeAlways, .enabledDuringMouseDrag, .mouseEnteredAndExited], owner: self, userInfo: nil)
        addTrackingArea(trackingArea)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Actions
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        NSLog("mouse entered")
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        NSLog("mouse exited")
    }
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        let location = self.convert(event.locationInWindow, from: nil)
        
        NSLog("mouse dragged x: \(location.x) y: \(location.y)")
        if location.x > 40 {
            NSCursor.openHand.set()
        }
    }
    
    // MARK: - Drawing
    
    var focusStartAngle: CGFloat {
        return minuteToAngle(minute: startFocusMinute)
    }
    var focusEndAngle: CGFloat {
        return minuteToAngle(minute: startFocusMinute + focusTime)
    }
    
    var idleStartAngle: CGFloat {
        return focusEndAngle
    }
    
    var idleEndAngle: CGFloat {
        return minuteToAngle(minute: startFocusMinute + focusTime + idleTime)
    }
    
    private func minuteToAngle(minute: Int) -> CGFloat {
        return CGFloat(90 - minute * 6)
    }
    
    lazy var lineCapAngle: CGFloat = {
        let lineCapHeight = segmentWidth/2
        let radians = atan(lineCapHeight/radius)
        return ceil(radians * CGFloat(180 / Double.pi))
    }()
    
    var segmentWidth: CGFloat {
        return trackWidth - trackGap * 2
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.radius = min(rect.height/2, rect.width/2)
        
        /*
         Draw background
        */
        let path = NSBezierPath()
        let origin = CGPoint(x: rect.midX, y: rect.midY)
        path.appendArc(withCenter: origin, radius: radius - trackWidth, startAngle: 0, endAngle: 360)
        path.windingRule = NSBezierPath.WindingRule.evenOdd
        path.appendArc(withCenter: origin, radius: radius, startAngle: 0, endAngle: 360)
        trackColor.setFill()
        path.fill()
        
        /*
         Draw segments
         */
        // Focus segment
        let segmentPath = NSBezierPath()
        segmentPath.appendArc(withCenter: origin, radius: radius - trackWidth/2, startAngle: focusStartAngle - lineCapAngle, endAngle: focusEndAngle + lineCapAngle, clockwise: true)
        segmentPath.lineWidth = segmentWidth
        segmentPath.lineCapStyle = .round
        activeSegmentColor.setStroke()
        segmentPath.stroke()
        //Draw idle segment
        let idlePath = NSBezierPath()
        idlePath.appendArc(withCenter: origin, radius: radius - trackWidth/2, startAngle: idleStartAngle - lineCapAngle , endAngle: idleEndAngle + lineCapAngle, clockwise: true)
        idlePath.lineWidth = segmentWidth
        idlePath.lineCapStyle = .round
        idleSegmentColor.setStroke()
        idlePath.stroke()
    }
    
}
