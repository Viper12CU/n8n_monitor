import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/services/local_storage.dart';

class WorkflowFilterProvider extends ChangeNotifier {
  WorkflowFilterType _currentFilter = WorkflowFilterType.all;

  WorkflowFilterProvider() {
    _loadSavedFilter();
  }

  WorkflowFilterType get currentFilter => _currentFilter;

  /// Carga el filtro guardado desde localStorage
  void _loadSavedFilter() {
    final savedFilter = LocalStorage.workflowFilter;
    if (savedFilter != null) {
      switch (savedFilter) {
        case 'all':
          _currentFilter = WorkflowFilterType.all;
          break;
        case 'active':
          _currentFilter = WorkflowFilterType.active;
          break;
        case 'inactive':
          _currentFilter = WorkflowFilterType.inactive;
          break;
      }
      notifyListeners();
    }
  }

  void setFilter(WorkflowFilterType filter) {
    if (_currentFilter != filter) {
      _currentFilter = filter;
      
      // Guardar el filtro en localStorage
      final filterString = filter.toString().split('.').last;
      LocalStorage.setWorkflowFilter(filterString);
      
      notifyListeners();
    }
  }

  String get currentFilterLabel {
    switch (_currentFilter) {
      case WorkflowFilterType.all:
        return 'Todos';
      case WorkflowFilterType.active:
        return 'Activos';
      case WorkflowFilterType.inactive:
        return 'Inactivos';
    }
  }

  /// Filtra una lista de workflows según el filtro actual
  List<dynamic> filterWorkflows(List<dynamic> workflows) {
    switch (_currentFilter) {
      case WorkflowFilterType.all:
        return workflows;
      case WorkflowFilterType.active:
        return workflows.where((workflow) => workflow['active'] == true).toList();
      case WorkflowFilterType.inactive:
        return workflows.where((workflow) => workflow['active'] != true).toList();
    }
  }
}
