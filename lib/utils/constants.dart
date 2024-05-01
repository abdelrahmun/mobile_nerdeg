import 'package:intl/intl.dart';

class Constants {
  /// Base
  static const appName = 'Bazaara App';
  static const baseUrl = 'https://loopemarketplace.com/api/v1';

  static bool isRTL = false;
  static const int splashDuration = 2;
  static const paginationFixedInPage = 10;

  static const String fontFamily = 'ar';
  static const String arabicLocale = 'ar';
  static const String englishLocale = 'en';

  static const String simpleDateFormat = 'd.MM.yy';
  static const String dashedDateFormat = 'yyyy-MM-dd';
  static NumberFormat priceFormat = NumberFormat('#,##0.00');
  static NumberFormat priceTotalFormat = NumberFormat('#,##0');
}
