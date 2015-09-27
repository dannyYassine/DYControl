# DYControl
# Customizable Segemented Control
Simply create an Array of Strings for your buttons, it will auto-generate the views accordingly.
Then set the delegate of DYControl to know which index was selected

![](https://raw.githubusercontent.com/dannyYassine/DYControl/master/DYControl1.gif)

        
        let buttonList: [String] = ["Button", "Button", "Button", "Button"]
        let control = DYControl(withButtons: buttonList, withFrame: CGRect(x: 10, y: 100, width: 320 - 20, height: 30))
        let control.controlDelegate = self
        self.view.addSubview(control)
        
        //MARK: DYControl Delegate
        
        func didPressedButton(button: UIButton, atIndex index: Int) {
        
                //  Have access to which index is selected
        
        }
        
# Create Different UI

![](https://raw.githubusercontent.com/dannyYassine/DYControl/master/DYRipple.gif)

# Customizable Properties

        control.withBounce              //  Allow the slider to bounce                  
        control.panningAllowed          //  Allow to pan the slider
        control.speed                   //  Speed of the slider
        control.buttonTintColor         //  The textColor of the non-selected state
        control.buttonSelectedTintColor //  The textColor of the selected state
        control.buttonFont              //  Font of the text
        control.backgroundColor         //  Color of the main background
        control.borderColor             //  Border Color of main view
        control.borderWidth             //  Border with of main view
        control.buffer                  //  Padding around the slider
        control.cornerRadius            //  Add corner radius to both slider and main view
        control.selectedIndexButton     //  Get the selected index
                                        //  Set the initial selected index
        
        // Delegate
        control.controlDelegate         //  Set the delegate to know which index was selected
        
