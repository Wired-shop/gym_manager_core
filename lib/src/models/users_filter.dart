import 'package:gym_manager_backend/backend.dart';

class UsersFilter {
  bool hasPublicNote;
  bool hasPrivateNote;
  bool hasEmail;
  bool hasPhone;

  bool flagged;
  bool archived;
  bool tpPro;

  List<ValidationResponseWarnings> validationResponseWarnings;

  UsersFilter({
    this.hasEmail = false,
    this.hasPhone = false,
    this.hasPrivateNote = false,
    this.hasPublicNote = false,
    this.archived = false,
    this.flagged = false,
    this.tpPro = false,
    this.validationResponseWarnings = const [],
  });

  String toQueryParams() {
    String query = "";
    query += "${query.isNotEmpty ? '&' : ''}hasEmail=${hasEmail == true}";
    query += "&hasPhone=${hasPhone == true}";
    query += "&hasPrivateNote=${hasPrivateNote == true}";
    query += "&hasPublicNote=${hasPublicNote == true}";
    query += "&archived=${archived == true}";
    query += "&flagged=${flagged == true}";
    query += "&tpPro=${flagged == true}";
    query += "&tpPro=${flagged == true}";
    query +=
        "&validationResponseWarnings=${validationResponseWarnings.toString().replaceAll('[', '').replaceAll(']', '').trim()}";
    return query;
  }
}
