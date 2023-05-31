import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techfrenetic/app/modules/articles/articles_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/providers/video_provider.dart';

class VideoSelectionWidget extends StatefulWidget {
  const VideoSelectionWidget({Key? key}) : super(key: key);

  @override
  State<VideoSelectionWidget> createState() => _VideoSelectionWidgetState();
}

class _VideoSelectionWidgetState extends State<VideoSelectionWidget> {
  final VideoProvider _videoProvider = VideoProvider();
  final ArticlesStore _articlesStore = Modular.get();
  bool _loadingVideo = true;
  double progress = 0;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(AppLocalizations.of(context)!.articles_video),
        GestureDetector(
          onTap: () => pickImage(),
          child: image != null ? _imagePreviewBox() : _selectImageBox(),
        )
      ],
    );
  }

  Widget _imagePreviewBox() {
    Widget loadingIcon = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color.fromRGBO(0, 0, 0, 0.4),
          ),
          child: const SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color.fromRGBO(0, 0, 0, 0.4),
          ),
          child: Text(
            "${progress.toStringAsPrecision(2)}%",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.white),
          ),
        )
      ],
    );

    return Container(
      color: Colors.blueGrey,
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 200,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            left: 0,
            child: image != null
                ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: image!,
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            left: 0,
            child: _loadingVideo ? loadingIcon : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Container _selectImageBox() {
    return Container(
      height: 200,
      color: Colors.blueGrey,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(50),
      child: const Icon(
        Icons.video_camera_back_outlined,
        color: Colors.white,
        size: 50,
      ),
    );
  }

  Future pickImage() async {
    try {
      final _picker = ImagePicker();
      final XFile? videoFile =
          await _picker.pickVideo(source: ImageSource.gallery);

      if (videoFile == null) return;

      setState(() {
        _loadingVideo = true;
      });

      _videoProvider.uploadVideo(
        videoFile,
        (String? videoId) {
          if (videoId != null) {
            _videoProvider.getVideo(videoId).then((video) {
              if (video != null) {
                _articlesStore.uploadedVideo = video;
                setState(() {
                  image = video.thumbnail;
                  _loadingVideo = false;
                });
              }
            });
          }
        },
        (progress) {
          debugPrint("Progress: $progress");
          setState(() {
            progress = progress;
          });
        },
      );
    } on PlatformException catch (e) {
      debugPrint('Failed to pick video: $e');
      setState(() {
        _loadingVideo = false;
      });
    }
  }
}
