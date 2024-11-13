class Karyawan {
  final int idKaryawan;
  final String kodeKaryawan;
  final String nomorIdentitas;
  final int jenisKelamin;
  final String email;
  final String nomorHp;
  final String alamat;

  // Konstruktor utama
  Karyawan({
    required this.idKaryawan,
    required this.kodeKaryawan,
    required this.nomorIdentitas,
    required this.jenisKelamin,
    required this.email,
    required this.nomorHp,
    required this.alamat,
  });

  /// Factory constructor untuk membuat objek Karyawan dari data JSON
  /// Berguna untuk parsing data yang diterima dari API atau database
  /// [json] Peta (map) yang berisi data karyawan dalam format JSON
  /// Mengembalikan objek Karyawan yang telah dikonversi
  factory Karyawan.fromJson(Map<String, dynamic> json) {
    return Karyawan(
      idKaryawan: json['id_karyawan'] as int,
      kodeKaryawan: json['kode_karyawan'] as String,
      nomorIdentitas: json['nomor_identitas'] as String,
      jenisKelamin: json['jenis_kelamin'] as int,
      email: json['email'] as String,
      nomorHp: json['nomor_hp'] as String,
      alamat: json['alamat'] as String,
    );
  }

  /// Mengonversi objek Karyawan menjadi format JSON
  /// Berguna untuk mengirim data ke API atau menyimpan dalam database
  /// Mengembalikan peta (map) berisi data karyawan dalam format JSON
  Map<String, dynamic> toJson() {
    return {
      'id_karyawan': idKaryawan,
      'kode_karyawan': kodeKaryawan,
      'nomor_identitas': nomorIdentitas,
      'jenis_kelamin': jenisKelamin,
      'email': email,
      'nomor_hp': nomorHp,
      'alamat': alamat,
    };
  }

  /// Membuat salinan objek Karyawan dengan kemampuan modifikasi parsial
  /// Memungkinkan pembuatan objek baru dengan menimpa field tertentu
  /// Berguna untuk update sebagian data tanpa mengubah keseluruhan objek
  /// Parameter opsional memungkinkan penggantian field secara selektif
  Karyawan copyWith({
    int? idKaryawan,
    String? kodeKaryawan,
    String? nomorIdentitas,
    int? jenisKelamin,
    String? email,
    String? nomorHp,
    String? alamat,
  }) {
    return Karyawan(
      idKaryawan: idKaryawan ?? this.idKaryawan,
      kodeKaryawan: kodeKaryawan ?? this.kodeKaryawan,
      nomorIdentitas: nomorIdentitas ?? this.nomorIdentitas,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      email: email ?? this.email,
      nomorHp: nomorHp ?? this.nomorHp,
      alamat: alamat ?? this.alamat,
    );
  }

  /// Membandingkan kesetaraan antara dua objek Karyawan
  ///
  /// Menentukan apakah dua objek Karyawan memiliki data yang identik
  /// Berguna untuk pengecekan dan perbandingan objek
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Karyawan &&
        other.idKaryawan == idKaryawan &&
        other.kodeKaryawan == kodeKaryawan &&
        other.nomorIdentitas == nomorIdentitas &&
        other.jenisKelamin == jenisKelamin &&
        other.email == email &&
        other.nomorHp == nomorHp &&
        other.alamat == alamat;
  }

  /// Menghasilkan kode hash unik untuk objek Karyawan
  ///
  /// Digunakan dalam operasi hash, seperti pada Set atau Map
  /// Memastikan objek dengan data sama memiliki hash yang konsisten
  @override
  int get hashCode {
    return idKaryawan.hashCode ^
        kodeKaryawan.hashCode ^
        nomorIdentitas.hashCode ^
        jenisKelamin.hashCode ^
        email.hashCode ^
        nomorHp.hashCode ^
        alamat.hashCode;
  }

  /// Mengonversi objek Karyawan menjadi representasi string
  ///
  /// Berguna untuk debugging dan logging
  /// Menampilkan semua informasi karyawan dalam format yang mudah dibaca
  @override
  String toString() {
    return 'Karyawan(idKaryawan: $idKaryawan, kodeKaryawan: $kodeKaryawan, nomorIdentitas: $nomorIdentitas, jenisKelamin: $jenisKelamin, email: $email, nomorHp: $nomorHp, alamat: $alamat)';
  }

  String get jenisKelaminLabel {
    return jenisKelamin == 1 ? 'Laki-laki' : 'Perempuan';
  }
}
