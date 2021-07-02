//
//  PopupViewController.swift
//  Pomo
//
//  Created by Javier on 2021-07-02.
//

import Cocoa

class PopupViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func freshController() -> PopupViewController {
        let storyboard = NSStoryboard.main!
        let identifier = NSStoryboard.SceneIdentifier("PopupViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? PopupViewController else {
            fatalError("Unable to find PopupViewController - Check Main.storyboard")
        }
        return viewcontroller
    }
    
}
