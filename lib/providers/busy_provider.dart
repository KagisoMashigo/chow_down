// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

// 🌎 Project imports:
import 'package:chow_down/providers/provider_state.dart';

abstract class BusyProvider extends ChangeNotifier {
  BusyProvider() : _status = ProviderStatus.done;

  ProviderStatus _status;

  bool get isLoading => _status == ProviderStatus.loading;

  /// Toggles the provider from [ProviderStatus.done] to [ProviderStatus.loading] and vice-versa
  void toggleBusy() {
    _status = _status == ProviderStatus.done
        ? ProviderStatus.loading
        : ProviderStatus.done;
    notifyListeners();
  }

  void notBusy() {
    _status = ProviderStatus.done;
    notifyListeners();
  }

  /// Busy is set to [ProviderStatus.done]
  void reset() => _status = ProviderStatus.done;

  void startBusy() => _status = ProviderStatus.loading;

  @override
  void dispose() {
    reset();
    super.dispose();
  }
}
