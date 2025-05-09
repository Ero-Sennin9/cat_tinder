enum ConnectionStatus { connected, disconnected }

abstract class IInternetConnectionService {
  void onUpdate(void Function(ConnectionStatus) handler);
  ConnectionStatus getStatus();
}
