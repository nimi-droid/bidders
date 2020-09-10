extension StringExtension on String {
  String get orEmpty {
    if (this != null)
      return this;
    else
      return '';
  }

  bool get isNotNullOrEmpty {
    if (this != null && isNotEmpty) {
      return true;
    }
    return false;
  }

  bool get isNullOrEmpty {
    if (this == null || isEmpty) {
      return true;
    }
    return false;
  }
}
