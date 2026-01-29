import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Function() onTap;
  final bool isLoading;

  const CustomButton({super.key, required this.label, required this.icon, required this.onTap, this.isLoading = false});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.isLoading,
      child: GestureDetector(
        onTap: widget.onTap ,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFF184529),
                spreadRadius: 1,
                offset: Offset(0, 3),
                blurRadius: 10,
              ),
            ],
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(30.0),
          ),
          alignment: Alignment.center,
          width: 400,
          child: widget.isLoading ? _buildLoading()  : _buildButtonContent(),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: CustomLoader( variant: LoaderVariant.dark,),
    );
  }

  Padding _buildButtonContent() {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(widget.icon, color: Colors.black, weight: 1222),
          ],
        ),
      );
  }
}
