//
//  DYControl.swift
//  CarTap
//
//  Created by Danny Yassine on 2015-09-25.
//  Copyright © 2015 Danny Yassine. All rights reserved.
//

import UIKit



protocol DYControlDelegate {
    func didPressedButton(button: UIButton, atIndex index: Int)
}

@IBDesignable

class DYControl: UIView {

    var controlDelegate: DYControlDelegate?
    var buttonColor: UIColor = UIColor.clearColor()
    var panningAllowed: Bool = true
    var selectedButton: UIButton! {
        willSet {
            selectedButton.setTitleColor(buttonTintColor, forState: .Normal)
        }
        didSet {
            selectedButton.setTitleColor(buttonSelectedTintColor, forState: .Normal)
        }
    }
    var buttonTintColor: UIColor? {
        willSet {
                for controlButton in buttons {
                    controlButton.setTitleColor(newValue, forState: UIControlState.Normal)
            }
            selectedButton.setTitleColor(buttonSelectedTintColor, forState: .Normal)
        }
    }
    var buttonSelectedTintColor: UIColor? {
        willSet {
           selectedButton.setTitleColor(newValue, forState: .Normal)
        }
    }
    var buttonFont: UIFont? {
        get {
            if let font = buttons.first?.titleLabel?.font {
                return font
            } else {
                return nil
            }
        }
        set(newValue) {
            for controlButton in buttons {
                controlButton.titleLabel?.font = newValue
            }
        }
    }
    var borderColor: CGColorRef? {
        get {
            return self.layer.borderColor
        }
        set {
            self.layer.borderColor = newValue
        }
    }
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    var selectedIndexButton: Int = 0 {
        willSet {
            self.selectedButton = buttons[newValue]
            self.controlButtonPressed(self.selectedButton)
        }
    }
    
    var cornerRadius: CGFloat = 0 {
        willSet {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        
            self.backView.layer.cornerRadius = newValue * (self.backView.frame.height / self.frame.height)
            self.backView.layer.masksToBounds = true
        }
    }
    
    var withBounce: Bool = false
    var buffer: CGFloat = 0 {
        didSet {
            self.updateBackView()
        }
    }
    var speed: CGFloat = 0.2
    var buttons = [UIButton]()
    var backView: UIView!
    var ghostBackView: UIView!
    
    var panGesture: UIPanGestureRecognizer!
    
    init(withButtons buttons: [String], withFrame frame: CGRect) {

        super.init(frame: frame)

        self.backgroundColor = UIColor.blueColor()
        self.layer.masksToBounds = true
        let buttonWidth: CGFloat = frame.width/CGFloat(buttons.count)
        
        self.backView = UIView(frame: CGRect(x: self.buffer, y: self.buffer, width: buttonWidth - self.buffer * 2, height: frame.height - self.buffer * 2))
        self.backView.backgroundColor = UIColor.yellowColor()
        self.backView.layer.borderColor = UIColor.blackColor().CGColor
        self.backView.layer.borderWidth = 1.0
        self.addSubview(self.backView)
        
        for (index,element) in buttons.enumerate() {
            
            let buttonFrame = CGRect(x: CGFloat(index) * buttonWidth, y: 0, width: buttonWidth, height: frame.height)
            let controlButton = UIButton(frame: buttonFrame)
            controlButton.addTarget(self, action: "controlButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            controlButton.setTitle(element, forState: .Normal)
            controlButton.tag = index
            controlButton.backgroundColor = buttonColor
            controlButton.tintColor = buttonTintColor
            self.addSubview(controlButton)
            
            self.buttons.append(controlButton)
            
        }
        
        self.selectedButton = self.buttons[self.selectedIndexButton]
        self.buttonSelectedTintColor = UIColor.blackColor()
        self.buttonTintColor = UIColor.whiteColor()
        
        self.panGesture = UIPanGestureRecognizer(target: self, action: "panControl:")
        self.addGestureRecognizer(panGesture)
        
        self.insertGhostBackView()

    }
    
    func updateBackView() {
        self.backView.frame = CGRect(x: self.backView.frame.origin.x + self.buffer, y: self.buffer, width: self.backView.frame.width - self.buffer * 2, height: frame.height - self.buffer * 2)
    }
    
    //MARK: DYControlDelegates
    
    func controlButtonPressed(button: UIButton) {

        self.animateBackViewToButton(button)
        
        self.controlDelegate?.didPressedButton(button, atIndex: button.tag)
    }
    
    //MARK: Layout Style Refresh
    
    func styleButtons() {
        
    }
    
    //MARK: BackView Animations
    
    func animateBackViewToButton(button: UIButton) {
        
        var newFrame = self.backView.frame
        newFrame.origin.x = button.frame.origin.x + self.buffer

        self.selectedButton = button
        self.selectedButton.alpha = 0.0
        
        UIView.animateWithDuration(Double(self.speed), animations: { () -> Void in
            self.selectedButton.alpha = 1.0
            }) { (done) -> Void in
                self.ghostBackView.frame = self.selectedButton.frame
        }
        
        if withBounce {
            UIView.animateWithDuration(Double(self.speed), delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                
                self.backView.frame = newFrame
                
                }) { (done) -> Void in
                    
            }
        } else {
            UIView.animateWithDuration(Double(self.speed), animations: { () -> Void in
                
                self.backView.frame = newFrame

                }) { (done) -> Void in
                    
            }
        }
    }
    
    //MARK: Gestures
    
    func panControl(pan: UIPanGestureRecognizer) {
        if panningAllowed {

            self.adjustGhostBackView()
            
            let location = pan.locationInView(self)
            if CGRectContainsPoint(self.ghostBackView.frame, location) && location.x > self.frame.origin.x + self.ghostBackView.frame.width/3 && location.x < self.frame.origin.x + self.frame.width - self.ghostBackView.frame.width/2 {
                if pan.state == UIGestureRecognizerState.Began {
                    self.ghostBackView.alpha = 0.5
                    UIView.animateWithDuration(Double(self.speed), animations: { () -> Void in
                        self.ghostBackView.center.x = location.x
                        }, completion:nil)
                } else if pan.state == UIGestureRecognizerState.Changed {
                    self.ghostBackView.center.x = location.x
                } else {
                    
                }
            }
            
            if pan.state == UIGestureRecognizerState.Ended {
                self.goToClosetButton(location)
            }
        }
    }
    
    func insertGhostBackView() {
        if self.ghostBackView == nil {
            self.ghostBackView = UIView(frame: self.backView.frame)
            self.insertSubview(self.ghostBackView, belowSubview: self.backView)
        } else {
            self.ghostBackView.frame = self.backView.frame
        }
        self.ghostBackView.backgroundColor = self.backView.backgroundColor
        self.ghostBackView.alpha = 0.0
    }

    func adjustGhostBackView() {
        self.ghostBackView.backgroundColor = self.backView.backgroundColor
        self.ghostBackView.layer.borderColor = self.backView.layer.borderColor
        self.ghostBackView.layer.borderWidth = self.backView.layer.borderWidth
        self.ghostBackView.layer.cornerRadius = self.backView.layer.cornerRadius
        self.ghostBackView.layer.masksToBounds = true
    }
    
    func goToClosetButton(location: CGPoint) {
        
        UIView.animateWithDuration(Double(self.speed), animations: { () -> Void in
            self.ghostBackView.alpha = 0.0
            }) { (done) -> Void in
        }
        
        var moveToButton: UIButton!
        var smallestPoint: CGFloat = CGFloat.max
        
        for (_, element) in buttons.enumerate() {
            
            let point1 = self.ghostBackView.frame.origin.x - element.frame.origin.x
            
            print(point1, abs(point1))
            
            if abs(point1) <= smallestPoint {
                smallestPoint = point1
                moveToButton = element
            }
        }
        
        self.controlButtonPressed(moveToButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    
    
}
