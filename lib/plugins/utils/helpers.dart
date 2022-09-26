/// Allows for proper formatting of times
String cookTimeConverter(int cookTime) {
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
