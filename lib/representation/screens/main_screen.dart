import 'dart:async';

import 'package:cat_tinder/representation/bloc/swipeable_cats_bloc/bloc.dart';
import 'package:cat_tinder/representation/widgets/network/network_status_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/injection.dart';
import '../../domain/entities/cat.dart';
import '../../domain/services/i_internet_connection_service.dart';
import '../bloc/liked_cats_bloc/bloc.dart';
import '../bloc/network_status_bloc/bloc.dart';
import '../bloc/network_status_bloc/states.dart';
import '../bloc/swipeable_cats_bloc/events.dart' as swipeable_cats;
import '../bloc/liked_cats_bloc/events.dart' as liked_cats;
import '../widgets/common/verdict_button.dart';
import '../widgets/notifications/cat_alert.dart';
import '../widgets/notifications/likes_counter.dart';
import '../widgets/cats/cat_cards_stack.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _dislikeAction() {
    getIt<SwipeableCatsBloc>().add(swipeable_cats.DislikeAction());
    getIt<LikedCatsBloc>().add(liked_cats.DislikeAction());
  }

  void _likeAction() async {
    final cats = getIt<SwipeableCatsBloc>().cats;
    await cats.last
        .timeout(Duration(microseconds: 1))
        .then((Cat cat) {
          getIt<SwipeableCatsBloc>().add(swipeable_cats.LikeAction());
          getIt<LikedCatsBloc>().add(liked_cats.LikeAction());
        })
        .catchError((error) {
          if (error is TimeoutException) {
            return;
          }
          if (mounted) {
            showDialog(
              context: context,
              builder: (_) {
                return const CatAlert();
              },
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NetworkStatusBloc>(
      create: (_) => getIt.get<NetworkStatusBloc>(),
      child: ScaffoldMessenger(
        child: Scaffold(
          appBar: AppBar(
            leading: BlocBuilder<NetworkStatusBloc, NetworkStatusState>(
              builder: (context, state) {
                if (state is NetworkStatusReady) {
                  switch (state.connectionStatus) {
                    case ConnectionStatus.connected:
                      return NetworkStatusIcon(status: NetworkStatus.connected);
                    case ConnectionStatus.disconnected:
                      return NetworkStatusIcon(
                        status: NetworkStatus.disconnected,
                      );
                  }
                }
                return Placeholder();
              },
            ),
            title: Text('Cat Tinder'),
            centerTitle: true,
          ),
          body: BlocBuilder<NetworkStatusBloc, NetworkStatusState>(
            builder: (context, state) {
              if (state is NetworkStatusReady) {
                switch (state.connectionStatus) {
                  case ConnectionStatus.disconnected:
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Нет подключения к интернету",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.fixed,
                          duration: Duration(days: 1),
                        ),
                      );
                    });
                  case ConnectionStatus.connected:
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    });
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 30, 50, 20),
                    child: CatCardsStack(
                      callbackLeft: () {
                        getIt<LikedCatsBloc>().add(liked_cats.DislikeAction());
                      },
                      callbackRight: () {
                        getIt<LikedCatsBloc>().add(liked_cats.LikeAction());
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: VerdictButton(
                          verdict: Verdict.dislike,
                          callback: _dislikeAction,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: VerdictButton(
                          verdict: Verdict.like,
                          callback: _likeAction,
                        ),
                      ),
                    ],
                  ),
                  LikesCounter(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
