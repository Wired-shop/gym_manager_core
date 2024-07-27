import 'package:gym_manager_backend/backend.dart';

class UsersFilter {
  bool hasPublicNote;
  bool hasPrivateNote;
  bool hasEmail;
  bool hasPhone;

  bool flagged;
  bool archived;
  bool tpPro;

  ValidationResult? validationResult;

  UsersFilter({
    this.hasEmail = false,
    this.hasPhone = true,
    this.hasPrivateNote = false,
    this.hasPublicNote = false,
    this.archived = false,
    this.flagged = false,
    this.tpPro = false,
    this.validationResult,
  });

  String toQueryParams() {
    String query = "";
    query += "${query.isEmpty ? '&' : ''}hasEmail=${hasEmail == true}";
    query += "&hasPhone=${hasPhone == true}";
    query += "&hasPrivateNote=${hasPrivateNote == true}";
    query += "&hasPublicNote=${hasPublicNote == true}";
    query += "&archived=${archived == true}";
    query += "&flagged=${flagged == true}";
    query += "&tpPro=${flagged == true}";
    query += "&tpPro=${flagged == true}";
    if (validationResult != null) {
      query += "&validationResponse=${validationResult?.response.name}";
      query +=
          "&validationResponseWarnings=${validationResult?.warnings.map((e) => e.name).toList().toString().replaceAll("[", "").replaceAll("]", "").trim()}";
    }
    return query;
  }
}
