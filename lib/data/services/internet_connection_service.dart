import 'package:injectable/injectable.dart';

import '../../domain/services/i_internet_connection_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

@Singleton(as: IInternetConnectionService)
class InternetConnectionService implements IInternetConnectionService {
  final _client = Connectivity();
  var _status = ConnectionStatus.disconnected;

  @override
  void onUpdate(void Function(ConnectionStatus) handler) {
    _client.onConnectivityChanged.listen((connectivityResults) {
      for (final connectivityResult in connectivityResults) {
        if (connectivityResult == ConnectivityResult.none) {
          _status = ConnectionStatus.disconnected;
        } else {
          _status = ConnectionStatus.connected;
        }
        handler(_status);
      }
    });
  }

  @override
  ConnectionStatus getStatus() {
    return _status;
  }
}
