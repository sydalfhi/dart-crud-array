// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:crud_array/components/fragments/bottom_navigation_bar.dart';
import 'package:crud_array/components/fragments/popup_action_botton_widget.dart';
import 'package:crud_array/models/karyawan.dart';
import 'package:crud_array/pages/karyawan/form.dart';

class KaryawanPage extends StatefulWidget {
  const KaryawanPage({super.key});

  @override
  State<KaryawanPage> createState() => _KaryawanPageState();
}

class _KaryawanPageState extends State<KaryawanPage> {
  // List<Karyawan> karyawanData = KaryawanDatabase.getAllKaryawan();

  List<Karyawan> _karyawanList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchKaryawan();
  }

  _fetchKaryawan() async {
    try {
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan: $e'),
      ));
    }
  }

  // Metode untuk membuka halaman create
  void _tambahKaryawan() async {
    final result = await Navigator.push<Karyawan>(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateKaryawanPage(
          mode: 'create',
        ),
      ),
    );

    // Pastikan konteks masih valid
    if (!mounted) return;
    if (result != null) {
      setState(() {
        _karyawanList.add(result);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Karyawan berhasil ditambahkan'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _updateKaryawan(person) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateKaryawanPage(
          mode: 'edit',
          karyawanData: person,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _karyawanList[_karyawanList.indexWhere(
            (karyawan) => karyawan.idKaryawan == person.idKaryawan)] = result;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Karyawan ${person.kodeKaryawan} berhasil diedit'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showDeleteConfirmation(id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content:
              const Text('Apakah Anda yakin ingin menghapus karyawan ini?'),
          actions: [
            TextButton(
              onPressed: () {
                // Logika hapus

                //find _karyawanList by id
                Karyawan? karyawanToDelete = _karyawanList.firstWhere(
                  (karyawan) => karyawan.idKaryawan == id,
                );

                if (karyawanToDelete != null) {
                  setState(() {
                    _karyawanList.remove(karyawanToDelete);
                  });

                  // Tampilkan SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Karyawan berhasil dihapus'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }

                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Ya'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Tidak'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Daftar Karyawan"),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        border: TableBorder.all(color: Colors.grey.shade300),
                        columnSpacing: 20,
                        dataRowColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          return states.contains(WidgetState.selected)
                              ? Colors.grey.shade200
                              : Colors.white;
                        }),
                        columns: const [
                          // DataColumn(label: Text('ID asdad')),
                          DataColumn(label: Text('Nama')),
                          DataColumn(label: Text('Nmer IDentitas')),
                          DataColumn(label: Text('Jenis Kelamin')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('edit')),
                          DataColumn(label: Text('hapus')),
                          DataColumn(label: Text('Aksi')),
                        ],
                        rows: _karyawanList.map((person) {
                          return DataRow(cells: [
                            // DataCell(Text(person.idKaryawan.toString())),
                            DataCell(Text(person.kodeKaryawan)),
                            DataCell(Text(person.nomorIdentitas)),
                            DataCell(Text(person.jenisKelaminLabel)),
                            DataCell(Text(person.email)),
                            DataCell(IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                _updateKaryawan(person);
                              },
                            )),
                            DataCell(IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _showDeleteConfirmation(person.idKaryawan);
                              },
                            )),
                            DataCell(
                              ActionPopupButtonWidget(context, {
                                'idKaryawan': person.idKaryawan,
                                'kodeKaryawan': person.kodeKaryawan,
                              }),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total Karyawan: ${_karyawanList.length} Orang',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: Stack(
        children: [
          // Tombol refresh
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _fetchKaryawan,
              child: Icon(Icons.refresh),
            ),
          ),
          // Tombol tambah
          Positioned(
            bottom: 16,
            right: 90, // Menjauh sedikit dari tombol refresh
            child: FloatingActionButton(
              onPressed: _tambahKaryawan,
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
