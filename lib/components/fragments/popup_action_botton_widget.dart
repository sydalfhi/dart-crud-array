import 'package:flutter/material.dart';

class ActionPopupButtonWidget extends StatelessWidget {
  final BuildContext context;
  final Map<String, dynamic> karyawanData;

  const ActionPopupButtonWidget(this.context, this.karyawanData, {super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.grey),
      onSelected: (String value) {
        switch (value) {
          case 'view':
            // Logika untuk view
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Detail Karyawan'),
                  content: Text('Nama: ${karyawanData['kodeKaryawan']}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Tutup'),
                    ),
                  ],
                );
              },
            );
            break;
          case 'edit':
            // Logika untuk edit
            Navigator.pushNamed(context, '/karyawan/update',
                arguments: karyawanData);
            break;
          case 'delete':
            // Logika untuk delete
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Konfirmasi Hapus'),
                  content: const Text(
                      'Apakah Anda yakin ingin menghapus karyawan ini?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Logika hapus
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
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'view',
            child: Row(
              children: [
                Icon(
                  Icons.visibility,
                ),
                SizedBox(width: 6),
                Text('View'),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'edit',
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                ),
                SizedBox(width: 6),
                Text('Edit'),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                ),
                SizedBox(width: 6),
                Text('Delete'),
              ],
            ),
          ),
        ];
      },
    );
  }
}
