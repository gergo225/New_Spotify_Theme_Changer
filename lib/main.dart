import 'package:New_Spotify_Theme_Changer/main_page.dart';
import 'package:flutter/material.dart';
import 'spicetify_client.dart' as spicetify;

void main() {
  spicetify.checkSpicetifyInstallation();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Theme Changer',
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
