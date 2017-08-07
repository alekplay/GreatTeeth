//
//  timeTillReplacementViewController.swift
//  GreatTeeth
//
//  Created by Sharar Arzuk Rahman on 4/23/16.
//  Copyright © 2016 Aleksander Skjoelsvik. All rights reserved.
//

import UIKit

class timeTillReplacementViewController: UIViewController {

    @IBOutlet var timeTillReplacementLabel: UILabel!
    
    @IBOutlet var sliderValue: UISlider!
    @IBAction func valueChanged(_ sender: UISlider) {
        let selectedValue = Int(sender.value)
        if selectedValue < 26 && selectedValue != 1 {
            timeTillReplacementLabel.text = "Alert me in " + String(selectedValue) + " weeks"
        } else if selectedValue == 1 {
            timeTillReplacementLabel.text = "Alert me in a week"
        } else if selectedValue == 26 {
            timeTillReplacementLabel.text = "Never alert me"
        }
        UserDefaults.standard.set(selectedValue, forKey: "selectedValue")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let setValue =  UserDefaults.standard.integer(forKey: "selectedValue")
        sliderValue.value=Float(setValue)
        if setValue < 26 && setValue != 1 {
            timeTillReplacementLabel.text = "Alert me in " + String(setValue) + " weeks"
        } else if setValue == 1 {
            timeTillReplacementLabel.text = "Alert me in a week"
        } else if setValue == 26 {
            timeTillReplacementLabel.text = "Never alert me"
        }
        
        
        
        // Add background gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        let color1 = UIColor(red:45/255.0, green:179/255.0, blue:183/255.0, alpha:1.0).cgColor as CGColor
        let color2 = UIColor(red:32/255.0, green:107/255.0, blue:133/255.0, alpha:1.0).cgColor as CGColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        
        // Remove navigation bar border
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor=UIColor.white


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
