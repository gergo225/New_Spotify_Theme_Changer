/// Get the code which to apply when calling 'spicetify current_theme {code}'
String getThemeCode(String themeName) =>
    themeName.replaceAll(" ", "").split("-")[0];

/// Get the code for the color scheme which to apply when calling 'spicetify color_scheme {code}'
String getColorSchemeCode(String themeName) => themeName.contains("-")
    ? themeName.replaceAll(" ", "").split("-")[1]
    : "base";
