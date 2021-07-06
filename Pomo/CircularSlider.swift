//
//  CircularSlider.swift
//  Pomo
//
//  Created by Javier on 2021-07-06.
//

import Cocoa
import CoreFoundation

@IBDesignable
final class CircularSlider: NSView {
    // MARK: - Properties
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer?.cornerRadius = newValue
        }
        get {
            return layer!.cornerRadius
        }
    }
    
    @IBInspectable
    var segments: [String] = ["One", "Two", "..."]
    
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
    private var segmentSize: CGFloat {
        return frame.width / CGFloat(segments.count)
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.wantsLayer = true
        self.layer?.cornerRadius = 3
        //configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //configure()
    }
    
//    private func configure() {
//        addGestureRecognizer(
//            NSTapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
//        )
//    }
//
    // MARK: - Actions

    @objc
    override func mouseUp(with event: NSEvent) {
        activeIndex = Int(event.locationInWindow.x / segmentSize)
    }

    
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //guard let context = NSGraphicsContext.current else { return }
        //guard let context = NSGraphicsGetCurrentContext() else { return }
        
        /*
         Draw background
        */
        segmentColor.setFill()
        //context.setFillColor(segmentColor.cgColor)
        let backgroundPath = NSBezierPath.init(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)
        backgroundPath.fill()
        
        /*
         Enumerate segments property and call drawing function for each item
         */
        segments.enumerated().forEach { index, title in
            let rect = CGRect(x: CGFloat(index) * segmentSize, y: 0, width: segmentSize, height: frame.height)
            
            if activeIndex == index {
                /*
                 Draw background for active index
                 */
                activeSegmentColor.setFill()
                //context.setFillColor(activeSegmentColor.cgColor)
                let path = NSBezierPath.init(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)
                path.fill()
                
                draw(text: title, in: rect, with: activeTextColor, and: activeFont)
            } else {
                draw(text: title, in: rect, with: textColor, and: font)
            }
        }
    }
    
    private func draw(text: String, in rect: CGRect, with color: NSColor, and font: NSFont) {
        /*
         Draw text with incomming parameters
         */
        var rect = rect
        let attributes: [NSAttributedString.Key: Any] = [.font: font,
                                                        .foregroundColor: color,
                                                        .paragraphStyle: paragraphStyle]
        let string = NSAttributedString(string: text, attributes: attributes)
        let size = string.size()
        rect.origin.y = (frame.height - size.height) / 2
        rect.size.height = size.height
        string.draw(in: rect)
    }
    
}
