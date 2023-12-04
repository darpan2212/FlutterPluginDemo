package com.sample.developer_module;

import android.content.Context;
import android.os.Build;
import android.provider.Settings;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** DeveloperModulePlugin */
public class DeveloperModulePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private static Context context;

  public static void setContext(Context context) {
    DeveloperModulePlugin.context =context;
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "developer_module");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } if (call.method.equals("isDeveloperOptionEnable")) {
      result.success(isDeveloperModeEnabled());
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  public boolean isDeveloperModeEnabled() {
    boolean isEnabled;
    if (Build.VERSION.SDK_INT == 16) {
      isEnabled = Settings.Secure.getInt(
              context.getContentResolver(),
              Settings.Secure.DEVELOPMENT_SETTINGS_ENABLED,
              0
      ) != 0;
    } else if (Build.VERSION.SDK_INT >= 17) {
      isEnabled = Settings.Secure.getInt(
              context.getContentResolver(),
              Settings.Global.DEVELOPMENT_SETTINGS_ENABLED,
              0
      ) != 0;
    } else {
      isEnabled = false;
    }

    return isEnabled;
  }
}
