import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/filter_button.dart';

class WorkflowsFilter extends StatefulWidget {
  const WorkflowsFilter({super.key});

  @override
  State<WorkflowsFilter> createState() => _WorkflowsFilterState();
}

class _WorkflowsFilterState extends State<WorkflowsFilter> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  
  List<Map<String, dynamic>> filters = [
    {
      'icon': const Icon(Icons.grid_view_rounded, color:   Colors.white,),
      'label': 'Todos',
    },
    {
      'icon': const Icon(Icons.play_circle_fill, color:  Color(0xFF38e07b),),
      'label': 'Activos',
    },
    {
      'icon': const Icon(Icons.pause_circle_filled, color:  Color(0xFF94a3b8)),
      'label': 'Inactivos',
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