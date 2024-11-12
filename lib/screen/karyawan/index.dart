// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:crud_array/components/fragments/bottom_navigation_bar.dart';
import 'package:crud_array/components/fragments/popup_action_botton_widget.dart';
import 'package:crud_array/models/karyawan.dart';
import 'package:crud_array/screen/karyawan/create.dart';
import 'package:flutter/material.dart';

class KaryawanPage extends StatefulWidget {
  const KaryawanPage({super.key});

  @override
  State<KaryawanPage> createState() => _KaryawanPageState();
}

class _KaryawanPageState extends State<KaryawanPage> {
  // Pindahkan karyawanData ke dalam state class
  List<Karyawan> karyawanData = [];

  // Metode untuk membuka halaman create
void _tambahKaryawan() async {
  final result = await Navigator.push<Karyawan>(
    context,
    MaterialPageRoute(
      builder: (context) => const CreateKaryawanPage(),
    ),
  );

  // Pastikan konteks masih valid
  if (!mounted) return;

  // Gunakan null-aware operator
  if (result != null) {
    setState(() {
      karyawanData.add(result);
    });

    // Tampilkan SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Karyawan berhasil ditambahkan'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Daftar Karyawan"),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: SingleChildScrollView(
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
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Kode')),
                    DataColumn(label: Text('Jenis Kelamin')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Aksi')),
                  ],
                  rows: karyawanData.map((person) {
                    return DataRow(cells: [
                      DataCell(Text(person.idKaryawan.toString())),
                      DataCell(Text(person.kodeKaryawan)),
                      DataCell(Text(person.jenisKelaminLabel)),
                      DataCell(Text(person.email)),
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
                'Total Karyawan: ${karyawanData.length} Orang',
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
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahKaryawan,
        child: const Icon(Icons.add),
      ),
    );
  }
}
