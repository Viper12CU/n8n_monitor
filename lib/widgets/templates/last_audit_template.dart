import 'package:accordion/accordion_section.dart';
import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_accordion.dart';

class LastAuditTemplate extends StatefulWidget {
  const LastAuditTemplate({super.key});

  @override
  State<LastAuditTemplate> createState() => _LastAuditTemplateState();
}

class _LastAuditTemplateState extends State<LastAuditTemplate>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: CustomAccordion(
        accordions: [
          AccordionSection(
            header: Text("Hola"),
            content: Center(child: Text("Contenido")),
          ),
          AccordionSection(
            header: Text("Hola"),
            content: Center(child: Text("Contenido")),
          ),
          AccordionSection(
            header: Text("Hola"),
            content: Center(child: Text("Contenido")),
          ),
        ],
      ),
    );
  }
}
