import 'package:flutter/material.dart';
import 'package:n8n_monitor/provider/server_stats_provider.dart';
import 'package:n8n_monitor/widgets/pages/servers_manage_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CredentialsStatsCard extends StatefulWidget {
  const CredentialsStatsCard({Key? key}) : super(key: key);

  @override
  State<CredentialsStatsCard> createState() => _CredentialsStatsCardState();
}

class _CredentialsStatsCardState extends State<CredentialsStatsCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ServerStatsProvider>().loadStats();
      }
    });
  }

  Color _getExpirationColor(int daysLeft) {
    if (daysLeft < 0) return Colors.white;
    if (daysLeft <= 7) return Colors.redAccent;
    if (daysLeft <= 30) return Colors.orangeAccent;
    return Colors.greenAccent;
  }

  String _formatDaysLeft(int days) {
    if (days < 0) return 'Sin fecha';
    if (days == 0) return 'Hoy';
    if (days == 1) return 'Mañana';
    return '$days d';
  }

  void _navigateToServerManage(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 300),
        type: PageTransitionType.leftToRight,
        child: const ServersManagePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServerStatsProvider>(
      builder: (context, provider, _) {
        return GestureDetector(
          onTap: () {
            provider.refresh();
            _navigateToServerManage(context);
          },
          child: Container(
            constraints: const BoxConstraints(minHeight: 200),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF27352d), width: 1.2),
            ),
            child: Column(
              spacing: 12,
              children: [
                // Header con icono
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Icon(
                          Icons.security_rounded,
                          color: Colors.blueAccent,
                          size: 18,
                        ),
                        const Text(
                          'API Keys',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${provider.totalCredentials}',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                // Divider
                Container(height: 0.8, color: const Color(0xFF27352d)),
                // Servidor activo
                if (provider.activeServer != null)
                  Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Activo: ${provider.activeServer!.label}',
                        style: const TextStyle(
                          color: Color(0xFF99FFFFFF),
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Expira en',
                            style: TextStyle(
                              color: Color(0x99FFFFFF),
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            provider.activeServer!.hasExpirationDate
                                ? _formatDaysLeft(
                                    provider.daysUntilActiveExpires,
                                  )
                                : 'N/A',
                            style: TextStyle(
                              color: _getExpirationColor(
                                provider.daysUntilActiveExpires,
                              ),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  const Text(
                    'Sin servidor activo',
                    style: TextStyle(color: Colors.orangeAccent, fontSize: 12),
                  ),
                // Divider
                Container(height: 0.8, color: const Color(0xFF27352d)),
                // Alertas compactas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _AlertBadgeCompact(
                      count: provider.alreadyExpired,
                      label: 'Exp.',
                      color: Colors.redAccent,
                    ),
                    _AlertBadgeCompact(
                      count: provider.expiringIn7Days,
                      label: 'Crítico',
                      color: Colors.orangeAccent,
                    ),
                    _AlertBadgeCompact(
                      count: provider.expiringIn30Days,
                      label: 'Pronto',
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AlertBadgeCompact extends StatelessWidget {
  final int count;
  final String label;
  final Color color;

  const _AlertBadgeCompact({
    required this.count,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2,
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: color.withOpacity(0.7), fontSize: 10),
        ),
      ],
    );
  }
}
