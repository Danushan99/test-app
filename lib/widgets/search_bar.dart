import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

final Map<String, String> companyCodeMap = {
  "ABANS ELECTRICALS PLC": "ABAN.N0000",
  "ABANS FINANCE PLC": "AFSL.N0000",
  "ACCESS ENGINEERING PLC": "AEL.N0000",
  "ACL CABLES PLC": "ACL.N0000",
  "ACL PLASTICS PLC": "APLA.N0000",
  "ACME PRINTING & PACKAGING PLC": "ACME.N0000",
};

class StockSearchWidget extends StatelessWidget {
  final TextEditingController controller;

  const StockSearchWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      constraints: BoxConstraints.tight(const Size(double.infinity, 200)),
      controller: controller,
      suggestionsCallback: (pattern) {
        return companyCodeMap.keys
            .where((company) =>
                company.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
          subtitle: Text(companyCodeMap[suggestion]!),
        );
      },
      onSelected: (suggestion) {
        controller.text = companyCodeMap[suggestion]!;
        print("Selected company code: ${companyCodeMap[suggestion]}");
      },
      emptyBuilder: (context) => const ListTile(
        title: Text('No companies found'),
      ),
      builder: (context, textController, focusNode) {
        return TextField(
          controller: textController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            labelText: 'Enter Company Name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
        );
      },
    );
  }
}
