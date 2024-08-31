import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoScreen extends StatefulWidget {
  String video_id;
  PlayVideoScreen({super.key, required this.video_id});

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.video_id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                  alignment: Alignment.topRight,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: Colors.white,))),

              Align(
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  onReady: () {
                    _controller.play();
                  },
                ),
              )
            ],
          )

        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
