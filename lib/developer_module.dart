import 'package:http/http.dart' as http;

import 'developer_module_platform_interface.dart';

class DeveloperModule {
  Future<String?> getPlatformVersion() {
    return DeveloperModulePlatform.instance.getPlatformVersion();
  }

  Future<bool?> isDeveloperOptionEnable() {
    return DeveloperModulePlatform.instance.isDeveloperOptionEnable();
  }

  Future<String?> getList() async {
    var url = Uri.https("mocki.io", "v1/d4867d8b-b5d5-4a48-a4ab-79131b5809b8");
    var response = await http.get(url);
    var finalRes = "${response.statusCode}-->${response.body}";
    return finalRes;
  }

}
