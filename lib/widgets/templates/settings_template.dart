import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/http_client.dart';
import 'package:n8n_monitor/services/local_storage.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_button.dart';
import 'package:n8n_monitor/widgets/atoms/custom_group_category.dart';
import 'package:n8n_monitor/widgets/atoms/custom_snackbar.dart';
import 'package:n8n_monitor/widgets/molecules/audit_options_card.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';
import 'package:n8n_monitor/widgets/molecules/connection_settings_form.dart';

class SettingsTemplate extends StatelessWidget {
  const SettingsTemplate({super.key});

  Future<void> _handleTestApi(
    BuildContext context,
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

      LocalStorage.setUrl(url);
      LocalStorage.setApiKey(apiKey);
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 20.0,
          children: [
            CustomGroupCategory(
              category: "Conexión",
              child: ConnectionSettingsForm(
                initialUrl: LocalStorage.url!,
                initialApiKey: LocalStorage.apiKey!,
                onSave: (url, apiKey) async =>
                    await _handleTestApi(context, url, apiKey),
              ),
            ),
            CustomGroupCategory(
              category: "Auditorías",
              child: AuditOptionsCard(),
            ),

            //!Solo debug, eliminar
            CustomButton(
              label: "Limpiar Historial para debug",
              icon: Icons.warning_amber_rounded,
              onTap: () async {
                final result = await ConfirmationDialog.show(
                  context,
                  title: 'Confirmar eliminación',
                  message:
                      '¿Estás seguro de que deseas eliminar este registro de ejecución? Esta acción no se puede deshacer.',
                );

                if (result != null) {
                  LocalStorage.clearStorage();
                }
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    CustomSnackbar.show(
                      context: context,
                      message: "Mensaje de información",
                      type: SnackbarType.info,
                    );
                  },
                  child: Text("Info"),
                ),

                ElevatedButton(
                  onPressed: () {
                    CustomSnackbar.show(
                      context: context,
                      message: "Mensaje de error",
                      type: SnackbarType.error,
                    );
                  },
                  child: Text("Error"),
                ),

                ElevatedButton(
                  onPressed: () {
                    CustomSnackbar.show(
                      context: context,
                      message:
                          "Mensaje de success muy pero q muy largo por una razon",
                      type: SnackbarType.success,
                    );
                  },
                  child: Text("Success"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
