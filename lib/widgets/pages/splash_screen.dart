import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/app_theme.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/utils/routes.dart';
import 'package:n8n_monitor/services/server_credentials_service.dart';
import 'package:n8n_monitor/api/http_client.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();

    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      final credential = await ServerCredentialsService.instance.getInUse();

      // Verificar si hay credenciales activas
      if (credential == null) {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.apiConfiguration);
        }
        return;
      }

      // Verificar conexión con el servidor
      final isConnected = await HttpClient.testConnection(
        baseUrl: credential.url,
        apiKey: credential.apiKey,
      );

      if (mounted) {
        if (isConnected) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.homePage);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.serverOffline);
        }
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo con animación
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryColor.withOpacity(0.8),
                        AppTheme.primaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.speed,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Título con animación
            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'n8n Monitor',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
              ),
            ),
            const SizedBox(height: 15),
            // Subtítulo
            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'Monitoreo en tiempo real',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF9eb7a8),
                      fontSize: 14,
                    ),
              ),
            ),
            const SizedBox(height: 60),
            // Indicador de carga animado
            FadeTransition(
              opacity: _fadeAnimation,
              child: SizedBox(
                width: 50,
                height: 50,
                child: CustomLoader(variant: LoaderVariant.light)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
