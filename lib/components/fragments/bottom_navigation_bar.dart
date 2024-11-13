import 'package:flutter/material.dart';
import 'package:tes_flutter_wireles/pages/home/index.dart';
import 'package:tes_flutter_wireles/pages/karyawan/index.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Navigasi ke halaman home dengan mengganti halaman saat ini
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigasi ke halaman karyawan dengan mengganti halaman saat ini
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const KaryawanPage()));
            },
          ),
        ],
      ),
    );
  }
}
