import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Fitness App'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            // title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [HomePage(), HomePage(), HomePage()],
          ),
        ),
      ),
    );
  }
}
