import 'package:flutter/material.dart';
import 'geminichat.dart';

class YapayZeka extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03045E), 
      appBar: AppBar(
        title: const Text(
          'Hikayeler',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF293294), 
      ),
      body: ListView.builder(
        itemCount: 10, 
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
            leading: CircleAvatar(
              radius: 30, 
              backgroundImage: const AssetImage('assets/images/foto.png'), 
            ),
            title: Text(
              'Bölüm ${index + 1}', 
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500, 
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white), 
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GeminiChat(), 
                ),
              );
            },
          );
        },
      ),
    );
  }
}
