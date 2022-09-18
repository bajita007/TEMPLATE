class DataUrl {
  static const String homeUrl = "http://10.0.2.2:8000/api/";
  static const String detailOutlet = "${homeUrl}outlets-details/";
  static const String outletList = "${homeUrl}outlets";
  //
  static const String rekeningList = "${homeUrl}rekening";
  static const String rekeningAdd= "${homeUrl}rekening/add";
  static const String rekeningDel = "${homeUrl}rekening/delete";

  //payment

  static const String payDetails = "${homeUrl}payments-details/";
  static const String payOutlet = "${homeUrl}payments-outlet";
  static const String payAdd = "${homeUrl}payments-add";
  static const String payAdminUp = "${homeUrl}payments-update";

  static const String payAllListAdmin = "${homeUrl}payments-outlet?admin=ADMIN";

  //pengguna-details
  static const String adminDetails = "${homeUrl}pengguna-details";

  //upload-gambar
  static const String tambahDetailsPay = "${homeUrl}payments-details/data-details";

}
