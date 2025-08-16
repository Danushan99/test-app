import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:order3000_flutter/models/stock_model.dart';

class StockRepository {
  final String baseUrl = "https://www.cse.lk/api/";

  Future<Stock> fetchStock(String symbol) async {
    final url = Uri.parse(baseUrl + "companyInfoSummery");
    final response = await http.post(
      url,
      body: {"symbol": symbol},
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      },
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Stock.fromJson(data);
    } else {
      throw Exception("Failed to fetch stock data");
    }
  }
}
