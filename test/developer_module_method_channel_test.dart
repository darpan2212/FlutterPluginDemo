import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:developer_module/developer_module_method_channel.dart';

void main() {
  MethodChannelDeveloperModule platform = MethodChannelDeveloperModule();
  const MethodChannel channel = MethodChannel('developer_module');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
