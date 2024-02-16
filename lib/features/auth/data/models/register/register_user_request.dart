class RegisterUserRequest {
  RegisterUserRequest({
    required this.clientName, required this.bloodGroup, this.userId,
    this.cleintLastname,
    this.phoneNumber,
    this.pasport,
    this.adres,
    this.fcmToken,
    this.cleintLang,
    this.tableSlug,
  });

  RegisterUserRequest.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"];
    clientName = json["client_name"];
    cleintLastname = json["cleint_lastname"];
    phoneNumber = json["phone_number"];
    pasport = json["pasport"];
    bloodGroup = json["blood_group"];
    adres = json["adres"];
    fcmToken = json["fcm_token"];
    cleintLang = json["cleint_lang"];
    tableSlug = json["table_slug"];
  }

  num? userId;
  String? clientName;
  String? cleintLastname;
  String? phoneNumber;
  String? pasport;
  String? bloodGroup;
  String? adres;
  String? fcmToken;
  String? cleintLang;
  String? tableSlug;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map["user_id"] = userId;
    map["client_name"] = clientName;
    map["cleint_lastname"] = cleintLastname;
    map["phone_number"] = phoneNumber;
    map["pasport"] = pasport;
    map["blood_group"] = bloodGroup;
    map["adres"] = adres;
    map["fcm_token"] = fcmToken;
    map["cleint_lang"] = cleintLang;
    map["table_slug"] = "clients";
    return map;
  }
}
