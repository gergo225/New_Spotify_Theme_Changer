import 'package:New_Spotify_Theme_Changer/code_utility.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ThemeInfo extends Equatable {
  final String name;
  
  ThemeInfo({@required this.name});

  String get themeCode => getThemeCode(this.name);
  String get colorSchemeCode => getColorSchemeCode(this.name);

  @override
  List<Object> get props => [name];
}