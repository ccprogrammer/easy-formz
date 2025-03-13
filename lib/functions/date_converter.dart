String convertDate(String selectedValue) {
  if (selectedValue.isNotEmpty) {
    final DateTime dateTime = DateTime.parse(selectedValue);
    final String month = _getMonthName(dateTime.month);
    final String formattedDate = '$month ${dateTime.day}, ${dateTime.year}';
    return formattedDate;
  } else {
    return '';
  }
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}

DateTime? convertTime(String selectedValue) {
  if (selectedValue.isNotEmpty) {
    final List<String> parts = selectedValue.split(':');
    if (parts.length == 2) {
      final int hours = int.tryParse(parts[0]) ?? 0;
      final int minutes = int.tryParse(parts[1]) ?? 0;

      final int adjustedHours =
          (hours >= 1 && hours <= 12) ? hours : hours % 12;

      final DateTime dateTime = DateTime(1, 1, 1, adjustedHours, minutes);
      return dateTime;
    }
  }

  return null;
}
