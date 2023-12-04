import 'package:flutter_test/flutter_test.dart';
import 'package:developer_module/developer_module.dart';
import 'package:developer_module/developer_module_platform_interface.dart';
import 'package:developer_module/developer_module_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeveloperModulePlatform 
    with MockPlatformInterfaceMixin
    implements DeveloperModulePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> isDeveloperOptionEnable() => Future.value(true);
}

void main() {
  final DeveloperModulePlatform initialPlatform = DeveloperModulePlatform.instance;

  test('$MethodChannelDeveloperModule is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeveloperModule>());
  });

  test('getPlatformVersion', () async {
    DeveloperModule developerModulePlugin = DeveloperModule();
    MockDeveloperModulePlatform fakePlatform = MockDeveloperModulePlatform();
    DeveloperModulePlatform.instance = fakePlatform;
  
    expect(await developerModulePlugin.getPlatformVersion(), '42');
  });
}
