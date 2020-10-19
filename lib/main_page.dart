import 'package:New_Spotify_Theme_Changer/theme_utility.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'spicetify_client.dart' as spicetify;
import 'theme_info.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scrollController = ScrollController();
  String currentTheme = themeNames.first;
  String currentHoveredTheme;

  @override
  void initState() {
    super.initState();
    setWindowSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Stack(children: [
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 250,
                child: _buildThemeList(context),
              ),
              Expanded(
                child: _buildThemePreview(context),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 4,
          right: 8,
          child: _applyButton(context),
        ),
      ]),
    );
  }

  Future<void> setWindowSize() async {
    Size size = Size(1080, 720);
    await DesktopWindow.setWindowSize(size);
    await DesktopWindow.setMaxWindowSize(size);
    await DesktopWindow.setMinWindowSize(size);
  }

  Widget _buildThemeList(BuildContext context) => Scrollbar(
        isAlwaysShown: true,
        controller: scrollController,
        child: ListView.builder(
            controller: scrollController,
            itemCount: themeNames.length,
            itemBuilder: (context, position) {
              String themeName = themeNames[position];

              bool isSelected = currentTheme == themeName;
              Color backgroundColor = Colors.green;
              if (isSelected) backgroundColor = Colors.greenAccent;

              return ListTile(
                dense: true,
                tileColor: backgroundColor,
                onTap: () {
                  setState(() {
                    if (currentTheme != themeName) currentTheme = themeName;
                  });
                },
                title: Text(themeNames[position]),
                autofocus: true,
              );
            }),
      );

  Widget _buildThemePreview(BuildContext context) => Image.asset(
        "assets/images/$currentTheme.png",
        fit: BoxFit.scaleDown,
      );

  Widget _applyButton(BuildContext context) => FlatButton(
        onPressed: () async {
          final progressDialog = ProgressDialog(
            context,
            type: ProgressDialogType.Normal,
            isDismissible: false,
          );
          progressDialog.style(
            message: "Applying theme...",
            progressWidget: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          );

          await progressDialog.show();
          await spicetify.applyTheme(ThemeInfo(name: currentTheme));
          await progressDialog.hide();

          final dialog = AlertDialog(
            title: Text(
              "$currentTheme theme applied",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
          showDialog(
            context: context,
            builder: (context) => dialog,
          );
        },
        child: Text("Apply theme"),
        color: Colors.green,
        visualDensity: VisualDensity.comfortable,
      );
}
