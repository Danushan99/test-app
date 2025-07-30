import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/email.dart';

class EmailRepository {
  final String baseUrl;

  EmailRepository({required this.baseUrl});

  Future<List<Email>> fetchEmails() async {
    final response = await http.get(Uri.parse('$baseUrl/emails'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Email.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load emails');
    }
  }

  Future<void> sendEmail(String to, String subject, String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/send'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'to': to, 'subject': subject, 'message': message}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send email');
    }
  }
}
