import UIKit
import Flutter
import flutter_local_notifications
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    lazy var flutterEngine = FlutterEngine(name: "MyApp")
    
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run()
 
        // Used to connect plugins (only if you have plugins with iOS platform code).
        FirebaseApp.configure()
        // This is required to make any communication available in the action isolate.
        
            /* FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
                GeneratedPluginRegistrant.register(with: registry)
            } */

            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            }
        GeneratedPluginRegistrant.register(with: self.flutterEngine)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
