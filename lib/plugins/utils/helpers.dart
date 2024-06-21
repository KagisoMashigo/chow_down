class StringHelper {
  /// Allows for proper formatting of times
  static String cookTimeConverter(int cookTime) {
    final duration = Duration(minutes: cookTime);
    List<String> timeParts = duration.toString().split(':');
    final hours = timeParts[1] == '00'
        ? '${timeParts[0].padLeft(2, '')} hrs'
        : '${timeParts[0].padLeft(2, '')} hrs ${timeParts[1].padLeft(2, '0')} mins';

    final minutes = timeParts[1].startsWith('0')
        ? '${timeParts[1].padLeft(2, '').split('0')[1]} mins'
        : '${timeParts[1].padLeft(0, '')} mins';

    final hour = '${timeParts[0].padLeft(2, '')} hour';

    final oneHourAndMins =
        '${timeParts[0].padLeft(2, '')} hr ${timeParts[1].padLeft(2, '0')} mins';

    if (cookTime < 120 && cookTime > 60) {
      return oneHourAndMins;
    }

    if (cookTime == 60) {
      return hour;
    }

    if (cookTime >= 120) {
      return hours;
    }

    return minutes;
  }

  static String urlValidator(String url) {
    if (url.isEmpty) {
      return '';
    }

    if (url.startsWith('https://')) {
      return url;
    }
    if (url.startsWith('http://')) {
      return url.replaceFirst('http://', 'https://');
    }

    return 'https://$url';
  }

  static bool isUrlValid(String? url) {
    final validatedUrl = urlValidator(url!);

    if (validatedUrl.isEmpty) {
      return false;
    }
    if (!Uri.parse(validatedUrl).isAbsolute) {
      return false;
    }

    return true;
  }

  static String generateCustomId(String title) {
    // Remove special characters and trim spaces
    final cleanedTitle = title.replaceAll(RegExp(r"[^\s\w]"), '').trim();

    // Generate a unique hash code for the cleaned title
    final hashCode = cleanedTitle.hashCode;

    // Combine the cleaned title and hash code to create a unique ID
    final uniqueId = '$cleanedTitle-$hashCode';

    return uniqueId;
  }
}
