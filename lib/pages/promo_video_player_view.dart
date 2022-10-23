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
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  final String url;
  VideoPlayerView(this.url);
  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  FlickManager? flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network("${this.widget.url}"),

      // VideoPlayerController.network("https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/the_valley_compressed.mp4?raw=true"),
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
        ),
        body: Container(
          child: FlickVideoPlayer(
              flickManager: flickManager!
          ),
        ),
      ),
    );
  }
}