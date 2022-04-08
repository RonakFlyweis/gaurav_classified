class DateFormatter {
  static dateToSlashedDate(DateTime date) {
    return '${date.day.toString()}/${date.month.toString()}/${date.year.toString()}';
  }
}
