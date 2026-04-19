import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/credencials.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_group_category.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/atoms/error_message.dart';
import 'package:n8n_monitor/widgets/molecules/credentials_list.dart';
import 'package:n8n_monitor/widgets/molecules/credentials_search_panel.dart';

class CredencialsListTemplate extends StatefulWidget {
  const CredencialsListTemplate({super.key});

  @override
  State<CredencialsListTemplate> createState() => _CredencialsListTemplateState();
}

class _CredencialsListTemplateState extends State<CredencialsListTemplate> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _credentials = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredCredentials {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      return _credentials;
    }

    return _credentials.where((credential) {
      final name = (credential['name'] ?? '').toString().toLowerCase();
      final id = (credential['id'] ?? '').toString().toLowerCase();
      final type = (credential['type'] ?? '').toString().toLowerCase();
      return name.contains(query) || id.contains(query) || type.contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> _extractCredentials(dynamic data) {
    final dynamic rawList = data is Map<String, dynamic> && data['data'] is List
        ? data['data']
        : data;

    if (rawList is! List) {
      return [];
    }

    return rawList.whereType<Map>().map((credential) {
      return Map<String, dynamic>.from(credential);
    }).toList();
  }

  Future<void> _loadCredentials() async {
    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final response = await getCredentials();

    if (!mounted) {
      return;
    }

    if (response['error'] != null) {
      setState(() {
        _errorMessage = response['error'];
        _isLoading = false;
      });
      return;
    }

    final credentials = _extractCredentials(response['data']);

    setState(() {
      _credentials = credentials;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CustomLoader(variant: LoaderVariant.light));
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ErrorMessage(
            errorLabel: 'Error al cargar credenciales',
            description: _errorMessage!,
            onRetry: _loadCredentials,
          ),
        ),
      );
    }

    final filteredCredentials = _filteredCredentials;

    return RefreshIndicator(
      onRefresh: _loadCredentials,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        children: [
          CustomGroupCategory(
            category: 'Credenciales',
            child: _credentials.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        'No hay credenciales registradas.',
                        style: TextStyle(
                          color: Colors.white.withAlpha((0.7 * 255).toInt()),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      CredentialsSearchPanel(
                        controller: _searchController,
                        onChanged: () => setState(() {}),
                        onClear: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 12),
                      if (filteredCredentials.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'No se encontraron credenciales para la busqueda.',
                            style: TextStyle(
                              color: Colors.white.withAlpha(
                                (0.7 * 255).toInt(),
                              ),
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        CredentialsList(credentials: filteredCredentials),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}