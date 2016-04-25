//
//  SettingsTableViewController.swift
//  GreatTeeth
//
//  Created by Sharar Arzuk Rahman on 4/21/16.
//  Copyright © 2016 Aleksander Skjoelsvik. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.textLabel!.textColor = UIColor.whiteColor() //make the text white
        header.alpha = 0.8 //make the header transparent
    }
    override func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a
        footer.textLabel!.textColor = UIColor.whiteColor() //make the text white
        footer.textLabel!.textAlignment = .Center
        footer.alpha = 0.8 //make the header transparent
    }

    
    @IBAction func replaceBrushHead(sender: UIButton) {
        
        let alertController = UIAlertController(title: "Confirm", message: "", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action:UIAlertAction!) in
            
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Day , .Month , .Year], fromDate: date)
            let year =  components.year
            let month = components.month
            let day = components.day
            self.replacementDate.text=String(month) + "/" + String(day) + "/" + String(year)
            NSUserDefaults.standardUserDefaults().setObject(self.replacementDate.text, forKey: "lastReplaced")
            NSUserDefaults.standardUserDefaults().setObject(date, forKey: "dateLastReplaced")
            
            let daysToAdd = 7 * NSUserDefaults.standardUserDefaults().integerForKey("selectedValue")
            let futureDate = NSCalendar.currentCalendar().dateByAddingUnit(
                .Day,
                value: daysToAdd,
                toDate: date,
                options: NSCalendarOptions(rawValue: 0))
            
            let calendart = NSCalendar.currentCalendar()
            let componentst = calendart.components([.Day , .Month , .Year], fromDate: futureDate!)
            let yeart =  componentst.year
            let montht = componentst.month
            let dayt = componentst.day
            if daysToAdd == 182 {
                self.toBeReplaced.text="-"
            } else if daysToAdd < 182 {
            self.toBeReplaced.text=String(montht) + "/" + String(dayt) + "/" + String(yeart)
            }

        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)
        
    }
    
    
    @IBOutlet var replacementDate: UILabel!
    
    @IBOutlet var toBeReplaced: UILabel!
    
    override func viewWillAppear(animated: Bool) {
       super.viewWillAppear(animated)
        
        
        if let replacedDate = NSUserDefaults.standardUserDefaults().stringForKey("lastReplaced") {
            replacementDate.text = replacedDate
            
            if let retrievedComponents = NSUserDefaults.standardUserDefaults().objectForKey("dateLastReplaced") {
                let daysToAdd = 7 * NSUserDefaults.standardUserDefaults().integerForKey("selectedValue")
                let futureDate = NSCalendar.currentCalendar().dateByAddingUnit(
                    .Day,
                    value: daysToAdd,
                    toDate: retrievedComponents as! NSDate,
                    options: NSCalendarOptions(rawValue: 0))
                
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components([.Day , .Month , .Year], fromDate: futureDate!)
                let year =  components.year
                let month = components.month
                let day = components.day

                if daysToAdd == 182 {
                    toBeReplaced.text="-"
                } else if daysToAdd < 182 {
                    toBeReplaced.text=String(month) + "/" + String(day) + "/" + String(year)
                    self.scheduleLocal(futureDate!)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func doneButtonDidPress() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scheduleLocal(date:NSDate) {
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        
        if settings!.types == .None {
            let ac = UIAlertController(title: "Can't schedule", message: "Either we don't have permission to schedule notifications, or we haven't asked yet.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
            return
        }
        
        let notification = UILocalNotification()
        notification.fireDate = date
        notification.alertBody = "Hey, it's time to replace your brushhead"
        notification.alertAction = "slide to view"
        notification.soundName = UILocalNotificationDefaultSoundName
    
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    

}
