import 'package:flutter/material.dart';
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
    },
    {
      'icon': const Icon(Icons.cancel, color: Color(0xFFfbbf24)),
      'label': 'Cancelado',
    },
    {
      'icon': const Icon(Icons.error, color: Color(0xFFef4444)),
      'label': 'Error',
    },
    {
      'icon': const Icon(Icons.refresh, color: Color(0xFF3b82f6)),
      'label': 'En ejecución',
    },
    {
      'icon': const Icon(Icons.check_circle, color: Color(0xFF38e07b)),
      'label': 'Éxito',
    },
    {
      'icon': const Icon(Icons.schedule, color: Color(0xFF94a3b8)),
      'label': 'Esperando',
    },
  ];

  int activeIndex = 0;

  void handleFilterPress(int index) {
    if (index != activeIndex) {
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
