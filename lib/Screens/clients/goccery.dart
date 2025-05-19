import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroceryListPage extends StatefulWidget {
  final String token;
  final String selectedDate; // Format: 'yyyy-MM-dd'

  const GroceryListPage({
    Key? key,
    required this.token,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<GroceryListPage> createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  List<String> groceryItems = [];
  bool isLoading = true;
  String? errorMessage;

  Future<void> fetchGroceryList() async {
    try {
      final uri = Uri.parse(
          'http://10.0.2.2:3001/api/groceryList?date=${widget.selectedDate}');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          groceryItems = List<String>.from(data['groceryList']);
          isLoading = false;
        });
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          errorMessage = data['message'] ?? 'Failed to fetch grocery list';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGroceryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : groceryItems.isEmpty
          ? const Center(child: Text('No grocery items found'))
          : ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text(groceryItems[index]),
          );
        },
      ),
    );
  }
}
