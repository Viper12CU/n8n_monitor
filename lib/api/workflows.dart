import 'dart:convert';

import 'package:n8n_monitor/api/http_client.dart';


Future<Map<String, dynamic>?> getWorkflowById(String id) async {
	final response = await HttpClient().get('workflows/$id');

	if (response.statusCode == 200) {
		return jsonDecode(response.body) as Map<String, dynamic>;
	}

	if (response.statusCode == 404) return null;

	throw Exception('Error al obtener workflow: ${response.statusCode} - ${response.body}');
}


Future<Map<String, dynamic>?> getWorkflow() async {
	final response = await HttpClient().get('workflows');

	if (response.statusCode == 200) {
		return jsonDecode(response.body) as Map<String, dynamic>;
	}

	if (response.statusCode == 404) return null;

	throw Exception('Error al obtener los workflows: ${response.statusCode} - ${response.body}');
}


Future<int> getTotalWorkflow() async {
  final response = await getWorkflow();

  if (response != null && response.isNotEmpty) {
    return response['data'].length;
  }

  return 0;
}

Future<int> getTotalActiveWorkflow() async {
  final response = await getWorkflow();
  int activeCount = 0;

  if (response != null && response.isNotEmpty) {
    for (var workflow in response['data']) {
      if (workflow['active'] == true) {
        activeCount++;
      }
    }
  }

  return activeCount;
}