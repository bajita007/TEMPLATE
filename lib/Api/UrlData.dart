class DataUrl {
  static const String homeUrl = "http://10.0.2.2:8000/api/";
  static const String detailOutlet = "${homeUrl}outlets-details/";
  static const String outletList = "${homeUrl}outlets";
  //
  static const String rekeningList = "${homeUrl}rekening";

  //payment

  static const String payDetails = "${homeUrl}payments-details/";
  static const String payOutlet = "${homeUrl}payments-outlet";
  static const String payAdd = "${homeUrl}payments-add";

  static const String payAllListAdmin = "${homeUrl}payments-outlet?admin=ADMIN";
}
