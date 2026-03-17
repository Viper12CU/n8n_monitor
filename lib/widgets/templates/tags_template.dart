import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/tags.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_group_category.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/atoms/custom_snackbar.dart';
import 'package:n8n_monitor/widgets/atoms/error_message.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';
import 'package:n8n_monitor/widgets/molecules/tags_create_form.dart';
import 'package:n8n_monitor/widgets/molecules/tags_grid.dart';
import 'package:n8n_monitor/widgets/molecules/tags_search_panel.dart';

class TagsTemplate extends StatefulWidget {
  const TagsTemplate({super.key});

  @override
  State<TagsTemplate> createState() => _TagsTemplateState();
}

class _TagsTemplateState extends State<TagsTemplate> {
  final TextEditingController _tagNameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _tags = [];
  bool _isLoading = true;
  bool _isCreating = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTags();
  }

  @override
  void dispose() {
    _tagNameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredTags {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      return _tags;
    }

    return _tags.where((tag) {
      final name = (tag['name'] ?? '').toString().toLowerCase();
      final id = (tag['id'] ?? '').toString().toLowerCase();
      return name.contains(query) || id.contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> _extractTags(dynamic data) {
    final dynamic rawList =
        data is Map<String, dynamic> && data['data'] is List
        ? data['data']
        : data;

    if (rawList is! List) {
      return [];
    }

    return rawList.whereType<Map>().map((tag) {
      return Map<String, dynamic>.from(tag);
    }).toList();
  }

  Future<void> _loadTags() async {
    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final response = await getTags();

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

    final tags = _extractTags(response['data']);

    setState(() {
      _tags = tags;
      _isLoading = false;
    });
  }

  Future<void> _handleCreateTag() async {
    final name = _tagNameController.text.trim();

    if (name.isEmpty) {
      CustomSnackbar.show(
        context: context,
        message: 'Ingresa un nombre para la nueva tag',
        type: SnackbarType.info,
      );
      return;
    }

    setState(() {
      _isCreating = true;
    });

    final response = await createTag(name);

    if (!mounted) {
      return;
    }

    setState(() {
      _isCreating = false;
    });

    if (response['error'] != null) {
      CustomSnackbar.show(
        context: context,
        message: response['error'],
        type: SnackbarType.error,
      );
      return;
    }

    _tagNameController.clear();
    CustomSnackbar.show(
      context: context,
      message: 'Tag creada correctamente',
      type: SnackbarType.success,
    );
    await _loadTags();
  }

  Future<void> _handleUpdateTag(Map<String, dynamic> tag) async {
    final id = (tag['id'] ?? '').toString();
    final currentName = (tag['name'] ?? '').toString();

    if (id.isEmpty) {
      CustomSnackbar.show(
        context: context,
        message: 'No se pudo identificar la tag',
        type: SnackbarType.error,
      );
      return;
    }

    final result = await ConfirmationDialog.show(
      context,
      title: 'Actualizar etiqueta',
      message: 'Modifica el nombre de la etiqueta seleccionada.',
      showNameField: true,
      initialName: currentName,
    );

    if (!mounted || result == null) {
      return;
    }

    final newName = (result['field_data']?['name'] ?? '').toString().trim();
    if (newName.isEmpty) {
      CustomSnackbar.show(
        context: context,
        message: 'El nombre de la tag no puede estar vacío',
        type: SnackbarType.info,
      );
      return;
    }

    final response = await updateTag(id, newName);

    if (!mounted) {
      return;
    }

    if (response['error'] != null) {
      CustomSnackbar.show(
        context: context,
        message: response['error'],
        type: SnackbarType.error,
      );
      return;
    }

    CustomSnackbar.show(
      context: context,
      message: 'Tag actualizada correctamente',
      type: SnackbarType.success,
    );
    await _loadTags();
  }

  Future<void> _handleDeleteTag(Map<String, dynamic> tag) async {
    final id = (tag['id'] ?? '').toString();
    final name = (tag['name'] ?? '').toString();

    if (id.isEmpty) {
      CustomSnackbar.show(
        context: context,
        message: 'No se pudo identificar la tag',
        type: SnackbarType.error,
      );
      return;
    }

    final result = await ConfirmationDialog.show(
      context,
      title: 'Eliminar etiqueta',
      message:
          '¿Seguro que deseas eliminar "${name.isEmpty ? 'esta etiqueta' : name}"? Esta acción no se puede deshacer.',
    );

    if (!mounted || result == null) {
      return;
    }

    final response = await deleteTag(id);

    if (!mounted) {
      return;
    }

    if (response['error'] != null) {
      CustomSnackbar.show(
        context: context,
        message: response['error'],
        type: SnackbarType.error,
      );
      return;
    }

    CustomSnackbar.show(
      context: context,
      message: 'Tag eliminada correctamente',
      type: SnackbarType.success,
    );
    await _loadTags();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTags = _filteredTags;

    if (_isLoading) {
      return const Center(child: CustomLoader(variant: LoaderVariant.light));
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ErrorMessage(
            errorLabel: 'Error al cargar etiquetas',
            description: _errorMessage!,
            onRetry: _loadTags,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadTags,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
        children: [
          CustomGroupCategory(
            category: 'Crear etiqueta',
            child: TagsCreateForm(
              controller: _tagNameController,
              onCreate: _handleCreateTag,
              isCreating: _isCreating,
            ),
          ),
          const SizedBox(height: 10),
          CustomGroupCategory(
            category: 'Todas las etiquetas',
            child: _tags.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        'No hay etiquetas registradas.',
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      TagsSearchPanel(
                        controller: _searchController,
                        onChanged: () => setState(() {}),
                        onClear: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 12),
                      if (filteredTags.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'No se encontraron etiquetas para la búsqueda.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        TagsGrid(
                          tags: filteredTags,
                          onUpdate: _handleUpdateTag,
                          onDelete: _handleDeleteTag,
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}