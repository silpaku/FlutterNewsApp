import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search News'),
        actions: [
          IconButton(
            icon: Icon(
              themeModel.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeModel.toggleTheme();
            },
          ),
        ],
      ),
      // Rest of your search screen UI
    );
  }
}
