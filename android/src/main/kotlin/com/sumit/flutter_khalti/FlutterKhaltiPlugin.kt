package com.sumit.flutter_khalti

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import com.khalti.checkout.helper.Config
import com.khalti.checkout.helper.KhaltiCheckOut
import com.khalti.checkout.helper.OnCheckOutListener
import com.khalti.utils.Constant
import java.lang.Exception

/** FlutterKhaltiPlugin */
class FlutterKhaltiPlugin: MethodCallHandler {
  
  companion object {
    @SuppressLint("StaticFieldLeak")
    lateinit var context: Activity
    lateinit var channel: MethodChannel

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      context = registrar.activity()
      channel = MethodChannel(registrar.messenger(), "flutter_khalti")
      channel.setMethodCallHandler(FlutterKhaltiPlugin())
    }
  }

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
    val khaltiCheckOut = KhaltiCheckOut(context, builder.build())
    context.runOnUiThread {
      khaltiCheckOut.show()
    }
  }
}
