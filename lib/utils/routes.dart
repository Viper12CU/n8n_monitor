import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/pages/api_configuration_page.dart';
import 'package:n8n_monitor/widgets/pages/home_page.dart';
import 'package:n8n_monitor/widgets/pages/server_offline_page.dart';
import 'package:n8n_monitor/widgets/pages/servers_manage_page.dart';
import 'package:n8n_monitor/widgets/pages/tags_page.dart';
import 'package:n8n_monitor/widgets/pages/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String apiConfiguration = '/initialConfig';
  static const String homePage = '/homePage';
  static const String serverOffline = '/serverOfline';
  static const String tags = '/tags';
  static const String serverManage = '/serverManage';

  

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    apiConfiguration: (context) => const ApiConfigurationPage(),
    homePage: (context) => const HomePage(),
    serverOffline: (context) => ServerOfflinePage(),
    tags: (context) => const TagsPage(),
    serverManage: (context) => ServersManagePage(),
    // settings: (context) => const SettingsPage(),
  };
}