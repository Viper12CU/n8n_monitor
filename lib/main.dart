import 'package:flutter/material.dart';
import 'package:n8n_monitor/provider/initial_conf_form_provider.dart';
import 'package:n8n_monitor/provider/nav_index_provider.dart';
import 'package:n8n_monitor/provider/server_status_animation_provider.dart';
import 'package:n8n_monitor/utils/routes.dart';
import 'package:n8n_monitor/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InitialConfFormProvider()),
        ChangeNotifierProvider(create: (_) => NavIndexProvider()),
        ChangeNotifierProvider(create: (_) => ServerStatusAnimationProvider()),

      ], 
      child: const MyApp()
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'n8n Monitor',
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.homePage,
      routes: AppRoutes.routes,
    );
  }
}
