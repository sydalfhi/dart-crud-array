import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateKaryawanPage extends StatefulWidget {
  const UpdateKaryawanPage({super.key});

  @override
  State<UpdateKaryawanPage> createState() => _UpdateKaryawanPageState();
}

class _UpdateKaryawanPageState extends State<UpdateKaryawanPage> {
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
      // Proses penyimpanan data
      final karyawanBaru = {
        'kode_karyawan': _kodeKaryawanController.text,
        'nomor_identitas': _nomorIdentitasController.text,
        'jenis_kelamin': _jenisKelamin,
        'email': _emailController.text,
        'nomor_hp': _nomorHpController.text,
        'alamat': _alamatController.text,
      };

      // Contoh print data (nanti diganti dengan proses penyimpanan)
      print(karyawanBaru);

      // Bisa tambahkan logic penyimpanan ke database atau API di sini

      // Kembali ke halaman sebelumnya
      Navigator.pop(context);
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
