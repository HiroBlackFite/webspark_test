extension StringUtils on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }

    return '${this[0].toUpperCase()}${substring(1)}';
  }

  removeTrailingZeros() {
    if (contains('.')) {
      return replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');
    } else {
      return this;
    }
  }
}
