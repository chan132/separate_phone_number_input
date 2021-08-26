class ConvertUtil {
  /// convert phone number
  /// e.g.
  /// 13888888888 => 138 8888 8888
  /// 4000000000 => 400 000 0000
  static String convertPhoneNum(String value) {
    // 1. remove irregular spaces
    value = value.trim().replaceAll(" ", "");
    // 2. start convert
    String result = value;
    if (value.length == 7 || value.length == 8) {
      result = value.substring(0, 3) + " " + value.substring(3);
    } else if (value.length == 9 || value.length == 10) {
      result = value.substring(0, 3) +
          " " +
          value.substring(3, 6) +
          " " +
          value.substring(6);
    } else if (value.length == 11) {
      result = value.substring(0, 3) +
          " " +
          value.substring(3, 7) +
          " " +
          value.substring(7);
    }
    return result;
  }
}
