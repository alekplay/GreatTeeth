//
//  SettingsTableViewController.swift
//  GreatTeeth
//
//  Created by Sharar Arzuk Rahman on 4/21/16.
//  Copyright © 2016 Aleksander Skjoelsvik. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.textLabel!.textColor = UIColor.white //make the text white
        header.alpha = 0.8 //make the header transparent
    }
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a
        footer.textLabel!.textColor = UIColor.white //make the text white
        footer.textLabel!.textAlignment = .center
        footer.alpha = 0.8 //make the header transparent
    }

    
    @IBAction func replaceBrushHead(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Confirm", message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            let date = Date()
            let calendar = Calendar.current
            let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
            let year =  components.year
            let month = components.month
            let day = components.day
            self.replacementDate.text=String(describing: month) + "/" + String(describing: day) + "/" + String(describing: year)
            UserDefaults.standard.set(self.replacementDate.text, forKey: "lastReplaced")
            UserDefaults.standard.set(date, forKey: "dateLastReplaced")
            
            let daysToAdd = 7 * UserDefaults.standard.integer(forKey: "selectedValue")
            let futureDate = (Calendar.current as NSCalendar).date(
                byAdding: .day,
                value: daysToAdd,
                to: date,
                options: NSCalendar.Options(rawValue: 0))
            
            let calendart = Calendar.current
            let componentst = (calendart as NSCalendar).components([.day , .month , .year], from: futureDate!)
            let yeart =  componentst.year
            let montht = componentst.month
            let dayt = componentst.day
            if daysToAdd == 182 {
                self.toBeReplaced.text="-"
            } else if daysToAdd < 182 {
            self.toBeReplaced.text=String(describing: montht) + "/" + String(describing: dayt) + "/" + String(describing: yeart)
            }

        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
        
    }
    
    
    @IBOutlet var replacementDate: UILabel!
    
    @IBOutlet var toBeReplaced: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        
        
        if let replacedDate = UserDefaults.standard.string(forKey: "lastReplaced") {
            replacementDate.text = replacedDate
            
            if let retrievedComponents = UserDefaults.standard.object(forKey: "dateLastReplaced") {
                let daysToAdd = 7 * UserDefaults.standard.integer(forKey: "selectedValue")
                let futureDate = (Calendar.current as NSCalendar).date(
                    byAdding: .day,
                    value: daysToAdd,
                    to: retrievedComponents as! Date,
                    options: NSCalendar.Options(rawValue: 0))
                
                let calendar = Calendar.current
                let components = (calendar as NSCalendar).components([.day , .month , .year], from: futureDate!)
                let year =  components.year
                let month = components.month
                let day = components.day

                if daysToAdd == 182 {
                    toBeReplaced.text="-"
                } else if daysToAdd < 182 {
                    toBeReplaced.text=String(describing: month) + "/" + String(describing: day) + "/" + String(describing: year)
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
        let color1 = UIColor(red:45/255.0, green:179/255.0, blue:183/255.0, alpha:1.0).cgColor as CGColor
        let color2 = UIColor(red:32/255.0, green:107/255.0, blue:133/255.0, alpha:1.0).cgColor as CGColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Remove navigation bar border
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func doneButtonDidPress() {
        dismiss(animated: true, completion: nil)
    }
    
    func scheduleLocal(_ date:Date) {
        let settings = UIApplication.shared.currentUserNotificationSettings
        
        if settings!.types == UIUserNotificationType() {
            let ac = UIAlertController(title: "Can't schedule", message: "Either we don't have permission to schedule notifications, or we haven't asked yet.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
            return
        }
        
        let notification = UILocalNotification()
        notification.fireDate = date
        notification.alertBody = "Hey, it's time to replace your brushhead"
        notification.alertAction = "slide to view"
        notification.soundName = UILocalNotificationDefaultSoundName
    
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    

}
