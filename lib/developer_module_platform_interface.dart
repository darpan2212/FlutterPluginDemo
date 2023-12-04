import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'developer_module_method_channel.dart';

abstract class DeveloperModulePlatform extends PlatformInterface {
  /// Constructs a DeveloperModulePlatform.
  DeveloperModulePlatform() : super(token: _token);

  static final Object _token = Object();

  static DeveloperModulePlatform _instance = MethodChannelDeveloperModule();

  /// The default instance of [DeveloperModulePlatform] to use.
  ///
  /// Defaults to [MethodChannelDeveloperModule].
  static DeveloperModulePlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeveloperModulePlatform] when
  /// they register themselves.
  static set instance(DeveloperModulePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> isDeveloperOptionEnable() {
    throw UnimplementedError('isDeveloperOptionEnable() has not been implemented.');
  }
}
