import '../../../domain/services/i_internet_connection_service.dart';

abstract class NetworkStatusEvent {}

class NetworkStatusUpdate implements NetworkStatusEvent {
  final ConnectionStatus newStatus;
  NetworkStatusUpdate(this.newStatus);
}
