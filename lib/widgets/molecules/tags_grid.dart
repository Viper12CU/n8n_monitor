import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/tag_card.dart';

class TagsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> tags;
  final ValueChanged<Map<String, dynamic>> onUpdate;
  final ValueChanged<Map<String, dynamic>> onDelete;

  const TagsGrid({
    super.key,
    required this.tags,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tags.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final tag = tags[index];
        return TagCard(
          tag: tag,
          onUpdate: onUpdate,
          onDelete: onDelete,
        );
      },
    );
  }
}
