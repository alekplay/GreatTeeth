//
//  setMorningViewController.swift
//  GreatTeeth
//
//  Created by Sharar Arzuk Rahman on 4/22/16.
//  Copyright © 2016 Aleksander Skjoelsvik. All rights reserved.
//

import UIKit

class setMorningViewController: UIViewController {

    
    @IBOutlet var morningAlertLabel: UILabel!
    @IBOutlet var morningAlert: UIDatePicker!
    @IBAction func changeMorningAlert(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let strDate = "You have selected " + dateFormatter.stringFromDate(morningAlert.date)
        self.morningAlertLabel.text = strDate
        NSUserDefaults.standardUserDefaults().setObject(morningAlert.date, forKey: "storedMorningAlert")
        NSUserDefaults.standardUserDefaults().setObject(dateFormatter.stringFromDate(morningAlert.date), forKey: "Morning Alert")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let morningTime = NSUserDefaults.standardUserDefaults().objectForKey("storedMorningAlert") {
            morningAlert.date = morningTime as! NSDate
        }
        
        if let morningAlertValue = NSUserDefaults.standardUserDefaults().stringForKey("Morning Alert") {
            self.morningAlertLabel.text = "You have selected " + morningAlertValue
        }
        
        // Add background gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        let color1 = UIColor(red:45/255.0, green:179/255.0, blue:183/255.0, alpha:1.0).CGColor as CGColorRef
        let color2 = UIColor(red:32/255.0, green:107/255.0, blue:133/255.0, alpha:1.0).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradientLayer, atIndex: 0)
        

        
        // Remove navigation bar border
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()

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
