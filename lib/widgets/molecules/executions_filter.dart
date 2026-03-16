import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:n8n_monitor/provider/execution_filter_provider.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/filter_button.dart';

class ExecutionsFilter extends StatefulWidget {
  const ExecutionsFilter({super.key});

  @override
  State<ExecutionsFilter> createState() => _ExecutionsFilterState();
}

class _ExecutionsFilterState extends State<ExecutionsFilter> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  
  List<Map<String, dynamic>> filters = [
    {
      'icon': const Icon(Icons.grid_view_rounded, color: Colors.white),
      'label': 'Todos',
      'type': ExecutionFilterType.all,
    },
    {
      'icon': const Icon(Icons.cancel, color: Color(0xFFfbbf24)),
      'label': 'Cancelado',
      'type': ExecutionFilterType.canceled,
    },
    {
      'icon': const Icon(Icons.error, color: Color(0xFFef4444)),
      'label': 'Error',
      'type': ExecutionFilterType.error,
    },
    {
      'icon': const Icon(Icons.refresh, color: Color(0xFF3b82f6)),
      'label': 'En ejecución',
      'type': ExecutionFilterType.running,
    },
    {
      'icon': const Icon(Icons.check_circle, color: Color(0xFF38e07b)),
      'label': 'Éxito',
      'type': ExecutionFilterType.success,
    },
    {
      'icon': const Icon(Icons.schedule, color: Color(0xFF94a3b8)),
      'label': 'Esperando',
      'type': ExecutionFilterType.waiting,
    },
  ];

  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    // Sincronizar el activeIndex con el filtro actual del provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final filterProvider = Provider.of<ExecutionFilterProvider>(context, listen: false);
      final currentFilter = filterProvider.currentFilter;
      
      // Buscar el índice del filtro actual en la lista
      final index = filters.indexWhere((filter) => filter['type'] == currentFilter);
      
      if (index != -1 && index != activeIndex) {
        setState(() {
          // Reorganizar la lista para que el filtro activo esté en la posición 0
          final selectedFilter = filters[index];
          filters.removeAt(index);
          filters.insert(0, selectedFilter);
          activeIndex = 0;
        });
      }
    });
  }

  void handleFilterPress(int index) {
    if (index != activeIndex) {
      final filterProvider = Provider.of<ExecutionFilterProvider>(context, listen: false);
      final selectedFilter = filters[index];
      
      // Actualizar el provider con el nuevo filtro
      filterProvider.setFilter(selectedFilter['type']);
      
      setState(() {
        final selectedFilter = filters[index];
        
        // Remover con animación
        _listKey.currentState?.removeItem(
          index,
          (context, animation) => _buildFilterItem(selectedFilter, index, animation),
          duration: const Duration(milliseconds: 300),
        );
        
        // Actualizar la lista
        filters.removeAt(index);
        filters.insert(0, selectedFilter);
        
        // Insertar con animación
        _listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 300));
        
        activeIndex = 0;
      });
    }
  }

  Widget _buildFilterItem(Map<String, dynamic> filter, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.horizontal,
      child: SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(-0.5, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: FadeTransition(
          opacity: animation,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: FilterButton(
              isActive: index == activeIndex,
              onPressed: () => handleFilterPress(index),
              icon: filter['icon'],
              label: filter['label'],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 20.0),
          SizedBox(
            height: 50,
            child: AnimatedList(
              key: _listKey,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              initialItemCount: filters.length,
              itemBuilder: (context, index, animation) {
                return _buildFilterItem(filters[index], index, animation);
              },
            ),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
    );
  }
}
