class SearchPolicy {
  static int searchTextPolicy(String value) {
    if (value.trim().isNotEmpty && value.trim().length >= 3) {
      return 0;
    }
    return -1;
  }
}
