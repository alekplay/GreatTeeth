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
* `ActivityTracker.swift`: The ActivityTracker is a singleton object, responsible for tracking each individual session. This has been separated from the controller to keep it from knowing anything about what is happening behind-the-scenes, and only concern itself about notifying its subviews to change. The `ActivityType` enum is there to separate the different activities from eachother, with regards to different durations and repetitions. This is also used to let the main views know how to present themselves (based on the activity type). The class inhertits from `NSObject` which is a protocol that groups methods that are fundamental to `Objective-C` objects (and in turn is necesarry for a lot of the classes we are using, such as `NSTimer`). It keeps track of the current activity type, the current time, current repetition, timer, and the callback to use each second. The timerloop executes every second, calls the callback with the remaining time, remaining repetitions, percent complete, current activity, and whether it's done (notifies the controller with this information). It also updates the repetitions according to the current time and activity, and stops the timer if done. The `pauseTimer`, `resumeTimer`, `isPaused`, and `skipToNext` methods are notification methods for the controller to interact with the ActivityTracker. The remaining methods are simple setup methods that resets and prepares the ActivityTracker.

__Controllers__

* `InitialViewController.swift`: The InitialViewController handles the communication between the views and the ActivityTracker. It tells the subviews how to lay themselves out, responds to interaction from the user, and responds to callbacks from the ActivityTracker. It has a number of outlets which connects to objects on the view, including, but not limited to, the labels, buttons, and progress views. The `viewDidLoad` method takes care of any final layout changes to the view, which includes adding the background gradient, removing features of the navigation bar, and reset the angle of the circular progress view. The `prepareInterfaceForActivityType` takes an ActivityType and lays out the interface according to preset standards for each individual type. The `setUpAsInitial` resets the entire interface to the orignal pre-session interface, and is used after finishing a session. The `updateViewForTime` is the callback which is called by the ActivityTracker every second. It updates the labels and progress bars with the new progress, and progresses through the activities if necesarry. This includes preparing the interface for a new activity, restarting the ActivityTracker, keeping track of the history, and presenting the summary view controller. The actions handle the button interactions from the user, including starting the ActivityTracker, pausing, and skipping activities. 
* `SummaryViewController.swift`: The SummaryViewController displays the summary view, which includes information about the achivement, history, and so on. This information is retreived from the `NSUserDefaults`, which is a storage location for minor data. 
* `SettingsTableViewController.swift`: The SettingsTableViewController is a `UITableViewController` subclass which displays the static settings table view, and allows for interaction with the individual rows. It prepares special headers and footers for the tableview, and also presents an alert to confirm that replacement of a brush head/ toothbrush. It also displays information about the individual rows, such as date last replaced, and suggested date for replacement. 
* `SetEveningViewController.swift`: SetEveningViewController presents a `UIDatePicker` which allows the user to change the date of his/ her evening brushing reminders. It also schedules the local notifications to be displayed at this time.
* `SetMorningViewController.swift`: SetMorningViewController does the same as SetEveningViewController, except it effects the morning reminders as opposed to the evening reminders.
* `TimeTillReplacementViewController.swift`: TimeTilLReplacementViewController displays a `UISlider` that allows the user to select the interval at which to replace his/ hers brush head. It stores the selected value in the User Defaults, so they can be accessed from the SettingsTableViewController. 
* `TipsViewController.swift`: TipsViewController displays a static list of dentist suggested tips.

__XIBs__

* `Main.storyboard`: Main is a interface builder document that handles the basic layout of the screens and navigation between them. It consists of three navigation controllers, one of which handles the navigation of the main interface, the second the navigation of the settings menu, and the last the navigation of the tips view controller. It also displays the navigation bar in each of these hierarchies. The navigation between these controllers is a mix between `show` and `modal` segues, each used where they fit the best.
* `LaunchScreen.storyboard`: LaunchScreen is a interface builder document that handles the display of a quick launch/ splash screen at the beginning of the app which gives the impression of the app launching quicker. This has not been changed and displays a basic white screen.

__Assets__

* `Assets.xcassets`: Assets contains a list over all images/ assets used in the application, including, but not limited to, buttons, images (such as the notifications), etc.
* `Info.plist`: Info is a property list that contains information relevant to the application, including, but not limited to, the app name, language, device limitations, etc.

__Libraries__

* `KDCircularProgress.swift`: KDCircularProgress is a open-source library that facilitates the use of a circular progress view. The code here has not been changed from the original available at [GitHub](https://github.com/kaandedeoglu/KDCircularProgress). It has however been highly customized in the storyboard using `IBDesignable`. 