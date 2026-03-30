import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  final String? label;
  final IconData icon;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;
  final String? hintText;
  final bool enabled;
  final VoidCallback? onTap;
  final bool iconOnly;

  const CustomDropdownButton({
    super.key,
    this.label,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,
    this.enabled = true,
    this.onTap,
    this.iconOnly = false,
  });

  @override
  State<CustomDropdownButton<T>> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.iconOnly) {
      return _buildIconOnlyDropdown();
    }
    return _buildLabeledDropdown();
  }

  Widget _buildIconOnlyDropdown() {
    Color iconColor = Theme.of(context).colorScheme.primary;

    return PopupMenuButton<T>(
      enabled: widget.enabled,
      onSelected: widget.onChanged,
      itemBuilder: (BuildContext context) => widget.items.map((item) {
        return PopupMenuItem<T>(
          value: item.value,
          child: item.child,
        );
      }).toList(),
      icon: Icon(
        widget.icon,
        color: iconColor,
        size: 24,
      ),
      color: Color(0xFF1c2b22),
    );
  }

  Widget _buildLabeledDropdown() {
    Color iconColor = Theme.of(context).iconTheme.color ?? Color(0xFF9eb7a8);
    Color primaryColor = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
            child: Text(
              widget.label!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: iconColor,
              width: 1.0,
            ),
          ),
          child: DropdownButtonFormField<T>(
            value: widget.value,
            items: widget.items,
            onChanged: widget.enabled ? widget.onChanged : null,
            hint: Text(
              widget.hintText ?? 'Selecciona una opción',
              style: TextStyle(color: iconColor),
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              prefixIcon: Icon(
                widget.icon,
                color: iconColor,
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: Color(0xFF1c2b22),
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            isExpanded: true,
            dropdownColor: Color(0xFF1c2b22),
            iconEnabledColor: primaryColor,
            iconDisabledColor: iconColor,
            disabledHint: Text(
              widget.hintText ?? 'Selecciona una opción',
              style: TextStyle(color: iconColor),
            ),
          ),
        ),
      ],
    );
  }
}
