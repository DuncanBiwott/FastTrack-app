import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchPage extends StatelessWidget {
  final List<String> suggestions = [
    'Apple',
    'Banana',
    'Orange',
    'Pineapple',
    'Mango',
    'Grapes',
  ];

   SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TypeAheadField(
          textFieldConfiguration: const TextFieldConfiguration(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search...',
            ),
          ),
          suggestionsCallback: (pattern) async {
            return suggestions.where((item) =>
                item.toLowerCase().contains(pattern.toLowerCase()));
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) {
            // Handle suggestion selection
            // Add your logic here
          },
        ),
      ),
    );
  }
}