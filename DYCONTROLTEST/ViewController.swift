//
//  ViewController.swift
//  DYCONTROLTEST
//
//  Created by Danny Yassine on 2015-09-26.
//  Copyright © 2015 DannyYassine. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DYControlDelegate {

    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var indexLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let control = DYControl(withButtons: ["Button", "Button", "Button", "Button"], withFrame: CGRect(x: 10, y: 50, width: 320 - 20, height: 30))
        control.withBounce = true
        control.buttonTintColor = UIColor.redColor()
        control.buttonFont = UIFont(name: "AvenirNext-Bold", size: 12)
        control.backgroundColor = UIColor.lightGrayColor()
        control.borderColor = UIColor.whiteColor().CGColor
        control.backView.backgroundColor = UIColor.whiteColor()
        control.borderWidth = 1.0
        control.buffer = 2.0
        control.cornerRadius = control.frame.height/2
        control.controlDelegate = self
        control.panningAllowed = false
        self.view.addSubview(control)
        
        let control1 = DYControl(withButtons: ["Button", "Button", "Button", "Button"], withFrame: CGRect(x: 10, y: CGRectGetMaxY(control.frame) + 20, width: 320 - 20, height: 50))
        control1.buttonTintColor = UIColor.blackColor()
        control1.buttonFont = UIFont(name: "TimesNewRoman", size: 16)
        control1.backgroundColor = UIColor.clearColor()
        control1.cornerRadius = 5.0
        control1.backView.backgroundColor = UIColor.blackColor()
        control1.selectedIndexButton = 2
        control1.buttonSelectedTintColor = UIColor.whiteColor()
        control1.borderWidth = 3.0
        control1.controlDelegate = self
        self.view.addSubview(control1)
        
        let control2 = DYControl(withButtons: ["Button", "Button", "Button"], withFrame: CGRect(x: 10, y: CGRectGetMaxY(control1.frame) + 20, width: 320 - 20, height: 30))
        control2.speed = 0.0
        control2.withBounce = false
        control2.buffer = 5
        control2.controlDelegate = self
        self.view.addSubview(control2)
        
        let control3 = DYControl(withButtons: ["Button","Button"], withFrame: CGRect(x: 10, y: CGRectGetMaxY(control2.frame) + 20, width: 320 - 20, height: 80))
        control3.controlDelegate = self
        self.view.addSubview(control3)
        
        let control4 = DYControl(withButtons: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"], withFrame: CGRect(x: 10, y: CGRectGetMaxY(control3.frame) + 20, width: 320 - 20, height: 30))
        control4.withBounce = true
        control4.cornerRadius = control.frame.height/2
        control4.buffer = 1.0
        control4.borderWidth = 1.0
        control4.borderColor = UIColor.whiteColor().CGColor
        control4.backView.backgroundColor = UIColor.lightGrayColor()
        control4.backgroundColor = UIColor.darkGrayColor()
        control4.backView.layer.borderColor = control4.borderColor
        control4.buttonSelectedTintColor = UIColor.redColor()
        control4.buttonTintColor = UIColor.blackColor()
        control4.panningAllowed = true
        control4.speed = 0.25
        control4.controlDelegate = self
        self.view.addSubview(control4)

    }

    func didPressedButton(button: UIButton, atIndex index: Int) {
//        print(button, index)
        
        self.indexLabel.text = "Selected Index Pressed:"
        self.numberLabel.text = "\(index)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

