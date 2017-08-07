//
//  setEveningViewController.swift
//  GreatTeeth
//
//  Created by Sharar Arzuk Rahman on 4/22/16.
//  Copyright © 2016 Aleksander Skjoelsvik. All rights reserved.
//

import UIKit

class setEveningViewController: UIViewController {

    
    @IBOutlet var eveningAlertLabel: UILabel!
    @IBOutlet var eveningAlert: UIDatePicker!
    @IBAction func changeEveningAlert(_ sender: AnyObject) {
        let dateFormatterEvening = DateFormatter()
        dateFormatterEvening.dateFormat = "HH:mm"
        let strDateEvening = "You have selected " + dateFormatterEvening.string(from: eveningAlert.date)
        print(eveningAlert.date)
        self.eveningAlertLabel.text = strDateEvening
        UserDefaults.standard.set(eveningAlert.date, forKey: "storedEveningAlert")
        UserDefaults.standard.set(dateFormatterEvening.string(from: eveningAlert.date), forKey: "Evening Alert")
        let notification = UILocalNotification()
        notification.fireDate = eveningAlert.date
        notification.alertBody = "Hey, it's time to brush your teeth"
        notification.alertAction = "slide to view"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.repeatInterval = NSCalendar.Unit.day
        
        
        UIApplication.shared.scheduleLocalNotification(notification)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let eveningTime = UserDefaults.standard.object(forKey: "storedEveningAlert") {
            eveningAlert.date = eveningTime as! Date
        }
        if let eveningAlertValue = UserDefaults.standard.string(forKey: "Evening Alert") {
            self.eveningAlertLabel.text = "You have selected " + eveningAlertValue
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
