class UsersFilter {
  bool hasPublicNote;
  bool hasPrivateNote;
  bool hasEmail;
  bool hasPhone;

  bool flagged;
  bool archived;
  bool tpPro;

  UsersFilter(
      {this.hasEmail = false,
      this.hasPhone = true,
      this.hasPrivateNote = false,
      this.hasPublicNote = false,
      this.archived = false,
      this.flagged = false,
      this.tpPro = false});

  String toQueryParams() {
    String query = "";
    query += "${query.isEmpty ? '&' : ''}hasEmail=${hasEmail == true}";
    query += "&hasPhone=${hasPhone == true}";
    query += "&hasPrivateNote=${hasPrivateNote == true}";
    query += "&hasPublicNote=${hasPublicNote == true}";
    query += "&archived=${archived == true}";
    query += "&flagged=${flagged == true}";
    query += "&tpPro=${flagged == true}";
    return query;
  }
}
