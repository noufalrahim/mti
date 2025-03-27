class DateUtilsHelper {
  static String getAgeFormatted(DateTime dob) {
    final DateTime now = DateTime.now();
    final int yearsDiff = now.year - dob.year;
    final int monthsDiff = now.month - dob.month;
    final int totalMonths = (yearsDiff * 12) + monthsDiff;

    if (totalMonths < 24) {
      return "$totalMonths months";
    } else {
      int years = totalMonths ~/ 12;
      int months = totalMonths % 12;
      return months == 0 ? "$years years" : "$years years and $months months";
    }
  }
}
