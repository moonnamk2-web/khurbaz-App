import Flutter
import GoogleMaps
import Firebase
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyA5ueYFqJ4ZoVmp0W7VnauqsqBqsDE-ie0")
    GeneratedPluginRegistrant.register(with: self)
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      do {
        if #available(iOS 10.0, *) {
              UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
      } catch {
          print(error)
      }

      if(!UserDefaults.standard.bool(forKey: "Notification")) {
          UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
          UserDefaults.standard.set(true, forKey: "Notification")
      }
     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

      override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
          super.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
              Messaging.messaging().appDidReceiveMessage(userInfo)
              print(userInfo)

        }
}
