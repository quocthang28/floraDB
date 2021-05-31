import 'package:timeago/timeago.dart' as timeAgo;
import 'package:intl/intl.dart';

enum FormatType { DATE, TIME, DATE_TIME, DATE_MONTH, MONTH_YEAR, CODE }

String? getTimeAgo(String? datetime) {
  if (datetime == null) {
    return null;
  }
  if (DateTime.parse(datetime).isAfter(DateTime.now())) return null;
  if (DateTime.now().difference(DateTime.parse(datetime)).inDays > 7)
    return getDisplayDateTime(DateTime.now());
  final fifteenAgo = DateTime.parse(datetime);
  timeAgo.setLocaleMessages('vi', timeAgo.ViMessages());
  return timeAgo.format(fifteenAgo, locale: 'vi');
}

String getDisplayDateTime(dynamic dateTime,
    {FormatType type = FormatType.DATE}) {
  if (dateTime == '' || dateTime == null) return '';
  DateTime dt = (dateTime is DateTime) ? dateTime : DateTime.parse(dateTime);

  switch (type) {
    case FormatType.DATE:
      return DateFormat('dd/MM/yyyy').format(dt);
    case FormatType.TIME:
      return DateFormat.Hm().format(dt);
    case FormatType.DATE_TIME:
      return DateFormat('HH:mm dd-MM-yyyy').format(dt);
    case FormatType.DATE_MONTH:
      return DateFormat('d, MMMM', 'vi').format(dt);
    case FormatType.MONTH_YEAR:
      return DateFormat('MMMM, yyyy', 'vi').format(dt);
    case FormatType.CODE:
      return DateFormat('ddMMyyyy', 'vi').format(dt);
    default:
      return DateFormat('HH:mm dd-MM-yyyy').format(dt);
  }
}
