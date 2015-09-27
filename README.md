# DYControl
# Customizable Segemented Control
Simply create an Array of Strings for your buttons, it will auto-generate the views accordingly.
        
        let buttonList: [String] = ["Button", "Button", "Button", "Button"]
        let control = DYControl(withButtons: buttonList, withFrame: CGRect(x: 10, y: 100, width: 320 - 20, height: 30))
        self.view.addSubview(control)

![](https://raw.githubusercontent.com/dannyYassine/DYControl/master/DYRipple.gif)

# Customizable Properties

        control.withBounce = true
        control.panningAllowed = false
        control.buttonTintColor = UIColor.redColor()
        control.buttonFont = UIFont(name: "AvenirNext-Bold", size: 12)
        control.backgroundColor = UIColor.lightGrayColor()
        control.borderColor = UIColor.whiteColor().CGColor
        control.borderWidth = 1.0
        control.buffer = 2.0
        control.cornerRadius = control.frame.height/2
        control.controlDelegate = self
