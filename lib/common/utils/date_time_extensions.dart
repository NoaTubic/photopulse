import 'package:photopulse/common/constants/duration_constants.dart';
import 'package:photopulse/generated/l10n.dart';

extension DateTimeExtensions on DateTime {
  bool get isToday => (DateTime(year, month, day).compareTo(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      )) ==
      0);

  Duration get timePassed => Duration(
        milliseconds:
            DateTime.now().millisecondsSinceEpoch - millisecondsSinceEpoch,
      );

  double get weeksPassed => timePassed.inDays / DurationConstants.daysInWeek;

  int get monthsPassed => DateTime.now().month >= month
      ? DateTime.now().month - month
      : DateTime.now().month + (DurationConstants.monthsInYear - month);

  int get yearsPassed => DateTime.now().year - year;

  String get postLabel {
    if (timePassed.inSeconds <= DurationConstants.secondsInMinute) {
      return '1 min ago';
    } else if (timePassed.inMinutes < DurationConstants.minutesInHour) {
      return '${timePassed.inMinutes} ${S.current.minutes_abbreviation}';
    } else if (timePassed.inHours < DurationConstants.hoursInDay) {
      return '${timePassed.inHours} ${S.current.hours_abbreviation}';
    } else if (timePassed.inHours < DurationConstants.daysInWeek * 24) {
      return '${(timePassed.inHours / 24).ceil()} ${S.current.day_abbreviation}';
    } else if (weeksPassed < DurationConstants.weeksInYear) {
      if (monthsPassed == 0) {
        return '${weeksPassed.round()} ${S.current.week_abbreviation}';
      } else {
        final suffix = monthsPassed > 1 ? S.current.months : S.current.month;
        return '$monthsPassed $suffix';
      }
    } else {
      final suffix = yearsPassed.round() > 1 ? S.current.years : S.current.year;
      return '${yearsPassed.round()}$suffix';
    }
  }
}
