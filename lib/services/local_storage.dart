import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String? get url => _preferences?.getString("n8nUrl");

  static Future setUrl(String value) async {
    await _preferences?.setString("n8nUrl", value);
  }

  static String? get apiKey => _preferences?.getString("n8nApiKey");

  static Future setApiKey(String value) async {
    await _preferences?.setString("n8nApiKey", value);
  }

  static String? get workflowFilter => _preferences?.getString("workflowFilter");

  static Future setWorkflowFilter(String value) async {
    await _preferences?.setString("workflowFilter", value);
  }

  static String? get executionFilter => _preferences?.getString("executionFilter");

  static Future setExecutionFilter(String value) async {
    await _preferences?.setString("executionFilter", value);
  }

  static void clearStorage() {
    _preferences?.clear();
  }
}
