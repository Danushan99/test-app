import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:order3000_flutter/models/trade_summary_model.dart';

class TradeSummaryRepository {
  final String apiUrl = "https://www.cse.lk/api/tradeSummary";

  Future<List<TradeSummary>> fetchTradeSummary() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({}), // if API expects an empty object\
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      final List<dynamic> summaryList = jsonMap['reqTradeSummery'] ?? [];
      return summaryList.map((e) => TradeSummary.fromJson(e)).toList();
    } else {
      throw Exception(
          'Failed to load trade summary: ${response.statusCode} ${response.body}');
    }
  }
}
