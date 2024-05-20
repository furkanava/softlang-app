import 'package:flutter/material.dart';

class Ogrendiklerim extends StatefulWidget {
  final List<Map<String, String>> ogrenilenKelimeler; // Listeyi al

  Ogrendiklerim({required this.ogrenilenKelimeler});

  @override
  _OgrendiklerimState createState() => _OgrendiklerimState();
}

class _OgrendiklerimState extends State<Ogrendiklerim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öğrendiklerim'),
      ),
      body: widget.ogrenilenKelimeler.isEmpty // Alınan listeyi kullan
          ? Center(
              child: Text(
                'Henüz öğrenilmiş kelime yok.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: widget.ogrenilenKelimeler.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.ogrenilenKelimeler[index]['kelime']!),
                  subtitle: Text(widget.ogrenilenKelimeler[index]['anlam']!),
                );
              },
            ),
    );
  }
}
