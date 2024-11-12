STRUKTUR FOLDER
```
    lib/
    │
    ├── models/
    │   └── karyawan.dart
    │
    ├── services/
    │   └── karyawan_service.dart
    │
    ├── screens/
    │   └── karyawan/
    │       ├── create.dart
    │       └── list.dart
    │
    └── utils/
        ├── api_config.dart
        └── secure_storage.dart
```

```
        // Service untuk menangani operasi API terkait Karyawan
    class KaryawanService {
    // Metode untuk membuat karyawan baru melalui API
    Future<dynamic> createKaryawan(Karyawan karyawan) async {
        try {
        // Kirim request POST ke endpoint karyawan
        final response = await http.post(
            // Gunakan base URL dari konfigurasi API
            Uri.parse('${ApiConfig.baseUrl}/karyawan'),
            
            // Atur header request
            headers: {
            // Tentukan tipe konten sebagai JSON
            'Content-Type': 'application/json',
            // Sertakan token otorisasi untuk keamanan
            'Authorization': 'Bearer $token'
            },
            
            // Ubah objek Karyawan menjadi JSON untuk dikirim
            body: jsonEncode(karyawan.toJson()),
        );

        // Periksa status response
        if (response.statusCode == 200 || response.statusCode == 201) {
            // Jika berhasil, kembalikan data JSON yang diterima dari server
            return jsonDecode(response.body);
        } else {
            // Jika gagal, lempar exception dengan pesan error
            throw Exception('Gagal membuat karyawan');
        }
        } catch (e) {
        // Catat error di console untuk debugging
        print('Error creating karyawan: $e');
        // Lempar ulang error agar bisa ditangani di level pemanggil
        rethrow;
        }
    }
    }

    // Halaman untuk membuat karyawan baru
    class CreateKaryawanPage extends StatefulWidget {
    @override
    _CreateKaryawanPageState createState() => _CreateKaryawanPageState();
    }

    class _CreateKaryawanPageState extends State<CreateKaryawanPage> {
    // Inisialisasi service untuk operasi karyawan
    final _karyawanService = KaryawanService();
    
    // Flag untuk menunjukkan proses loading
    bool _isLoading = false;

    // Metode untuk mengirim form
    void _submitForm() async {
        // Validasi form terlebih dahulu
        if (_formKey.currentState!.validate()) {
        // Aktifkan indikator loading
        setState(() {
            _isLoading = true;
        });

        try {
            // Buat objek karyawan baru dari input form
            final karyawanBaru = Karyawan(
            // Isi dengan data dari controller
            // Contoh:
            // idKaryawan: DateTime.now().millisecondsSinceEpoch,
            // kodeKaryawan: _kodeKaryawanController.text,
            // dst...
            );

            // Kirim data karyawan ke service untuk disimpan di database
            final response = await _karyawanService.createKaryawan(karyawanBaru);
            
            // Periksa apakah response tidak null (berhasil)
            if (response != null) {
            // Kembali ke halaman sebelumnya dengan membawa data karyawan baru
            Navigator.pop(context, karyawanBaru);
            
            // Tampilkan pesan sukses
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Karyawan berhasil dibuat'))
            );
            }
        } catch (e) {
            // Tangani error yang mungkin terjadi
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal membuat karyawan: $e'))
            );
        } finally {
            // Matikan indikator loading, baik berhasil atau gagal
            setState(() {
            _isLoading = false;
            });
        }
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        // Tampilkan loading indicator jika sedang memproses
        body: _isLoading 
            ? Center(child: CircularProgressIndicator())
            // Atau tampilkan form input
            : // form anda
        );
    }
    }
```