import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'developer_module_platform_interface.dart';

/// An implementation of [DeveloperModulePlatform] that uses method channels.
class MethodChannelDeveloperModule extends DeveloperModulePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('developer_module');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> isDeveloperOptionEnable() async {
    final isEnable = await methodChannel.invokeMethod<bool>('isDeveloperOptionEnable');
    return isEnable;
  }
}
