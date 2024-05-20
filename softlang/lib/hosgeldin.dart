import 'package:flutter/material.dart';
import 'kelimesayfasi.dart';

class Hosgeldin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 9, 71),
      appBar: AppBar(
        title: const Text(
          'Alan Seçimi',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 87, 100, 196),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAlanButonu(context, 'Frontend', const Color(0xFF8A7BF0)),
            const SizedBox(height: 20),
            _buildAlanButonu(context, 'Backend', const Color(0xFF99A8F5)),
            const SizedBox(height: 20),
            _buildAlanButonu(context, 'Siber Güvenlik', const Color(0xFF7FA7D9)),
            const SizedBox(height: 20),
            _buildAlanButonu(context, 'Mobil', const Color(0xFF2948B8)),
          ],
        ),
      ),
    );
  }

  Widget _buildAlanButonu(BuildContext context, String alan, Color butonRengi) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Kelimeler(alan: alan),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: butonRengi,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      child: Text(
        alan,
        style: const TextStyle(fontSize: 18, color: Colors.white), // Beyaz Yazı
      ),
    );
  }
}
