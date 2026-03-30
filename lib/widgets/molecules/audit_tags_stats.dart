import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/tags.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/utils/routes.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';

class AuditTagsStats extends StatefulWidget {
  const AuditTagsStats({super.key});

  @override
  State<AuditTagsStats> createState() => _AuditTagsStatsState();
}

class _AuditTagsStatsState extends State<AuditTagsStats>
    with TickerProviderStateMixin {
  bool _isLoading = true;
  int _totalTags = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _loadStats();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadStats() async {
    try {
      final result = await getTags();

      if (!mounted) return;

      if (result['error'] != null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final tagsData = result['data'];
      if (tagsData == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      int totalTags = 0;

      if (tagsData is Map<String, dynamic>) {
        final tags = tagsData['data'] as List? ?? [];
        totalTags = tags.length;
      } else if (tagsData is List) {
        totalTags = tagsData.length;
      }

      setState(() {
        _totalTags = totalTags;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasData = _totalTags > 0;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _isLoading || !hasData
                ? null
                : () {
                    Navigator.of(context).pushNamed(AppRoutes.tags);
                  },
            borderRadius: BorderRadius.circular(22),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF27352d)),
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(22),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 92,
                      child: Center(
                        child: CustomLoader(variant: LoaderVariant.light),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_offer_rounded,
                              size: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Tags disponibles',
                                style: TextStyle(
                                  color: Colors.white.withAlpha((0.88 * 255).toInt()),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        dataContainer(context, _totalTags),

                        if (hasData) ...[
                          const SizedBox(height: 14),
                          Text(
                            'Toca para gestionar',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Center dataContainer(BuildContext context, int totalTag) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: BoxBorder.all(
            color: Theme.of(context).primaryColor,
            width: 3,
          ),
          color: Colors.transparent,
        ),
        child: Center(child: Text(totalTag.toString(), style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),)),
      ),
    );
  }
}
