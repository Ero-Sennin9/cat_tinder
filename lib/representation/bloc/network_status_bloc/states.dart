import '../../../domain/services/i_internet_connection_service.dart';

abstract class NetworkStatusState {}

class NetworkStatusInitial extends NetworkStatusState {}

class NetworkStatusReady extends NetworkStatusState {
  final ConnectionStatus connectionStatus;
  NetworkStatusReady(this.connectionStatus);
}
