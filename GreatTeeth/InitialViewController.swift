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
    @IBOutlet weak var circularProgressView: KDCircularProgress?
    
    // MARK: Initialization
    
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
        
        // Reset angle of progress view
        circularProgressView?.angle = 0
    }
    
    func prepareInterfaceForActivityType(_ type: ActivityType) {
        switch type {
        case .brushing:
            directionsLabel?.isHidden = false
            progressBarImageView?.image = UIImage(named: "Progress Bar 2")
            skipButton?.setTitle("Skip Section", for: UIControlState())
            break
        case .flossing:
            directionsLabel?.isHidden = false
            progressBarImageView?.image = UIImage(named: "Progress Bar 3")
            skipButton?.setTitle("Skip Activity", for: UIControlState())
            break
        case .rinsing:
            directionsLabel?.isHidden = false
            progressBarImageView?.image = UIImage(named: "Progress Bar 4")
            skipButton?.setTitle("Finish", for: UIControlState())
            break
        }
        
    }
    
    
    func setUpAsInitial() {
        directionsLabel?.isHidden = true
        progressBarImageView?.image = UIImage(named: "Progress Bar 1")
        timerLabel?.text = "0"
        startButton?.isHidden = false
        pauseButton?.isHidden = true
        skipButton?.isHidden = true
        settingsButton.isEnabled = true
        settingsButton.tintColor = UIColor.white
        tipsButton.isEnabled = true
        tipsButton.tintColor = UIColor.white
        circularProgressView?.animate(toAngle: 0.0, duration: 0.5, completion: nil)
    }
    
    // MARK: Lifecycle
    
    func updateViewForTime(_ time: Int, percentage: Float, type: ActivityType, remainingRepetitions: Int, finished: Bool) {
        timerLabel!.text = String(time)
        
        circularProgressView?.animate(toAngle: (Double(360.0*(1-percentage))), duration: 0.5, completion: nil)
        
        if (finished==true) && (time == 0) {
            if let newActivityType = ActivityType(rawValue: type.rawValue + 1) {
                prepareInterfaceForActivityType(newActivityType)
                ActivityTracker.sharedInstance.startActivityForType(newActivityType, andCallback: updateViewForTime)
            } else {
                var sessionsThisWeek = UserDefaults.standard.integer(forKey: "sessionsThisWeek")
                var sessionsTotal = UserDefaults.standard.integer(forKey: "sessionsTotal")
                var timeTotal = UserDefaults.standard.integer(forKey: "timeTotal")
                
                sessionsTotal += 1
                sessionsThisWeek += 1
                timeTotal += 3
                
                UserDefaults.standard.set(sessionsThisWeek, forKey: "sessionsThisWeek")
                UserDefaults.standard.set(sessionsTotal, forKey: "sessionsTotal")
                UserDefaults.standard.set(timeTotal, forKey: "timeTotal")
                
                
                performSegue(withIdentifier: "PresentSummaryVC", sender: self)
                setUpAsInitial()
            }
        } else if type == .brushing {
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
            } else if type == .flossing {
                directionsLabel?.text = "Floss!"
            } else if type == .rinsing {
                directionsLabel?.text = "Rinse!"
                
            
        }
    }
    
    // MARK: Actions
    
    @IBAction func startBrushingButtonDidPress() {
        settingsButton.isEnabled = false
        settingsButton.tintColor = UIColor.clear
        tipsButton.isEnabled = false
        tipsButton.tintColor = UIColor.clear
        pauseButton?.isHidden = false
        skipButton?.isHidden = false
        startButton?.isHidden = true
        
        prepareInterfaceForActivityType(ActivityType.brushing)
        ActivityTracker.sharedInstance.startActivityForType(ActivityType.brushing, andCallback: updateViewForTime)
    }
    
    @IBAction func pauseButtonDidPress() {
        if !ActivityTracker.sharedInstance.isPaused() {
            ActivityTracker.sharedInstance.pauseTimer()
            pauseButton?.setTitle("Resume", for: UIControlState())
        } else {
            ActivityTracker.sharedInstance.resumeTimer()
            pauseButton?.setTitle("Pause Timer", for: UIControlState())
        }
    }
    
    @IBAction func skipButtonDidPress() {
        ActivityTracker.sharedInstance.skipToNext()
    }
}
