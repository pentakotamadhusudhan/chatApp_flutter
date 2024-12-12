import 'package:intl/intl.dart';

class StaticReepo {

  String ISTDateFormat(String? datetime) {
    if (datetime != null) {
      DateTime? now = DateTime.parse(datetime!);
      String formattedDate = DateFormat('dd-MMM-yyyy')
          .format(now.toUtc().add(const Duration(hours: 5, minutes: 30)));
      return formattedDate;
    } else {
      return "";
    }
  }
}
