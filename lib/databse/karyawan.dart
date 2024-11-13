import 'package:tes_flutter_wireles/models/karyawan.dart';

class KaryawanDatabase {
  List<Karyawan> karyawanData = [];

//Metode untuk mengambil data karyawan by id
  Karyawan? getKaryawanById(int id) {
    final index =
        karyawanData.indexWhere((karyawan) => karyawan.idKaryawan == id);
    return index != -1 ? karyawanData[index] : null;
  }

  // Metode untuk menambah karyawan
  void tambahKaryawan(Karyawan karyawan) {
    print('sampai sini');
    karyawanData.add(karyawan);
  }

  // Metode untuk menghapus karyawan

  void hapusKaryawan(Karyawan karyawan) {
    karyawanData.remove(karyawan);
  }

  // Metode untuk mengupdate karyawan
  void updateKaryawan(Karyawan karyawanLama, Karyawan karyawanBaru) {
    print(karyawanLama);

    int index = karyawanData.indexOf(karyawanLama);
    if (index != -1) {
      karyawanData[index] = karyawanBaru;
    }
  }

  // Metode untuk mendapatkan semua karyawan
  List<Karyawan> getAllKaryawan() {
    return karyawanData;
  }
}
