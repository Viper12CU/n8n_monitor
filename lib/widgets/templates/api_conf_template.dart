import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/initial_conf_hero.dart';
import 'package:n8n_monitor/widgets/organisms/api_conf_form.dart';

class ApiConfTemplate extends StatefulWidget {
  const ApiConfTemplate({super.key});

  @override
  State<ApiConfTemplate> createState() => _ApiConfTemplateState();
}

class _ApiConfTemplateState extends State<ApiConfTemplate> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        spacing: 20,
        children: [const InitialConfHero(), ApiConfForm()],
      ),
    );
  }
}
