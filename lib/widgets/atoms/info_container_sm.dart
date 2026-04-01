import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';

class InfoContainerSm extends StatelessWidget {
  final InfoContainerSmVariant variant ;
  final IconData icon;
  final String title;
  final String value;
  final bool isLoading;
  const InfoContainerSm({
    super.key,
    this.variant = InfoContainerSmVariant.primary,
    required this.icon,
    required this.title,
    required this.value,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == InfoContainerSmVariant.primary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: isPrimary ? Color(0xFF27352d) : Theme.of(context).colorScheme.primary),
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: isLoading
          ? const Center(
              child: CustomLoader(variant: LoaderVariant.light),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 20, color: isPrimary ? Theme.of(context).iconTheme.color: Theme.of(context).colorScheme.primary),
                Text(
                  value,
                  style: TextStyle(
                    color: isPrimary ? Colors.white : Theme.of(context).colorScheme.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(title, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
              ],
            ),
    );
  }
}
