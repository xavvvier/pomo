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
    var trackWidth: CGFloat = 20
    
    @IBInspectable
    var segmentColor: NSColor = .lightGray
    
    @IBInspectable
    var activeSegmentColor: NSColor = .darkGray
    
    @IBInspectable
    var textColor: NSColor = .black
    
    @IBInspectable
    var activeTextColor: NSColor = .white
    
    @IBInspectable
    var font: NSFont = .systemFont(ofSize: 18.0, weight: .medium)
    
    @IBInspectable
    var activeFont: NSFont = .systemFont(ofSize: 18.0, weight: .medium)
    
    @IBInspectable
    var activeIndex: Int = 0 {
        didSet {
            //setNeedsDisplay()
            needsDisplay = true
        }
    }
    
    // MARK: - Private properties
    
    private lazy var paragraphStyle: NSParagraphStyle = {
        let paragraph = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraph.alignment = .center
        return paragraph.copy() as! NSParagraphStyle
    }()
    
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
        NSCursor.crosshair.set()
        //let location = event.locationInWindow
        //let location = event.locationInWindow
        let location = self.convert(event.locationInWindow, from: nil)
        
        NSLog("mouse dragged x: \(location.x) y: \(location.y)")
        if location.x > 40 {
            NSCursor.openHand.set()
        }
    }
    // MARK: - Drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //guard let context = NSGraphicsContext.current else { return }
        //guard let context = NSGraphicsGetCurrentContext() else { return }
        /*
         Draw background
        */
        let path = NSBezierPath()
        let origin = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.height/2, rect.width/2)
        path.appendArc(withCenter: origin, radius: radius - trackWidth, startAngle: 0, endAngle: 360)
        path.windingRule = NSBezierPath.WindingRule.evenOdd
        path.appendArc(withCenter: origin, radius: radius, startAngle: 0, endAngle: 360)
        path.fill()
        
//        if Date.init().timeIntervalSince1970 > 0 {
//            return
//        }
//        segmentColor.setFill()
//        //context.setFillColor(segmentColor.cgColor)
//        let backgroundPath = NSBezierPath.init(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)
//        backgroundPath.fill()
        
        
//        /*
//         Enumerate segments property and call drawing function for each item
//         */
//        segments.enumerated().forEach { index, title in
//            let rect = CGRect(x: CGFloat(index) * segmentSize, y: 0, width: segmentSize, height: frame.height)
//
//            if activeIndex == index {
//                /*
//                 Draw background for active index
//                 */
//                activeSegmentColor.setFill()
//                //context.setFillColor(activeSegmentColor.cgColor)
//                let path = NSBezierPath.init(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)
//                path.fill()
//
//                draw(text: title, in: rect, with: activeTextColor, and: activeFont)
//            } else {
//                draw(text: title, in: rect, with: textColor, and: font)
//            }
//        }
    }
    
//    private func draw(text: String, in rect: CGRect, with color: NSColor, and font: NSFont) {
//        /*
//         Draw text with incomming parameters
//         */
//        var rect = rect
//        let attributes: [NSAttributedString.Key: Any] = [.font: font,
//                                                        .foregroundColor: color,
//                                                        .paragraphStyle: paragraphStyle]
//        let string = NSAttributedString(string: text, attributes: attributes)
//        let size = string.size()
//        rect.origin.y = (frame.height - size.height) / 2
//        rect.size.height = size.height
//        string.draw(in: rect)
//    }
    
}
