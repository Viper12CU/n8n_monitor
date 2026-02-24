import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';

class CustomAccordion extends StatelessWidget {
  final List<AccordionSection> accordions;
  const CustomAccordion({super.key, required this.accordions});

  @override
  Widget build(BuildContext context) {
    return Accordion( 
      paddingBetweenClosedSections: 20,
      headerPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      headerBackgroundColor: Theme.of(context).cardTheme.color,
      headerBorderColorOpened: Color(0xFF27352d),
      headerBorderWidth: 2,
      contentBackgroundColor: Theme.of(context).cardTheme.color,
      contentBorderColor: Color(0xFF27352d),
      contentBorderWidth: 2,
      contentVerticalPadding: 20,
      scaleWhenAnimating: true,
      children: accordions );
  }
}