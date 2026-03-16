import 'package:accordion/accordion_section.dart';
import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_accordion.dart';

class LastAuditTemplate extends StatefulWidget {
  final dynamic auditData;
  final String? title;
  const LastAuditTemplate({super.key, this.auditData, this.title});

  @override
  State<LastAuditTemplate> createState() => _LastAuditTemplateState();
}

class _LastAuditTemplateState extends State<LastAuditTemplate>
    with SingleTickerProviderStateMixin {
  List<AccordionSection> _buildAccordionSections() {
    if (widget.auditData == null) {
      return [];
    }

    final List<AccordionSection> sections = [];

    if (widget.auditData is Map<String, dynamic>) {
      final Map<String, dynamic> data =
          widget.auditData as Map<String, dynamic>;

      // Buscar la clave "Section" en el map
      final sectionData = data['sections'];

      if (sectionData != null && sectionData is List) {
        // Iterar sobre la lista de secciones
        for (int i = 0; i < sectionData.length; i++) {
          final section = sectionData[i];

          // Intentar obtener un título para el acordeón
          String headerTitle = section['title'];

          sections.add(
            AccordionSection(
              isOpen: i == 0,
              header: Text(
                headerTitle,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              content: Padding(
                padding: EdgeInsets.all(12.0),
                child: _buildContent(section),
              ),
            ),
          );
        }
      }
    }

    return sections;
  }

  Widget _buildContent(dynamic value) {
    if (value == null) {
      return Text('Sin datos', style: TextStyle(color: Colors.grey));
    }

    // Siempre esperamos un mapa con descripción y recomendación
    if (value is Map) {
      final Map<String, dynamic> data = value as Map<String, dynamic>;

      final description = data['description'];
      final recommendation = data['recommendation'];
      final location = data['location'];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Descripción
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Color(0xFF1c2b22),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF27352d)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Color(0xFF9eb7a8),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'DESCRIPCIÓN',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Color(0x99FFFFFF),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  description.toString(),
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // Recomendación
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Color(0xFF1c2b22),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF38e07b).withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: 16,
                      color: Color(0xFF38e07b),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'RECOMENDACIÓN',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Color(0xFF38e07b),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  recommendation.toString(),
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // Localización
          if (location != null && location is List && location.isNotEmpty)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF1c2b22),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF27352d)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Color(0xFF9eb7a8),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'LOCALIZACIÓN',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Color(0x99FFFFFF),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ...location.asMap().entries.map((entry) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: entry.key < location.length - 1 ? 12.0 : 0,
                      ),
                      child: _buildLocationItem(entry.value),
                    );
                  }).toList(),
                ],
              ),
            ),
        ],
      );
    }

    return Text(
      value.toString(),
      style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.9)),
    );
  }

  Widget _buildLocationItem(dynamic locationData) {
    if (locationData is! Map<String, dynamic>) {
      return Text(locationData.toString());
    }

    final kind = locationData['kind'];

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF122017),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF27352d).withOpacity(0.5)),
      ),
      child: _buildLocationContent(kind, locationData),
    );
  }

  Widget _buildLocationContent(String? kind, Map<String, dynamic> data) {
    switch (kind) {
      case 'credential':
        return _buildCredentialLocation(data);
      case 'node':
        return _buildNodeLocation(data);
      case 'community':
        return _buildCommunityLocation(data);
      default:
        return _buildGenericLocation(data);
    }
  }

  Widget _buildCredentialLocation(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLocationRow(
          icon: Icons.key,
          label: 'Credencial',
          value: data['name'] ?? 'Sin nombre',
        ),
        if (data['id'] != null) ...[
          SizedBox(height: 8),
          _buildLocationRow(
            icon: Icons.tag,
            label: 'ID',
            value: data['id'].toString(),
          ),
        ],
      ],
    );
  }

  Widget _buildNodeLocation(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLocationRow(
          icon: Icons.account_tree,
          label: 'Workflow',
          value: data['workflowName'] ?? 'Sin nombre',
        ),
        if (data['workflowId'] != null) ...[
          SizedBox(height: 8),
          _buildLocationRow(
            icon: Icons.tag,
            label: 'Workflow ID',
            value: data['workflowId'].toString(),
          ),
        ],
        if (data['nodeName'] != null) ...[
          SizedBox(height: 8),
          _buildLocationRow(
            icon: Icons.device_hub,
            label: 'Nodo',
            value: data['nodeName'].toString(),
          ),
        ],
        if (data['nodeType'] != null) ...[
          SizedBox(height: 8),
          _buildLocationRow(
            icon: Icons.code,
            label: 'Tipo',
            value: data['nodeType'].toString(),
            isMonospace: true,
          ),
        ],
      ],
    );
  }

  Widget _buildCommunityLocation(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLocationRow(
          icon: Icons.extension,
          label: 'Tipo de nodo',
          value: data['nodeType'] ?? 'Sin tipo',
          isMonospace: true,
        ),
        if (data['packageUrl'] != null) ...[
          SizedBox(height: 8),
          _buildLocationRow(
            icon: Icons.link,
            label: 'Package URL',
            value: data['packageUrl'].toString(),
            isMonospace: true,
          ),
        ],
      ],
    );
  }

  Widget _buildGenericLocation(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.entries
          .where((entry) => entry.key != 'kind')
          .map(
            (entry) => Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: _buildLocationRow(
                icon: Icons.info_outline,
                label: entry.key,
                value: entry.value.toString(),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildLocationRow({
    required IconData icon,
    required String label,
    required String value,
    bool isMonospace = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: Color(0xFF9eb7a8).withOpacity(0.7)),
            SizedBox(width: 8),
            Text(
              '$label: ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9eb7a8),
              ),
            ),
          ],
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.white.withOpacity(0.85),
              fontFamily: isMonospace ? 'monospace' : null,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final sections = _buildAccordionSections();

    if (sections.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No hay datos disponibles${widget.title != null ? " para ${widget.title}" : ""}',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      );
    }

    return CustomAccordion(accordions: sections);
  }
}
