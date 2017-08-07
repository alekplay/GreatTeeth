//
//  ActivityTracker.swift
//  GreatTeeth
//
//  Created by Aleksander Skjoelsvik on 4/22/16.
//  Copyright © 2016 Aleksander Skjoelsvik. All rights reserved.
//

import Foundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


enum ActivityType: Int {
    case brushing = 1, flossing, rinsing
}

class ActivityTracker: NSObject {
    
    // MARK: Properties
    
    let activityDurations = [ActivityType.brushing: 30, ActivityType.flossing: 60, ActivityType.rinsing: 30]
    let activityRepetitions = [ActivityType.brushing: 4, ActivityType.flossing: 1, ActivityType.rinsing: 1]
    
    var currentActivity: ActivityType = .brushing
    var currentTime = 0
    var currentRepetition = 0
    var timer = Timer()
    var loopCallback: ((Int, Float, ActivityType, Int, Bool) -> Void)?
    
    // MARK: Initialization
    
    static let sharedInstance = ActivityTracker()
    fileprivate override init() {
        super.init()
        
    }
    
    func setup() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ActivityTracker.timerloop), userInfo: nil, repeats: true)
    }
    
    func timerloop() {
        currentTime += 1
        
        if let callback = loopCallback {
            let remainingTime = activityDurations[currentActivity]! - currentTime
            let remainingRepetitions = activityRepetitions[currentActivity]! - currentRepetition
            callback(remainingTime, Float(remainingTime) / Float(activityDurations[currentActivity]!), currentActivity, remainingRepetitions, remainingRepetitions == 0)
        }
        
        if currentTime >= activityDurations[currentActivity] {
            if currentRepetition >= activityRepetitions[currentActivity] {
                timer.invalidate()
                loopCallback = nil
            }
            
            currentRepetition += 1
            currentTime = 0
        }
    }
    
    func startActivityForType(_ type: ActivityType, andCallback callback: @escaping (Int, Float, ActivityType, Int, Bool) -> Void) {
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
        return !timer.isValid
    }
    
    func skipToNext() {
        currentTime = activityDurations[currentActivity]! - 1
    }
}
