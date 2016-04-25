##Great Teeth
iOS Oral Health and Toothbrush Tracking Application made as final project for EC327 Spring Semester 2016.

The application guides you through a timed tooth brushing session, including flossing and rinsing. Notifications help you remember to brush twice a day at regular intervals, and it also keeps track of and reminds you to replace your brush head. History and Achievements works as motivation to keep the user interested, which can also be shared to social media. Lastly the application includes oral health tips from dental professionals. 

### User Manual

__How to run the application:__

1. Open `GreatTeeth.xcodeproj` in Xcode
2. Wait for the project to load and finish indexing
3. Choose iPhone 6/6s simulator 
4. Press Build-and-Run (the play icon)

__How to use the application:__

1. To start a session, press the _start brushing_ button. This will guide you through a 4-step timed brushing, 1-step timed flossing, and 1-step timed rinsing session. During the timed session you can also pause the timer or skip the current section/ activity. At the end of the session, a summary screen will be presented with either a achievement or tip, along with your current history. You can press _share_ to share the tip or achievement to any social media or other application currently installed on the device. Press the _Close_ button in the upper right corner to close this screen.
2. All tips are available for viewing by tapping the _Tips_ button in the upper left corner on the main screen.
3. Pressing _Settings_ in the upper right corner from the main screen allows you to specify the time of your brushing reminders (morning and evening), and setting the brush head replacement reminder duration.  

### Developer Manual

We have used the Apple-recommended MVC (Model-View-Controller) architecture when designing this application. The following is a description of all the files and how they work together.

__Models__

* `AppDelegate.swift`: The AppDelegate is responsible for setting up the application, as well as handling any notifications the device might send to the application during runtime.
* `ActivityTracker.swift`: The ActivityTracker is a singleton object, responsible for tracking each individual session. This has been separated from the controller to keep it from knowing anything about what is happening behind-the-scenes, and only concern itself about notifying its subviews to change. The `ActivityType` enum is there to separate the different activities from eachother, with regards to different durations and repetitions. This is also used to let the main views know how to present themselves (based on the activity type). It inhertits from `NSObject` which is a protocol that groups methods that are fundamental to `Objective-C` objects (and in turn is necesarry for a lot of the classes we are using, such as `NSTimer`).
* 