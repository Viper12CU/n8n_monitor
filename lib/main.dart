
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:n8n_monitor/provider/initial_conf_form_provider.dart';
import 'package:n8n_monitor/provider/nav_index_provider.dart';
import 'package:n8n_monitor/provider/server_status_animation_provider.dart';
import 'package:n8n_monitor/provider/workflow_filter_provider.dart';
import 'package:n8n_monitor/provider/execution_filter_provider.dart';
import 'package:n8n_monitor/services/local_storage.dart';
import 'package:n8n_monitor/utils/routes.dart';
import 'package:n8n_monitor/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await LocalStorage.init();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF122017),
      statusBarColor: Color(0xFF122017)
    )
  );

  

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InitialConfFormProvider()),
        ChangeNotifierProvider(create: (_) => NavIndexProvider()),
        ChangeNotifierProvider(create: (_) => ServerStatusAnimationProvider()),
        ChangeNotifierProvider(create: (_) => WorkflowFilterProvider()),
        ChangeNotifierProvider(create: (_) => ExecutionFilterProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool urlExist = LocalStorage.url != null;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'n8n Monitor',
      theme: AppTheme.darkTheme,
      initialRoute: urlExist ? AppRoutes.homePage : AppRoutes.apiConfiguration,
      routes: AppRoutes.routes,
    );
  }
}
