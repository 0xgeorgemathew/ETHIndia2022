part of './app_pages.dart';

abstract class Routes {
  Routes._();

  static const String splash = '/splash';

  // Nested navigation
  static const String invoiceHome = '/invoice-home';
  static const String invoiceEntries = '/invoice-entries';
  static const String invoiceUpload = '/invoice-upload';
}
