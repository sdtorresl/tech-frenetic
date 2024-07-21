import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/providers/advertisement_provider.dart';

import '../../models/advertisement_model.dart';

part 'community_store.g.dart';

class CommunityStore = _CommunityStore with _$CommunityStore;

enum StoreState { initial, loading, loaded, error }

abstract class _CommunityStore with Store {
  @observable
  AdvertisementModel? advertisement;

  @observable
  ObservableFuture<AdvertisementModel?>? _advertisementFuture;

  final _advertisementProvider = Modular.get<AdvertisementProvider>();

  @computed
  StoreState get state {
    if (_advertisementFuture == null ||
        _advertisementFuture?.status == FutureStatus.rejected) {
      return StoreState.initial;
    }

    return _advertisementFuture!.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  Future fetchVideo() async {
    _advertisementFuture =
        ObservableFuture(_advertisementProvider.getVideoAdvertisement());
    advertisement = await _advertisementFuture;
    return _advertisementFuture;
  }
}
