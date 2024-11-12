import 'package:crud_array/models/karyawan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateKaryawanPage extends StatefulWidget {
  const CreateKaryawanPage({super.key});

  @override
  State<CreateKaryawanPage> createState() => _CreateKaryawanPageState();
}

class _CreateKaryawanPageState extends State<CreateKaryawanPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _kodeKaryawanController = TextEditingController();
  final TextEditingController _nomorIdentitasController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomorHpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  int _jenisKelamin = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Karyawan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _kodeKaryawanController,
                decoration: const InputDecoration(
                  labelText: 'Kode Karyawan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kode karyawan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomorIdentitasController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Identitas',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor identitas tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Jenis Kelamin', style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: _jenisKelamin,
                    onChanged: (value) {
                      setState(() {
                        _jenisKelamin = value!;
                      });
                    },
                  ),
                  const Text('Laki-laki'),
                  Radio(
                    value: 2,
                    groupValue: _jenisKelamin,
                    onChanged: (value) {
                      setState(() {
                        _jenisKelamin = value!;
                      });
                    },
                  ),
                  const Text('Perempuan'),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomorHpController,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor HP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Buat objek Karyawan langsung, bukan map
      final karyawanBaru = Karyawan(
        idKaryawan: DateTime.now().millisecondsSinceEpoch,
        kodeKaryawan: _kodeKaryawanController.text,
        nomorIdentitas: _nomorIdentitasController.text,
        jenisKelamin: _jenisKelamin,
        email: _emailController.text,
        nomorHp: _nomorHpController.text,
        alamat: _alamatController.text,
      );

      // Debug print untuk memastikan data benar
      print('Karyawan Baru:');
      print('ID: ${karyawanBaru.idKaryawan}');
      print('Kode Karyawan: ${karyawanBaru.kodeKaryawan}');
      print('Nomor Identitas: ${karyawanBaru.nomorIdentitas}');
      print('Jenis Kelamin: ${karyawanBaru.jenisKelamin}');
      print('Email: ${karyawanBaru.email}');
      print('Nomor HP: ${karyawanBaru.nomorHp}');
      print('Alamat: ${karyawanBaru.alamat}');

      // Navigasi kembali ke halaman sebelumnya dan kirim data
      Navigator.pop(context, karyawanBaru);
    }
  }

  @override
  void dispose() {
    // Membersihkan controller
    _kodeKaryawanController.dispose();
    _nomorIdentitasController.dispose();
    _emailController.dispose();
    _nomorHpController.dispose();
    _alamatController.dispose();
    super.dispose();
  }
}
