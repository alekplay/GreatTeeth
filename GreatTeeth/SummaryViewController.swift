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
        
        let sessionsThisWeek = UserDefaults.standard.integer(forKey: "sessionsThisWeek")
        let sessionsTotal = UserDefaults.standard.integer(forKey: "sessionsTotal")
        let timeTotal = UserDefaults.standard.integer(forKey: "timeTotal")
        
        sessionsThisWeekLabel?.text = String(sessionsThisWeek)
        sessionsTotalLabel?.text = String(sessionsTotal)
        timeTotalLabel?.text = String(timeTotal) + " minutes"
        
        if sessionsTotal == 1 {
            achievementNameLabel?.text = "First recorded session"
        } else if sessionsThisWeek == 14 {
            achievementNameLabel?.text = "Twice a day for a week"
        } else if sessionsThisWeek == 14 && sessionsTotal == 28 {
            achievementNameLabel?.text = "Twice a day for two weeks"
        } else if sessionsThisWeek == 14 && sessionsTotal == 56 {
            achievementNameLabel?.text = "Twice a day for a month"
        } else {
            statusLabel?.text = "TIP"
            achievementNameLabel?.text = "Replace brush every three months"
        }
    }
    
    @IBAction func closeButtonDidPress() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonDidPress() {
        let activityViewController = UIActivityViewController(activityItems: [achievementNameLabel!.text!], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
}
