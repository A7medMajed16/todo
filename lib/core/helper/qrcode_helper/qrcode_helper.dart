class QrCodeHelper {
  static String convertQrToJson(String qrString) {
    // Remove the curly braces
    String content = qrString.trim().substring(1, qrString.length - 1);

    // Split by comma and space
    List<String> pairs = content.split(', ');

    // Convert each pair to proper JSON format
    List<String> jsonPairs = pairs.map((pair) {
      List<String> keyValue = pair.split(': ');
      String key = '"${keyValue[0]}"'; // Wrap key in quotes
      String value = keyValue[1];

      // If value is not a number, wrap it in quotes
      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        value = '"$value"';
      }

      return '$key: $value';
    }).toList();

    // Combine back into JSON format
    return '{${jsonPairs.join(', ')}}';
  }
}
