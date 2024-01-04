class AdvertisementModel {
  final String? picture;
  final String link;
  final String? url;
  final bool isVideo;

  AdvertisementModel({
    this.picture,
    required this.link,
    this.url,
    required this.isVideo,
  });
}
