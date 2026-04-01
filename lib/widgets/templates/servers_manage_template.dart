import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/http_client.dart';
import 'package:n8n_monitor/services/server_credentials_service.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/atoms/custom_group_category.dart';
import 'package:n8n_monitor/widgets/atoms/custom_snackbar.dart';
import 'package:n8n_monitor/widgets/molecules/connection_settings_form.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';
import 'package:n8n_monitor/widgets/molecules/server_credentials_list.dart';

class ServersManageTemplate extends StatefulWidget {
  const ServersManageTemplate({super.key});

  @override
  State<ServersManageTemplate> createState() => _ServersManageTemplateState();
}

class _ServersManageTemplateState extends State<ServersManageTemplate> {
  bool _isLoading = true;
  List<ServerCredential> _credentials = [];

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    final all = await ServerCredentialsService.instance.getAll();
    if (!mounted) return;

    setState(() {
      _credentials = all;
      _isLoading = false;
    });
  }

  Future<void> _handleTestApi(
    BuildContext context,
    String label,
    String url,
    String apiKey,
  ) async {
    try {
      final isConnected = await HttpClient.testConnection(
        baseUrl: url,
        apiKey: apiKey,
      );

      if (!isConnected) {
        throw ErrorDescription("Credenciales incorrectas");
      }

      if (context.mounted) {
        CustomSnackbar.show(
          context: context,
          message: 'Conexión exitosa',
          type: SnackbarType.success,
        );
      }

      await ServerCredentialsService.instance.insertCredential(
        label: label.isNotEmpty ? label : url,
        url: url,
        apiKey: apiKey,
        inUse: true,
      );

      if (mounted) {
        await _loadCredentials();
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackbar.show(
          context: context,
          message: 'Credenciales incorrectas ',
          type: SnackbarType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Gestionar servidor"),
        ),
        body: const Center(
          child: CustomLoader(variant: LoaderVariant.light),
        ),
      );
    }

    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          spacing: 20.0,
          children: [
            CustomGroupCategory(
              category: "Nueva conexión",
              child: ConnectionSettingsForm(
                initialLabel: '',
                initialUrl: '',
                initialApiKey: '',
                onSave: (label, url, apiKey) async =>
                    await _handleTestApi(context, label, url, apiKey),
              ),
            ),
            CustomGroupCategory(
              category: "Credenciales guardadas",
              child: ServerCredentialsList(
                credentials: _credentials,
                onSetActive: (id) async {
                  await ServerCredentialsService.instance.setInUse(id);
                  await _loadCredentials();
                },
                onDelete: (id) async {
                  final result = await ConfirmationDialog.show(
                    context,
                    title: 'Eliminar credencial',
                    message:
                        '¿Estás seguro de que deseas eliminar esta credencial?',
                  );
      
                  if (result == null) return;
      
                  await ServerCredentialsService.instance.deleteCredential(id);
                  await _loadCredentials();
      
                  if (context.mounted) {
                    CustomSnackbar.show(
                      context: context,
                      message: 'Credencial eliminada',
                      type: SnackbarType.success,
                    );
                  }
                },
              ),
            ),
          ],
        ),
    );
  }
}