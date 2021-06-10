import Flutter
import UIKit
import Khalti

public class SwiftFlutterKhaltiPlugin: NSObject, FlutterPlugin,KhaltiPayDelegate {
    
   public var viewController: UIViewController
   public var channel:FlutterMethodChannel

    
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_khalti", binaryMessenger: registrar.messenger())
    
    let viewController: UIViewController =
                (UIApplication.shared.delegate?.window??.rootViewController)!;
    let instance = SwiftFlutterKhaltiPlugin(viewController: viewController, channel
                : channel)
    
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
    public init(viewController:UIViewController, channel:FlutterMethodChannel) {
           self.viewController = viewController
           self.channel = channel
    }

    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
            switch call.method {
            case "initKhaltiPayment":
                startPayment(call: call)
                result(true)
                break;
            case "testPublicKey":
                result("test_public_key_dc74e0fd57cb46cd93832aee0a507256")
            default:
                break;
        }
    }
        
    func startPayment(call: FlutterMethodCall){
        let message = call.arguments as? Dictionary<String,Any>
        let publicKey =  message!["publicKey"] as? String
        let khaltiUrlScheme:String = toString(data: message!["urlSchemeIOS"]!)
        let productAmount: Int = toInt(json: message!["productAmount"]!)
        let productId: String = toString(data: message!["productID"]!)
        let productName:String = toString(data: message!["productName"]!)
            
        let _CONFIG:Config = Config(
            publicKey: toString(data: publicKey!),
            amount: productAmount,
            productId: productId,
            productName: productName
        );
            
        Khalti.shared.appUrlScheme = khaltiUrlScheme
            
        Khalti.present(caller: viewController, with: _CONFIG, delegate: self)
    }
    
    public func onCheckOutSuccess(data: Dictionary<String, Any>) {
        channel.invokeMethod("khalti_success",arguments:  data)
    }
       
    public func onCheckOutError(action: String, message: String, data: Dictionary<String,Any>?) {
        channel.invokeMethod("khalti_error",arguments: data)
    }
    
    func toString(data:Any) -> String{
        return data as? String ?? ""
    }
        
    func toInt(json:Any) -> Int{
        return json as! Int
    }
}
