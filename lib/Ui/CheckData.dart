class CheckData {
  static String dNull(String namaEvent) {
    String data = namaEvent + " Tidak Boleh Kosong";
    return data;
  }

  static String dEmail() {
    String data = "Bukan Type Email";
    return data;
  }

  static String dMinimal(String namaEvent, int total) {
    String data = namaEvent + " Minimal $total Karakter";
    return data;
  }
}