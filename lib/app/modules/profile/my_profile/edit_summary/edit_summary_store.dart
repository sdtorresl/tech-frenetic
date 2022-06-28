import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/core/errors.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';

part 'edit_summary_store.g.dart';

class SummaryStore = _SummaryStoreBase with _$SummaryStore;

abstract class _SummaryStoreBase with Store {
  @observable
  ErrorType? error;

  @observable
  String summary = '';

  late List<ReactionDisposer> _disposers;

  @action
  changeSummary(summary) {
    this.summary = summary;
  }

  void setupValidations() {
    _disposers = [
      reaction((_) => summary, validateSummary),
    ];
  }

  @action
  validateSummary(String value) {
    if (value.isEmpty) {
      error = ErrorType.summaryEmpty;
    } else if (summary.length < 10) {
      error = ErrorType.summaryLengtInvalid;
    } else {
      error = null;
    }
  }

  void validateAll() {
    validateSummary(summary);
  }

  Future<UserModel?> updateBiografy() async {
    if (!hasErrors) {
      UserProvider userProvider = UserProvider();
      if (await userProvider.updateBiografy(summary)) {
        return userProvider.getLoggedUser();
      }
    }

    return null;
  }

  @computed
  bool get hasErrors => error != null;

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
