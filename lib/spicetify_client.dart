import 'package:process_run/shell.dart';

class SpicetifyClient {
  static Future checkSpicetifyInstallation() async {
    if (!await spicetifyIsInstalled()) await installSpicetify();
  }

  static Future<bool> spicetifyIsInstalled() async {
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

  static Future installSpicetify() async {
    Shell shell = Shell();

    await shell.run(
        "powershell Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.ps1 | Invoke-Expression");
    await shell.run("spicetify");
    await shell.run("spicetify backup apply");
  // TODO: Install (move to '%userprofile%/.spicetify/Themes') themes from 'assets/themes' folder
  }

  // TODO: Apply theme
}
