class TaskPolicy {
  static int titlePolicy(String title) {
    if (title.isEmpty) {
      return -1;
    }

    return 0;
  }
}
