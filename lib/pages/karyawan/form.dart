import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crud_array/databse/karyawan.dart';
import 'package:crud_array/models/karyawan.dart';

class CreateKaryawanPage extends StatefulWidget {
  final String? mode;
  final Karyawan? karyawanData;

  const CreateKaryawanPage(
      {super.key, this.mode = 'create', this.karyawanData});

  @override
  State<CreateKaryawanPage> createState() => _CreateKaryawanPageState();
}

class _CreateKaryawanPageState extends State<CreateKaryawanPage> {
  final KaryawanDatabase _karyawanDatabase = KaryawanDatabase();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _kodeKaryawanController = TextEditingController();
  final TextEditingController _nomorIdentitasController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomorHpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  int _jenisKelamin = 2;
  @override
  void initState() {
    super.initState();
    if (widget.karyawanData != null) {
      _kodeKaryawanController.text = widget.karyawanData!.kodeKaryawan;
      _nomorIdentitasController.text = widget.karyawanData!.nomorIdentitas;
      _emailController.text = widget.karyawanData!.email;
      _nomorHpController.text = widget.karyawanData!.nomorHp;
      _alamatController.text = widget.karyawanData!.alamat;
      _jenisKelamin = widget.karyawanData!.jenisKelamin;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.mode == 'create' ? 'Tambah' : 'Edit'} Karyawan"),
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
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addnewKaryawan() async {
    try {
      final karyawan = Karyawan(
        idKaryawan: DateTime.now().millisecondsSinceEpoch,
        kodeKaryawan: _kodeKaryawanController.text,
        nomorIdentitas: _nomorIdentitasController.text,
        jenisKelamin: _jenisKelamin,
        email: _emailController.text,
        nomorHp: _nomorHpController.text,
        alamat: _alamatController.text,
      );
      Navigator.pop(context, karyawan);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan: $e'),
      ));
    }
  }

  _updateKaryawan() async {
    try {
      final karyawan = Karyawan(
        idKaryawan: widget.karyawanData!.idKaryawan,
        kodeKaryawan: _kodeKaryawanController.text,
        nomorIdentitas: _nomorIdentitasController.text,
        jenisKelamin: _jenisKelamin,
        email: _emailController.text,
        nomorHp: _nomorHpController.text,
        alamat: _alamatController.text,
      );
      Navigator.pop(context, karyawan);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan: $e'),
      ));
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.karyawanData == null ? _addnewKaryawan() : _updateKaryawan();
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
