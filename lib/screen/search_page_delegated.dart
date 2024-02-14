import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  final Widget searchPage; // Store the search page as a final property

  // Constructor to receive the search page widget
  MySearchDelegate({required this.searchPage});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showResults(context); // Update results when query is cleared
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null); // Navigate back to the previous page
      },
      child: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Clear any previous results
    List results = [];

    // Perform search logic based on `query`
    // Replace this with your actual search implementation
    if (query.isNotEmpty) {
      results.add(Text('Search results for: "$query"'));
    } else {
      results.add(Text('Enter a search term'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => ListTile(
        title: results[index],
        onTap: () {
          // Handle individual item selection (optional)
          // Here, we navigate to the search page with search query in arguments
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => searchPage,
              settings: RouteSettings(arguments: query), // Pass search query
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions based on `query`
    // Replace this with your actual suggestion logic
    return ListView.builder(
      itemCount: 5, // Provide some suggestions even for empty query
      itemBuilder: (context, index) => ListTile(
        title: Text('Suggestion $index'),
        onTap: () {
          query = 'Suggestion $index';
          showResults(context); // Update results when suggestion is tapped
        },
      ),
    );
  }
}
