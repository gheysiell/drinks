class FormatFunctions {
  static String safeParseString(dynamic value) {
    return (value?.toString() ?? '');
  }

  static int safeParseInt(dynamic value) {
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
