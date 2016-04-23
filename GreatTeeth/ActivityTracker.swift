//
//  ActivityTracker.swift
//  GreatTeeth
//
//  Created by Aleksander Skjoelsvik on 4/22/16.
//  Copyright © 2016 Aleksander Skjoelsvik. All rights reserved.
//

import Foundation

enum ActivityType: Int {
    case Brushing = 1, Flossing, Rinsing
}

class ActivityTracker: NSObject {
    
    // MARK: Properties
    
    let activityDurations = [ActivityType.Brushing: 5, ActivityType.Flossing: 10, ActivityType.Rinsing: 10]
    let activityRepetitions = [ActivityType.Brushing: 4, ActivityType.Flossing: 1, ActivityType.Rinsing: 1]
    
    var currentActivity: ActivityType = .Brushing
    var currentTime = 0
    var currentRepetition = 0
    var timer = NSTimer()
    var loopCallback: ((Int, Float, ActivityType, Int, Bool) -> Void)?
    
    // MARK: Initialization
    
    static let sharedInstance = ActivityTracker()
    private override init() {
        super.init()
        
    }
    
    func setup() {
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ActivityTracker.timerloop), userInfo: nil, repeats: true)
    }
    
    func timerloop() {
        currentTime += 1
        
        if let callback = loopCallback {
            let remainingTime = activityDurations[currentActivity]! - currentTime
            let remainingRepetitions = activityRepetitions[currentActivity]! - currentRepetition
            callback(remainingTime, Float(remainingTime) / Float(activityDurations[currentActivity]!), currentActivity, remainingRepetitions, remainingRepetitions == 0)
        }
        
        if currentTime == activityDurations[currentActivity] {
            if currentRepetition >= activityRepetitions[currentActivity] {
                timer.invalidate()
                loopCallback = nil
            }
            
            currentRepetition += 1
            currentTime = 0
        }
    }
    
    func startActivityForType(type: ActivityType, andCallback callback: (Int, Float, ActivityType, Int, Bool) -> Void) {
        currentTime = 0
        currentRepetition = 1
        currentActivity = type
        loopCallback = callback
        
        setup()
    }
    
    func pauseTimer() {
        timer.invalidate()
    }
    
    func resumeTimer() {
        setup()
    }
    
    func isPaused() -> Bool {
        return !timer.valid
    }
}
