import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

void showVideoSources(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Text(AppLocalizations.of(context)!.video_load),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            Modular.to.pushNamed("/community/video");
          },
          child: Text(AppLocalizations.of(context)!.video_from_camera),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.pop(context);
            final _picker = ImagePicker();
            final XFile? videoFile =
                await _picker.pickVideo(source: ImageSource.gallery);

            if (videoFile == null) return;
            Modular.to
                .pushNamed('/community/video/preview', arguments: videoFile);
          },
          child: Text(AppLocalizations.of(context)!.video_from_gallery),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(AppLocalizations.of(context)!.cancel),
      ),
    ),
  );
}
