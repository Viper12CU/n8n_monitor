import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/pages/api_configuration_page.dart';
import 'package:n8n_monitor/widgets/pages/home_page.dart';
import 'package:n8n_monitor/widgets/pages/server_offline_page.dart';
import 'package:n8n_monitor/widgets/pages/tags_page.dart';

class AppRoutes {
  static const String apiConfiguration = '/initialConfig';
  static const String homePage = '/homePage';
  static const String serverOffline = '/serverOfline';
  static const String tags = '/tags';

  static Map<String, WidgetBuilder> routes = {
    apiConfiguration: (context) => const ApiConfigurationPage(),
    homePage: (context) => const HomePage(),
    serverOffline: (context) => ServerOfflinePage(),
    tags: (context) => const TagsPage(),
    // settings: (context) => const SettingsPage(),
  };
}