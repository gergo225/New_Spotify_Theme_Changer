import 'dart:io';

import 'package:New_Spotify_Theme_Changer/theme_info.dart';
import 'package:process_run/shell.dart';
import 'package:path/path.dart' as path;

Future checkSpicetifyInstallation() async {
  if (!await spicetifyIsInstalled()) await installSpicetify();
}

Future<bool> spicetifyIsInstalled() async {
  Shell shell = Shell();

  try {
    await shell.run("spicetify --help");
  } catch (exception) {
    // When the command is not recognized (spicetify is not installed)
    // the shell throws a ShellException
    return false;
  }

  // If there are no errors, spicetify is installed
  return true;
}

Future installSpicetify() async {
  Shell shell = Shell();

  await shell.run(
      "powershell Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.ps1 | Invoke-Expression");
  await shell.run("spicetify");
  await shell.run("spicetify backup apply");
  await _moveThemesToSpicetify();
}

Future _moveThemesToSpicetify() async {
  String userprofilePath = Platform.environment["userprofile"];
  String spicetifyThemesPath =
      path.join(userprofilePath, ".spicetify", "Themes");

  String themesPath = path.join("assets", "themes");
  Directory sourceDirectory = Directory(themesPath);

  sourceDirectory.listSync().forEach((fileSystemEntity) {
    if (fileSystemEntity is Directory) {
      Directory directory = fileSystemEntity;
      String directoryName = path.basename(directory.path);
      String newDirectoryPath = path.join(spicetifyThemesPath, directoryName);
      Directory newDirectory = Directory(newDirectoryPath);
      newDirectory.createSync();

      directory.listSync().forEach((element) {
        if (element is File) {
          String fileName = path.basename(element.path);
          String newFilePath = path.join(newDirectoryPath, fileName);
          element.copySync(newFilePath);
        }
      });
    }
  });
}

Future applyTheme(ThemeInfo themeInfo) async {
  Shell shell = Shell();
  await shell.run(
      "spicetify config current_theme ${themeInfo.themeCode} color_scheme ${themeInfo.colorSchemeCode}");
  await shell.run("spicetify apply");
}
