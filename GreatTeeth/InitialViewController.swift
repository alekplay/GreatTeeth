//
//  InitialViewController.swift
//  GreatTeeth
//
//  Created by Aleksander Skjoelsvik on 4/21/16.
//  Copyright © 2016 Aleksander Skjoelsvik. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: Outlets
    
    @IBOutlet weak var timerLabel: UILabel?
    @IBOutlet weak var directionsLabel: UILabel?
    @IBOutlet weak var pauseButton: UIButton?
    @IBOutlet weak var skipButton: UIButton?
    @IBOutlet weak var startButton: UIButton?
    @IBOutlet weak var progressBarImageView: UIImageView?
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var tipsButton: UIBarButtonItem!
    
    // MARK: Initialization
    
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
    
    func prepareInterfaceForActivityType(type: ActivityType) {
        switch type {
        case .Brushing:
            directionsLabel?.hidden = false
            progressBarImageView?.image = UIImage(named: "Progress Bar 2")
            skipButton?.setTitle("Skip Section", forState: .Normal)
            break
        case .Flossing:
            directionsLabel?.hidden = true
            progressBarImageView?.image = UIImage(named: "Progress Bar 3")
            skipButton?.setTitle("Skip Activity", forState: .Normal)
            break
        case .Rinsing:
            directionsLabel?.hidden = true
            progressBarImageView?.image = UIImage(named: "Progress Bar 4")
            skipButton?.setTitle("Finish", forState: .Normal)
            break
        }
    }
    
    func setUpAsInitial() {
        directionsLabel?.hidden = true
        progressBarImageView?.image = UIImage(named: "Progress Bar 1")
        timerLabel?.text = "00"
        startButton?.hidden = false
        pauseButton?.hidden = true
        skipButton?.hidden = true
        navigationItem.setRightBarButtonItem(settingsButton, animated: true)
        navigationItem.setRightBarButtonItem(tipsButton, animated: true)
    }
    
    // MARK: Lifecycle
    
    func updateViewForTime(time: Int, percentage: Float, type: ActivityType, remainingRepetitions: Int, finished: Bool) {
        timerLabel!.text = String(time)
        // update activity indicator
        
        if finished && time == 0 {
            if let newActivityType = ActivityType(rawValue: type.rawValue + 1) {
                prepareInterfaceForActivityType(newActivityType)
                ActivityTracker.sharedInstance.startActivityForType(newActivityType, andCallback: updateViewForTime)
            } else {
                var sessionsThisWeek = NSUserDefaults.standardUserDefaults().integerForKey("sessionsThisWeek")
                var sessionsTotal = NSUserDefaults.standardUserDefaults().integerForKey("sessionsTotal")
                var timeTotal = NSUserDefaults.standardUserDefaults().integerForKey("timeTotal")
                
                sessionsTotal += 1
                sessionsThisWeek += 1
                timeTotal += 3
                
                NSUserDefaults.standardUserDefaults().setInteger(sessionsThisWeek, forKey: "sessionsThisWeek")
                NSUserDefaults.standardUserDefaults().setInteger(sessionsTotal, forKey: "sessionsTotal")
                NSUserDefaults.standardUserDefaults().setInteger(timeTotal, forKey: "timeTotal")
                
                
                performSegueWithIdentifier("PresentSummaryVC", sender: self)
                setUpAsInitial()
            }
        } else if type == .Brushing {
            switch remainingRepetitions {
            case 0:
                directionsLabel?.text = "Lower Right Section"
                break
            case 1:
                directionsLabel?.text = "Lower Left Section"
                break
            case 2:
                directionsLabel?.text = "Upper Right Section"
                break
            case 3:
                directionsLabel?.text = "Upper Left Section"
                break
            default:
                directionsLabel?.text = ""
                break
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func startBrushingButtonDidPress() {
        navigationItem.setRightBarButtonItems(nil, animated: true)
        navigationItem.setLeftBarButtonItems(nil, animated: true)
        pauseButton?.hidden = false
        skipButton?.hidden = false
        startButton?.hidden = true
        
        prepareInterfaceForActivityType(ActivityType.Brushing)
        ActivityTracker.sharedInstance.startActivityForType(ActivityType.Brushing, andCallback: updateViewForTime)
    }
    
    @IBAction func pauseButtonDidPress() {
        if !ActivityTracker.sharedInstance.isPaused() {
            ActivityTracker.sharedInstance.pauseTimer()
            pauseButton?.setTitle("Resume", forState: .Normal)
        } else {
            ActivityTracker.sharedInstance.resumeTimer()
            pauseButton?.setTitle("Pause Timer", forState: .Normal)
        }
    }
    
    @IBAction func skipButtonDidPress() {
        ActivityTracker.sharedInstance.skipToNext()
    }
}
