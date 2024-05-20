import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoSayfasi extends StatefulWidget {
  @override
  _VideoSayfasiState createState() => _VideoSayfasiState();
}

class _VideoSayfasiState extends State<VideoSayfasi> {
  final List<String> _videoIds = [
    '9fkLbqZcvcE', 
    'U6ZBa5b5pqA', 
    'NWnBxQjssvQ',
  ];

  late List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = _videoIds.map((videoId) => YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )).toList();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    'Videolar',
    style: TextStyle(color: Colors.white), 
  ),
  backgroundColor: const Color.fromARGB(255, 87, 100, 196),
),
 //Arkaplan rengi
      body: ListView.builder(
        itemCount: _videoIds.length,
        itemBuilder: (context, index) {
          return YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controllers[index],
              showVideoProgressIndicator: true,
            ),
            builder: (context, player) {
              return Column(
                children: [
                  player,
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'English for Developers',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
