import 'package:New_Spotify_Theme_Changer/code_utility.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("code utility test", () {
    group("theme has color scheme", () {
      test("should return correct code for theme", () {
        String result = getThemeCode("Elementary - Blue Contrast");
        expect(result, "Elementary");
      });
      test("should return correct code for color scheme", () {
        String result = getColorSchemeCode("Elementary - Blue Contrast");
        expect(result, "BlueContrast");
      });
    });

    group("theme has no color scheme", () {
      test("should return correct code for theme", () {
        String result = getThemeCode("Burnt Sienna");
        expect(result, "BurntSienna");
      });
      test("should return correct code for color scheme", () {
        String result = getColorSchemeCode("Burnt Sienna");
        expect(result, "base");
      });
    });
  });
}
