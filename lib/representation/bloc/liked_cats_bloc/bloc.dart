import 'package:cat_tinder/representation/bloc/liked_cats_bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'events.dart';

@singleton
class LikedCatsBloc extends Bloc<LikedCatsEvent, LikedCatsState> {


  LikedCatsBloc() : super(LikedCatsInitial()) {

  }
}