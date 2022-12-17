class EnvironmentConfig{
  static const String CONFIG_THEME_COLOR = String.fromEnvironment("CONFIG_THEME_COLOR",defaultValue: "COLOR_GREEN");
  static const String CONFIG_MOVIE_DETAIL_CASTS_LIST_LAYOUT = String.fromEnvironment("CONFIG_MOVIE_DETAIL_CASTS_LIST_LAYOUT",defaultValue: "LIST_VIEW");
  static const bool CONFIG_BANNER_CAROUSEL = bool.fromEnvironment("CONFIG_BANNER_CAROUSEL",defaultValue: true);

}



/// FLAVORS

/// Movie Booking Theme
/// flutter run --dart-define=CONFIG_THEME_COLOR=COLOR_GREEN --dart-define=CONFIG_MOVIE_DETAIL_CASTS_LIST_LAYOUT=LIST_VIEW --dart-define=CONFIG_BANNER_CAROUSEL=true



/// Movie Booking New Theme
/// flutter run --dart-define=CONFIG_THEME_COLOR=COLOR_RED --dart-define=CONFIG_MOVIE_DETAIL_CASTS_LIST_LAYOUT=GRID_VIEW --dart-define=CONFIG_BANNER_CAROUSEL=false
