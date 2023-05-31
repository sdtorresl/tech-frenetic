import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techfrenetic/app/modules/articles/articles_store.dart';
import 'package:techfrenetic/app/providers/files_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageSelectionWidget extends StatefulWidget {
  const ImageSelectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageSelectionWidget> createState() => _ImageSelectionWidgetState();
}

class _ImageSelectionWidgetState extends State<ImageSelectionWidget> {
  FilesProvider filesProvider = FilesProvider();
  final ArticlesStore _articlesStore = Modular.get();
  bool _loadingPicture = false;

  @override
  Widget build(BuildContext context) {
    Widget imageBox = GestureDetector(
      onTap: () => pickImage(),
      child: _articlesStore.imageUrl != null
          ? _imagePreviewBox()
          : _selectImageBox(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(AppLocalizations.of(context)!.choose_image),
        imageBox
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
              child: Image.file(
                File(_articlesStore.imageUrl!),
              ),
            ),
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
        Icons.camera_alt_outlined,
        color: Colors.white,
        size: 50,
      ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      _articlesStore.imageUrl = image.path;
      final tempImage = File(image.path);

      setState(() {
        _loadingPicture = true;
      });

      filesProvider.uploadFile(tempImage).then((image) {
        setState(() {
          _loadingPicture = false;
        });
        _articlesStore.uploadedImage = image;
      }).onError((error, stackTrace) {
        debugPrint("Error loading image: $error");
        setState(() {
          _loadingPicture = false;
        });
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
      setState(() {
        _loadingPicture = false;
      });
    }
  }
}
