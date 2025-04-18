import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../../domain/entities/breed.dart';
import '../../../domain/entities/cat.dart';
import '../../navigation/navigation_manager.dart';
import '../notifications/network_alert.dart';
import 'cat_image.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CatCard extends StatelessWidget {
  final Future<Cat> catFuture;
  final Function() action;
  static const _roundRadius = 15.0;

  const CatCard({required this.catFuture, required this.action, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_roundRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_roundRadius),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: FutureBuilder(
                  future: catFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      if (snapshot.error is SocketException ||
                          snapshot.error is TimeoutException) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          showDialog(
                            context: context,
                            builder: (_) => const NetworkAlert(),
                          );
                        });
                      }
                      return CatImage(cat: Cat.error);
                    }
                    if (!snapshot.hasData) {
                      return SizedBox(
                        width: double.infinity,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        NavigationManager.instance.navigator.pushNamed(
                          RouteNames.catDescription,
                          arguments: snapshot.data!,
                        );
                      },
                      child: CatImage(cat: snapshot.data!),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: SizedBox(
                    height: 35,
                    child: FutureBuilder(
                      future: catFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            Breed.error.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 25,
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return LoadingIndicator(
                            indicatorType: Indicator.ballPulse,
                            colors: [Colors.black],
                            strokeWidth: 2,
                          );
                        }
                        return Text(
                          snapshot.data!.breed.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
