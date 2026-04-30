import UIKit
import Flutter
import Firebase
import GoogleMaps
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Google Maps
    GMSServices.provideAPIKey("AIzaSyA5ueYFqJ4ZoVmp0W7VnauqsqBqsDE-ie0")

    // Firebase
    FirebaseApp.configure()

    // Register plugins
    GeneratedPluginRegistrant.register(with: self)

    // Notifications
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    // 🔥 IMPORTANT
    application.registerForRemoteNotifications()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // 🔥 مهم لربط APNs مع Firebase
    override func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      print("🔥 APNS TOKEN RECEIVED")
      Messaging.messaging().apnsToken = deviceToken
    }

  // استقبال الإشعارات بالخلفية
  override func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable: Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
  ) {
    Messaging.messaging().appDidReceiveMessage(userInfo)
    completionHandler(.newData)
  }
}
