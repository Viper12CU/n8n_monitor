import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/services/local_storage.dart';

class ExecutionFilterProvider extends ChangeNotifier {
  ExecutionFilterType _currentFilter = ExecutionFilterType.all;

  ExecutionFilterProvider() {
    _loadSavedFilter();
  }

  ExecutionFilterType get currentFilter => _currentFilter;

  /// Carga el filtro guardado desde localStorage
  void _loadSavedFilter() {
    final savedFilter = LocalStorage.executionFilter;
    if (savedFilter != null) {
      switch (savedFilter) {
        case 'all':
          _currentFilter = ExecutionFilterType.all;
          break;
        case 'canceled':
          _currentFilter = ExecutionFilterType.canceled;
          break;
        case 'error':
          _currentFilter = ExecutionFilterType.error;
          break;
        case 'running':
          _currentFilter = ExecutionFilterType.running;
          break;
        case 'success':
          _currentFilter = ExecutionFilterType.success;
          break;
        case 'waiting':
          _currentFilter = ExecutionFilterType.waiting;
          break;
      }
      notifyListeners();
    }
  }

  void setFilter(ExecutionFilterType filter) {
    if (_currentFilter != filter) {
      _currentFilter = filter;
      
      // Guardar el filtro en localStorage
      final filterString = filter.toString().split('.').last;
      LocalStorage.setExecutionFilter(filterString);
      
      notifyListeners();
    }
  }

  String get currentFilterLabel {
    switch (_currentFilter) {
      case ExecutionFilterType.all:
        return 'Todos';
      case ExecutionFilterType.canceled:
        return 'Cancelado';
      case ExecutionFilterType.error:
        return 'Error';
      case ExecutionFilterType.running:
        return 'En ejecución';
      case ExecutionFilterType.success:
        return 'Éxito';
      case ExecutionFilterType.waiting:
        return 'Esperando';
    }
  }

  /// Filtra una lista de ejecuciones según el filtro actual
  List<Map<String, dynamic>> filterExecutions(List<Map<String, dynamic>> executions) {
    switch (_currentFilter) {
      case ExecutionFilterType.all:
        return executions;
      case ExecutionFilterType.canceled:
        return executions.where((execution) => execution['status']?.toLowerCase() == 'canceled').toList();
      case ExecutionFilterType.error:
        return executions.where((execution) => execution['status']?.toLowerCase() == 'error').toList();
      case ExecutionFilterType.running:
        return executions.where((execution) => execution['status']?.toLowerCase() == 'running').toList();
      case ExecutionFilterType.success:
        return executions.where((execution) => execution['status']?.toLowerCase() == 'success').toList();
      case ExecutionFilterType.waiting:
        return executions.where((execution) => execution['status']?.toLowerCase() == 'waiting').toList();
    }
  }
}
