import 'package:chow_down/plugins/utils/constants.dart';

class StringHelper {
  /// Allows for proper formatting of times
  static String cookTimeConverter(int cookTime) {
    final duration = Duration(minutes: cookTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (cookTime < 60) {
      return '$minutes mins';
    } else if (cookTime == 60) {
      return '1 hour';
    } else if (cookTime < 120) {
      return '$hours hr $minutes mins';
    } else {
      return '$hours hrs ${minutes.toString().padLeft(2, '0')} mins';
    }
  }

  static bool isUrlValid(String? url) {
    if (url == null) {
      return false;
    }

    return RegExp(URL_REGEX).hasMatch(url);
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
