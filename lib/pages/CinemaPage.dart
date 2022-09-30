// import 'package:flutter/material.dart';
// class CinemaPage extends StatelessWidget {
//   const CinemaPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.amber,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  FlickManager? flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network("https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/the_valley_compressed.mp4?raw=true"),
    );
  }

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlickVideoPlayer(
          flickManager: flickManager!
      ),
    );
  }
}