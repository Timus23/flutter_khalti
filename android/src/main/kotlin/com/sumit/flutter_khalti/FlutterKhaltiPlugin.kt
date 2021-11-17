package com.sumit.flutter_khalti

import android.app.Activity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import com.khalti.checkout.helper.Config
import com.khalti.checkout.helper.KhaltiCheckOut
import com.khalti.checkout.helper.OnCheckOutListener
import com.khalti.utils.Constant
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FlutterKhaltiPlugin */
class FlutterKhaltiPlugin: FlutterPlugin, MethodChannel.MethodCallHandler,ActivityAware {

  private lateinit var channel : MethodChannel;
  lateinit var appActivity: Activity;

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "initKhaltiPayment" -> {
        makePayment(call)
      }
      "testPublicKey" -> {
        result.success(Constant.pub)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun makePayment(methodCall: MethodCall) {
    val message: HashMap<String, Any> = methodCall.arguments()
    val publicKey = message["publicKey"] as String
    val productName = message["productName"] as String
    val productID = message["productID"] as String
    val productAmt = message["productAmount"] as Double
    val productAmount = productAmt.toLong()
    val builder = Config.Builder(
            publicKey,
            productID,
            productName,
            productAmount,
            object : OnCheckOutListener {
              override fun onSuccess(data: MutableMap<String, Any>) {
                channel.invokeMethod("khalti_success", data)
              }

              override fun onError(action: String, errorMap: MutableMap<String, String>) {
                val errorMessage = HashMap<String, String>()
                errorMessage["action"] = action
                errorMessage["message"] = toString()
                channel.invokeMethod("khalti_error", errorMessage) }
            }
    )
    val khaltiCheckOut = KhaltiCheckOut(appActivity, builder.build())
    appActivity.runOnUiThread {
      khaltiCheckOut.show()
    }
  }

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "flutter_khalti")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    appActivity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    appActivity= binding.activity;
  }

  override fun onDetachedFromActivity() {
  }
}
