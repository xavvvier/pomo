//
//  SliderMenuItem.swift
//  Pomo
//
//  Created by Javier on 2021-07-12.
//

import Cocoa

class SliderMenuItem: NSView {
    
    var onClicked: (()->())?
    var isPlayIcon = true
    
    @IBOutlet var button: NSButton!
    @IBOutlet var slider: SliderView!
    @IBAction func middleButtonClick(_ sender: Any) {
        onClicked?()
    }
    
    func toggleIcon() {
        if isPlayIcon {
            button.image = NSImage(systemSymbolName: "pause.fill", accessibilityDescription: "Pause")
        } else {
            button.image = NSImage(systemSymbolName: "play", accessibilityDescription: "Play")
        }
        isPlayIcon = !isPlayIcon
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    private func sharedInit() {
        Bundle.main.loadNibNamed("SliderView", owner: self, topLevelObjects: nil)
        addSubview(slider)
        slider.frame = self.bounds
    }
    
}
