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
  bool _loadingPicture = false;
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

  SizedBox _imagePreviewBox() {
    Widget loadingIcon = Center(
      child: Container(
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
    );

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            left: 0,
            child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: Image.network(image!)),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            left: 0,
            child: _loadingPicture ? loadingIcon : const SizedBox.shrink(),
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
        _loadingPicture = true;
      });

      _videoProvider.uploadVideo(
        videoFile,
        (String? videoId) {
          debugPrint("Completed with ID $videoId");

          if (videoId != null) {
            _videoProvider.getVideo(videoId).then((video) {
              if (video != null) {
                _articlesStore.uploadedVideo = video;
                setState(() {
                  image = video.thumbnail;
                  _loadingPicture = false;
                });
              }
            });
          }
        },
        (progress) => debugPrint(progress.toString()),
      );
    } on PlatformException catch (e) {
      debugPrint('Failed to pick video: $e');
      setState(() {
        _loadingPicture = false;
      });
    }
  }
}
