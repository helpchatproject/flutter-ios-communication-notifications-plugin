import Flutter
import UIKit

public class IosCommunicationConstant {
    static public let prefixIdentifier: String = "CommunicationNotification"
    static public let payloadStored: String = "cn#lambiengcode"
    static public let payloadUpdatedAt: String = "dtime#lambiengcode"
}

public class IosCommunicationNotificationPlugin: NSObject, FlutterPlugin {
    static public var shared = IosCommunicationNotificationPlugin()
    
    public var flutterChannel: FlutterMethodChannel?
    
    public func onClickNotification(_ userInfo: [AnyHashable : Any]) {
        if (self.flutterChannel != nil) {
            self.flutterChannel?.invokeMethod("onClick", arguments: userInfo)
        } else {
            // Save to local storage - for get initial payload
            let defaults = UserDefaults.standard
            defaults.set(convertDateToString(Date()), forKey: IosCommunicationConstant.payloadUpdatedAt)
            defaults.set(userInfo["data"], forKey: IosCommunicationConstant.payloadStored)
        }
    }

    public func getLocalizeAndShow(_ userInfo: [AnyHashable : Any]) {
            if (self.flutterChannel != nil) {
                self.flutterChannel?.invokeMethod("onBackCall", arguments: userInfo)
            } else {
                // Save to local storage - for get initial payload
                let defaults = UserDefaults.standard
                defaults.set(convertDateToString(Date()), forKey: IosCommunicationConstant.payloadUpdatedAt)
                defaults.set(userInfo["data"], forKey: IosCommunicationConstant.payloadStored)
            }
        }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ios_communication_notification", binaryMessenger: registrar.messenger())
        let instance = IosCommunicationNotificationPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        IosCommunicationNotificationPlugin.shared.flutterChannel = channel
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "getInitialPayload":
            let defaults = UserDefaults.standard
            let updatedAt = defaults.string(forKey: IosCommunicationConstant.payloadUpdatedAt)
            
            if (updatedAt == nil || (Date().timeIntervalSinceReferenceDate -  convertStringToDate(updatedAt!).timeIntervalSinceReferenceDate) <= 5) {
                result(defaults.string(forKey: IosCommunicationConstant.payloadStored))
            } else {
                defaults.removeObject(forKey: IosCommunicationConstant.payloadStored)
                defaults.removeObject(forKey: IosCommunicationConstant.payloadUpdatedAt)
                result(nil)
            }
            
            break
        case "showNotification":
            let arguments = call.arguments as? [String: Any] ?? [String: Any]()
            let senderName = arguments["senderName"] as? String ?? ""
            let uuid = arguments["id"] as? String ?? ""
            let content = arguments["content"] as? String ?? ""
            let soundName = arguments["sound"] as? String ?? "alarm"
            guard let avatar = (arguments["imageBytes"] as? FlutterStandardTypedData)?.data else {
                result(nil)
                return
            }
            let value = arguments["value"] as? String ?? ""
            CommunicationNotificationPlugin().showNotification(NotificationInfo(senderName: senderName, pngImage: avatar, content: content, value: value , id:uuid,
            sound:soundName))
            result(true)
            break
        case "isAvailable":
            if #available(iOS 15.0, *) {
                result(true)
            } else {
                result(false)
            }
            break
        case "cancelNotification" :
            let arguments = call.arguments as? [String: Any] ?? [String: Any]()
            let identifier = arguments["identifier"] as? String ?? ""
            CommunicationNotificationPlugin().cancelNotification(identifier)
            result(true)
            break
        case "cancelAllNotification" :
            CommunicationNotificationPlugin().cancelAllNotification()
            result(true)
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
    
    public func convertDateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let result = formatter.string(from: date)
        return result
    }
    
    public func convertStringToDate(_ dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        guard let result = formatter.date(from: dateString) else { return Date() }
        return result
    }
}
