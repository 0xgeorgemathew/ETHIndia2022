class RoutesValidator {
  static final RoutesValidator _instance = RoutesValidator._internal();

  factory RoutesValidator() {
    return _instance;
  }

  RoutesValidator._internal();

  bool validateRoute(String route) {
    // TODO Validate the routes according to the needs of page
    return true;
  }
}
