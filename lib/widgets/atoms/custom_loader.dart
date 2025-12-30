import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:n8n_monitor/utils/enums.dart';



class CustomLoader extends StatelessWidget {
  final LoaderVariant variant;
  const CustomLoader({super.key, required this.variant});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(color: variant == LoaderVariant.dark ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).colorScheme.primary , size: 45);
  }
}