package com.sumit.flutter_khalti;

import android.content.Context;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.khalti.checkout.helper.Config;
import com.khalti.checkout.helper.KhaltiCheckOut;
import com.khalti.checkout.helper.OnCheckOutListener;
import com.khalti.utils.Constant;

import org.jetbrains.annotations.NotNull;

import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class FlutterKhaltiPlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_khalti");
    context = flutterPluginBinding.getApplicationContext();
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("initKhaltiPayment")) {
      makePayment(call);
    } else {
      result.notImplemented();
    }
  }

  private void makePayment(MethodCall methodCall){
    HashMap<String,Object> message = methodCall.arguments();
    String publicKey = (String) message.get("publicKey");
    String productName = (String) message.get("productName");
    String productID = (String) message.get("productID");
    double productAmt = (double) message.get("productAmount");
    long productAmount = new Double(productAmt).longValue();

    Config.Builder builder = new Config.Builder(publicKey, productID, productName, productAmount, new OnCheckOutListener() {
      @Override
      public void onSuccess(@NonNull @NotNull Map<String, Object> data) {
        channel.invokeMethod("khalti_success",data);
      }

      @Override
      public void onError(@NonNull @NotNull String action, @NonNull @NotNull Map<String, String> errorMap) {
        HashMap<String, String> errorMessage = new HashMap<String, String>();
        errorMessage.put("action",action);
        errorMessage.put("message",toString());
        channel.invokeMethod("khalti_error",errorMessage);
      }
    });

    KhaltiCheckOut khaltiCheckOut = new KhaltiCheckOut(context, builder.build());
    khaltiCheckOut.show();
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
