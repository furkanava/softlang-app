import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import 'ogrendiklerim.dart';
import 'video_sayfasi.dart';
import 'profil_sayfasi.dart';
import 'yapayzeka.dart';

class Kelimeler extends StatefulWidget {
  final String alan;

  Kelimeler({required this.alan});

  @override
  _KelimelerState createState() => _KelimelerState();
}

class _KelimelerState extends State<Kelimeler> {
  int _currentIndex = 0;
  int _selectedIndex = 0;

  final List<Map<String, String>> _ogrenilenKelimeler = [];

  final Map<String, List<Map<String, String>>> _alanKelimeleri = {
  'Frontend': [
    {'kelime': 'HTML', 'anlam': 'Hiper Metin İşaretleme Dili'},
    {'kelime': 'CSS', 'anlam': 'Basamaklı Stil Sayfaları'},
    {'kelime': 'JavaScript', 'anlam': 'Web sayfalarına etkileşim katan programlama dili'},
    {'kelime': 'DOM', 'anlam': 'Belge Nesne Modeli (Document Object Model)'},
    {'kelime': 'AJAX', 'anlam': 'Asenkron JavaScript ve XML (Asynchronous JavaScript and XML)'},
    {'kelime': 'Framework', 'anlam': 'Web geliştirmeyi hızlandıran yapı (Örn: React, Angular, Vue)'},
    {'kelime': 'SPA', 'anlam': 'Tek Sayfa Uygulama (Single Page Application)'},
    {'kelime': 'SEO', 'anlam': 'Arama Motoru Optimizasyonu (Search Engine Optimization)'},
    {'kelime': 'Accessibility', 'anlam': 'Erişilebilirlik'},
    {'kelime': 'WebAssembly', 'anlam': 'Web tarayıcısında yüksek performanslı kod çalıştırma teknolojisi'},
  ],
  'Backend': [
    {'kelime': 'API', 'anlam': 'Uygulama Programlama Arayüzü (Application Programming Interface)'},
    {'kelime': 'Database', 'anlam': 'Veritabanı (Örn: MySQL, PostgreSQL, MongoDB)'},
    {'kelime': 'Server', 'anlam': 'İstemcilere hizmet veren bilgisayar veya yazılım'},
    {'kelime': 'REST', 'anlam': 'Representational State Transfer (Temsili Durum Transferi)'},
    {'kelime': 'ORM', 'anlam': 'Nesne-İlişkisel Eşleme (Object-Relational Mapping)'},
    {'kelime': 'Middleware', 'anlam': 'İstek ve yanıtları işleyen yazılım katmanı'},
    {'kelime': 'MVC', 'anlam': 'Model-View-Controller (Model-Görünüm-Denetleyici)'},
    {'kelime': 'Cloud Computing', 'anlam': 'Bulut Bilişim'},
    {'kelime': 'Scalability', 'anlam': 'Ölçeklenebilirlik'},
    {'kelime': 'Load Balancing', 'anlam': 'Yük Dengeleme'},
  ],
  'Siber Güvenlik': [
    {'kelime': 'Firewall', 'anlam': 'Güvenlik Duvarı'},
    {'kelime': 'Encryption', 'anlam': 'Şifreleme'},
    {'kelime': 'Decryption', 'anlam': 'Şifre Çözme'},
    {'kelime': 'Malware', 'anlam': 'Zararlı Yazılım'},
    {'kelime': 'Phishing', 'anlam': 'Oltalama Saldırısı'},
    {'kelime': 'Social Engineering', 'anlam': 'Sosyal Mühendislik'},
    {'kelime': 'Vulnerability', 'anlam': 'Güvenlik Açığı'},
    {'kelime': 'Penetration Testing', 'anlam': 'Sızma Testi'},
    {'kelime': 'Ransomware', 'anlam': 'Fidye Yazılımı'},
    {'kelime': 'Zero-Day Attack', 'anlam': 'Sıfırıncı Gün Saldırısı'},
  ],
  'Mobil': [
    {'kelime': 'Android', 'anlam': 'Google tarafından geliştirilen mobil işletim sistemi'},
    {'kelime': 'iOS', 'anlam': 'Apple tarafından geliştirilen mobil işletim sistemi'},
    {'kelime': 'Flutter', 'anlam': 'Google tarafından geliştirilen mobil uygulama geliştirme frameworkü'},
    {'kelime': 'React Native', 'anlam': 'Facebook tarafından geliştirilen mobil uygulama geliştirme frameworkü'},
    {'kelime': 'Native App', 'anlam': 'Belirli bir platform için özel olarak geliştirilen uygulama'},
    {'kelime': 'Hybrid App', 'anlam': 'Web teknolojileriyle geliştirilen ve farklı platformlarda çalışabilen uygulama'},
    {'kelime': 'SDK', 'anlam': 'Yazılım Geliştirme Kiti (Software Development Kit)'},
    {'kelime': 'APK', 'anlam': 'Android Paket Dosyası (Android Package Kit)'},
    {'kelime': 'IPA', 'anlam': 'iOS Uygulama Arşiv Dosyası (iOS App Store Package)'},
    {'kelime': 'UI/UX', 'anlam': 'Kullanıcı Arayüzü/Kullanıcı Deneyimi (User Interface/User Experience)'},
  ],
};


  void _nextWord() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _alanKelimeleri[widget.alan]!.length;
      if (!_ogrenilenKelimeler.contains(_alanKelimeleri[widget.alan]![_currentIndex])) {
        _ogrenilenKelimeler.add(_alanKelimeleri[widget.alan]![_currentIndex]);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 9, 71),
      appBar: AppBar(
        title: Text(
          widget.alan,
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: const Color.fromARGB(255, 87, 100, 196),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: IndexedStack( 
        index: _selectedIndex,
        children: [
          _buildKelimeSayfasi(),
          VideoSayfasi(),
          Ogrendiklerim(ogrenilenKelimeler: _ogrenilenKelimeler),
          ProfilSayfasi(),
          YapayZeka(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF8A7BF0),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Kelimeler'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Videolar'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Öğrendiklerim'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Yapay Zeka'),
        ],
      ),
    );
  }

  Widget _buildKelimeSayfasi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_alanKelimeleri[widget.alan]!.length, (index) {
              return Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? const Color(0xFF8A7BF0) : Colors.grey,
                ),
              );
            }),
          ),
          SizedBox(height: 20),
          FlipCard(
            direction: FlipDirection.HORIZONTAL,
            front: _buildCardFace(_alanKelimeleri[widget.alan]![_currentIndex]['kelime']!),
            back: _buildCardFace(_alanKelimeleri[widget.alan]![_currentIndex]['anlam']!),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _nextWord,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8A7BF0),
            ),
            child: const Text('Sonraki', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildCardFace(String text) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: text == _alanKelimeleri[widget.alan]![_currentIndex]['kelime']! ? 32 : 24),
        ),
      ),
    );
  }
}
