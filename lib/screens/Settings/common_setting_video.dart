// import 'package:flutter/material.dart';
// import 'package:pod_player/pod_player.dart';
//
// class commonSettingVideo extends StatefulWidget {
//   const commonSettingVideo(this.videoUrl, this.onTap);
//   final String videoUrl;
//   final Function onTap;
//
//   @override
//   State<commonSettingVideo> createState() => _commonSettingVideoState();
// }
//
// class _commonSettingVideoState extends State<commonSettingVideo> {
//   // YoutubePlayerController? _ytbPlayerController;
//   // String? youtubeId;
//   late final PodPlayerController controller;
//
//   @override
//   void initState() {
//     controller = PodPlayerController(
//       podPlayerConfig: PodPlayerConfig(
//         autoPlay: false,
//       ),
//       playVideoFrom: PlayVideoFrom.youtube(widget.videoUrl),
//     )..initialise();
//     // print(':::::: +++++++ ::::::;${widget.videoUrl}');
//     // setState(() {
//     //   _ytbPlayerController = YoutubePlayerController(
//     //       // params: const YoutubePlayerParams(
//     //       //   showControls: true,
//     //       //   mute: false,
//     //       //   showFullscreenButton: true,
//     //       //   loop: false,
//     //       // ),
//     //       );
//     //   _ytbPlayerController?.loadVideoById(videoId: 'LZbHV4dcTWI');
//     // });
//
//     super.initState();
//     // youtubeId = convertUrlToId(widget.videoUrl);
//     // _setOrientation([
//     //   DeviceOrientation.landscapeRight,
//     //   DeviceOrientation.landscapeLeft,
//     // ]);
//   }
//
//   void loadVideo() async {
//     // youtubeId = convertUrlToId(widget.videoUrl)!;
//     // print(youtubeId);
//     // final _controller = YoutubePlayerController(
//     //   params: YoutubePlayerParams(
//     //     mute: false,
//     //     showControls: true,
//     //     showFullscreenButton: true,
//     //   ),
//     // );
//
//     // _controller.loadVideoById(...); // Auto Play
//     // _controller.cueVideoById(...); // Manual Play
//     // _controller.loadPlaylist(...); // Auto Play with playlist
//     // _controller.cuePlaylist(...); // Manual Play with playlist
//
// // If the requirement is just to play a single video.
// //     setState(() {
// //     _ytbPlayerController = YoutubePlayerController.fromVideoId(
// //       videoId: youtubeId ?? '',
// //       autoPlay: false,
// //       params: YoutubePlayerParams(
// //           showFullscreenButton: true, playsInline: false, userAgent: youtubeId),
// //     );
// //     print(await _ytbPlayerController!.videoUrl);
//     // });
//   }
//
//   @override
//   void dispose() {
//     print("DISPOSECALL :::::::::::::::::::: ${widget.videoUrl}");
//     controller.dispose();
//     // _ytbPlayerController?.close();
//     super.dispose();
//
//     // _setOrientation([
//     //   DeviceOrientation.portraitUp,
//     //   DeviceOrientation.portraitDown,
//     //   DeviceOrientation.landscapeRight,
//     //   DeviceOrientation.landscapeLeft,
//     // ]);
//   }
//
//   // _setOrientation(List<DeviceOrientation> orientations) {
//   //   SystemChrome.setPreferredOrientations(orientations);
//   // }
//
//   // final _meeduPlayerController = MeeduPlayerController();
//   //
// //   @override
// //   void initState() {
// //     super.initState();
// // // The following line will enable the Android and iOS WakelockPlus.
// //     WakelockPlus.enable();
// //
// //     // Wait until the fisrt render the avoid posible errors when use an context while the view is rendering
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _init();
// //     });
// //   }
// //
// //   @override
// //   void dispose() {
// //     // The next line disables the wakelock again.
// //     WakelockPlus.disable();
// //     _meeduPlayerController.dispose(); // release the video player
// //     super.dispose();
// //   }
// //
// //   /// play a video from network
// //   _init() {
// //     _meeduPlayerController.setDataSource(
// //       DataSource(
// //         type: DataSourceType.network,
// //         source: widget.videoUrl,
// //       ),
// //       autoplay: false,
// //     );
// //   }
//
//   // String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
//   //   assert(url.isNotEmpty ?? false, 'Url cannot be empty');
//   //   if (!url.contains("http") && (url.length == 11)) return url;
//   //   if (trimWhitespaces) url = url.trim();
//   //
//   //   for (var exp in [
//   //     RegExp(
//   //         r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
//   //     RegExp(
//   //         r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
//   //     RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
//   //   ]) {
//   //     RegExpMatch? match = exp.firstMatch(url);
//   //     if (match != null && match.groupCount >= 1) return match.group(1);
//   //   }
//   //
//   //   return null;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     loadVideo();
//     return Stack(
//       alignment: Alignment.topRight,
//       children: [
//         Container(
//           margin: const EdgeInsets.all(15),
//           // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               // image: DecorationImage(
//               //     image: NetworkImage(widget.videoUrl), fit: BoxFit.cover),
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.grey.withOpacity(0.15),
//                     spreadRadius: 2,
//                     blurRadius: 4,
//                     offset: Offset(2, 2))
//               ]),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: AspectRatio(
//               aspectRatio: 16 / 9,
//               child: controller != null
//                   ? PodVideoPlayer(controller: controller)
//                   // YoutubePlayer(
//                   //         controller: _ytbPlayerController!,
//                   //         aspectRatio: 16 / 9,
//                   //       )
//                   : Center(child: CircularProgressIndicator()),
//
//               // MeeduVideoPlayer(
//               //   controller: _meeduPlayerController,
//               // ),
//             ),
//           ),
//         ),
//         Positioned(
//           right: 0,
//           top: 0,
//           child: GestureDetector(
//               onTap: () {
//                 print('On tap called');
//                 widget.onTap();
//               },
//               child: Container(
//                   height: 35,
//                   width: 35,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       border: Border.all(color: Colors.redAccent),
//                       color: Colors.white),
//                   child: Icon(
//                     Icons.close_rounded,
//                     color: Colors.redAccent,
//                     size: 25,
//                   ))),
//         ),
//       ],
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_meedu_videoplayer/meedu_player.dart';
// // import 'package:wakelock_plus/wakelock_plus.dart';
// //
// // class commonSettingVideo extends StatefulWidget {
// //   const commonSettingVideo(this.videoUrl, this.onTap);
// //   final String videoUrl;
// //   final Function onTap;
// //
// //   @override
// //   State<commonSettingVideo> createState() => _commonSettingVideoState();
// // }
// //
// // class _commonSettingVideoState extends State<commonSettingVideo> {
// //   final _meeduPlayerController = MeeduPlayerController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// // // The following line will enable the Android and iOS WakelockPlus.
// //     WakelockPlus.enable();
// //
// //     // Wait until the fisrt render the avoid posible errors when use an context while the view is rendering
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _init();
// //     });
// //   }
// //
// //   @override
// //   void dispose() {
// //     // The next line disables the wakelock again.
// //     WakelockPlus.disable();
// //     _meeduPlayerController.dispose(); // release the video player
// //     super.dispose();
// //   }
// //
// //   /// play a video from network
// //   _init() {
// //     _meeduPlayerController.setDataSource(
// //       DataSource(
// //         type: DataSourceType.network,
// //         source: widget.videoUrl,
// //       ),
// //       autoplay: false,
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       alignment: Alignment.topRight,
// //       children: [
// //         Container(
// //           // margin: const EdgeInsets.only(bottom: 5),
// //           // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
// //           decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(20),
// //               // image: DecorationImage(
// //               //     image: NetworkImage(widget.videoUrl), fit: BoxFit.cover),
// //               boxShadow: [
// //                 BoxShadow(
// //                     color: Colors.grey.withOpacity(0.15),
// //                     spreadRadius: 2,
// //                     blurRadius: 4,
// //                     offset: Offset(2, 2))
// //               ]),
// //           child: ClipRRect(
// //             borderRadius: BorderRadius.circular(20),
// //             child: AspectRatio(
// //               aspectRatio: 16 / 9,
// //               child: MeeduVideoPlayer(
// //                 controller: _meeduPlayerController,
// //               ),
// //             ),
// //           ),
// //         ),
// //         Positioned(
// //           right: 10,
// //           top: 10,
// //           child: InkWell(
// //               onTap: () {
// //                 widget.onTap();
// //               },
// //               child: Container(
// //                   height: 35,
// //                   width: 35,
// //                   decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(50),
// //                       border: Border.all(color: Colors.redAccent),
// //                       color: Colors.white),
// //                   child: Icon(
// //                     Icons.close_rounded,
// //                     color: Colors.redAccent,
// //                     size: 25,
// //                   ))),
// //         ),
// //       ],
// //     );
// //   }
// // }
