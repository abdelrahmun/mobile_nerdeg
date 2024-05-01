const String defaultStringValue = '';
const int defaultIntValue = 0;
const double defaultDoubleValue = 0.0;
const bool defaultBoolValue = false;
final DateTime defaultDateTimeValue = DateTime.now();
const List<String> defaultListValue = [];

final Map<Type, dynamic> _defaultValues = {
  String: defaultStringValue,
  int: defaultIntValue,
  double: defaultDoubleValue,
  bool: defaultBoolValue,
  DateTime: defaultDateTimeValue,
  List: defaultListValue,
};

extension DefaultIfNull<T> on T? {
  T defaultIfNull() => this ?? _defaultValues[T]!;
}

extension JsonExtensions on Map<String, dynamic> {
  T value<T>(String key) {
    if (containsKey(key)) {
      if (T == double) {
        return (double.tryParse(this[key].toString()) ?? 0.0) as T;
      }
      return (this[key] as T?) ?? _defaultValues[T];
    }
    return _defaultValues[T];
  }
}
