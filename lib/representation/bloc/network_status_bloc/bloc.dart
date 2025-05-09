import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/services/i_internet_connection_service.dart';

import 'events.dart';
import 'states.dart';

@singleton
class NetworkStatusBloc extends Bloc<NetworkStatusEvent, NetworkStatusState> {
  final IInternetConnectionService _internetConnectionService;

  NetworkStatusBloc(this._internetConnectionService)
    : super(NetworkStatusInitial()) {
    on<NetworkStatusUpdate>(_updateHandler);
    _internetConnectionService.onUpdate((connectionStatus) {
      add(NetworkStatusUpdate(connectionStatus));
    });
  }

  void _updateHandler(
    NetworkStatusUpdate event,
    Emitter<NetworkStatusState> emit,
  ) {
    emit(NetworkStatusReady(event.newStatus));
  }
}
