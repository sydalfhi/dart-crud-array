import 'package:flutter/material.dart';
import 'package:tes_flutter_wireles/models/karyawan.dart';

class ActionPopupButtonWidget extends StatefulWidget {
  final BuildContext context;
  final Map<String, dynamic> karyawanData;
  final VoidCallback? onUpdateSuccess;
  final VoidCallback? onDeleteSuccess;

  const ActionPopupButtonWidget(this.context, this.karyawanData,
      {super.key, this.onUpdateSuccess, this.onDeleteSuccess});

  @override
  _ActionPopupButtonWidgetState createState() =>
      _ActionPopupButtonWidgetState();
}

class _ActionPopupButtonWidgetState extends State<ActionPopupButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.grey),
      onSelected: (String value) async {
        switch (value) {
          case 'view':
            _showDetailDialog();
            break;
          // case 'delete':
          //   _showDeleteConfirmation();
          //   break;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'view',
            child: Row(
              children: [
                Icon(Icons.visibility),
                SizedBox(width: 6),
                Text('View'),
              ],
            ),
          ),
          // const PopupMenuItem<String>(
          //   value: 'delete',
          //   child: Row(
          //     children: [
          //       Icon(Icons.delete),
          //       SizedBox(width: 6),
          //       Text('Delete'),
          //     ],
          //   ),
          // ),
        ];
      },
    );
  }

  void _showDetailDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detail Karyawan'),
          content: Text('Nama: ${widget.karyawanData['kodeKaryawan']}'),
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
  }

//   void _showDeleteConfirmation() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Konfirmasi Hapus'),
//           content:
//               const Text('Apakah Anda yakin ingin menghapus karyawan ini?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Logika hapus
//                 Karyawan? karyawanToDelete = KaryawanDatabase.getKaryawanById(
//                     widget.karyawanData['idKaryawan']);

//                 if (karyawanToDelete != null) {
//                   KaryawanDatabase.karyawanData.remove(karyawanToDelete);

//                   // Tampilkan SnackBar
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Karyawan berhasil dihapus'),
//                       backgroundColor: Colors.red,
//                       duration: Duration(seconds: 2),
//                     ),
//                   );

//                   // Panggil callback jika disediakan
//                   widget.onDeleteSuccess?.call();
//                 }

//                 Navigator.of(context).pop(); // Tutup dialog
//               },
//               child: const Text('Ya'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Tutup dialog
//               },
//               child: const Text('Tidak'),
//             ),
//           ],
//         );
//       },
//     );
//   }
}
