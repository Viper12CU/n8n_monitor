import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/pages/api_configuration_page.dart';
import 'package:n8n_monitor/widgets/pages/home_page.dart';

class AppRoutes {
  static const String apiConfiguration = '/initialConfig';
  static const String homePage = '/homePage';

  static Map<String, WidgetBuilder> routes = {
    apiConfiguration: (context) => const ApiConfigurationPage(),
    homePage: (context) => const HomePage(),
    // settings: (context) => const SettingsPage(),
  };
}