//
//  SummaryViewController.swift
//  GreatTeeth
//
//  Created by Aleksander Skjoelsvik on 4/23/16.
//  Copyright © 2016 Aleksander Skjoelsvik. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel?
    @IBOutlet weak var achievementNameLabel: UILabel?
    @IBOutlet weak var achievementImageView: UIImageView?
    @IBOutlet weak var shareButton: UIButton?
    @IBOutlet weak var sessionsThisWeekLabel: UILabel?
    @IBOutlet weak var sessionsTotalLabel: UILabel?
    @IBOutlet weak var timeTotalLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sessionsThisWeek = NSUserDefaults.standardUserDefaults().integerForKey("sessionsThisWeek")
        let sessionsTotal = NSUserDefaults.standardUserDefaults().integerForKey("sessionsTotal")
        let timeTotal = NSUserDefaults.standardUserDefaults().integerForKey("timeTotal")
        
        sessionsThisWeekLabel?.text = String(sessionsThisWeek)
        sessionsTotalLabel?.text = String(sessionsTotal)
        timeTotalLabel?.text = String(timeTotal)
        
        
    }
    
    @IBAction func closeButtonDidPress() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButtonDidPress() {
        let activityViewController = UIActivityViewController(activityItems: ["hello world"], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
}
