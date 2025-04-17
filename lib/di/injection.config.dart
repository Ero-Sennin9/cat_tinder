// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cat_tinder/data/repositories/breeds_repository.dart' as _i819;
import 'package:cat_tinder/data/repositories/cats_repository.dart' as _i181;
import 'package:cat_tinder/data/repositories/liked_cats_repository.dart'
    as _i708;
import 'package:cat_tinder/domain/repositories/i_breeds_repository.dart'
    as _i671;
import 'package:cat_tinder/domain/repositories/i_cats_repository.dart' as _i580;
import 'package:cat_tinder/domain/repositories/i_liked_cats_repository.dart'
    as _i1033;
import 'package:cat_tinder/domain/usecases/delete_liked_cat_use_case.dart'
    as _i747;
import 'package:cat_tinder/domain/usecases/dislike_cat_use_case.dart' as _i569;
import 'package:cat_tinder/domain/usecases/get_cat_breed_use_case.dart'
    as _i199;
import 'package:cat_tinder/domain/usecases/get_cat_use_case.dart' as _i614;
import 'package:cat_tinder/domain/usecases/get_liked_cats_use_case.dart'
    as _i464;
import 'package:cat_tinder/domain/usecases/like_cat_use_case.dart' as _i970;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i671.IBreedsRepository>(() => _i819.BreedsRepository());
    gh.singleton<_i1033.ILikedCatsRepository>(
      () => _i708.LikedCatsRepository(),
    );
    gh.singleton<_i580.ICatsRepository>(
      () => _i181.CatsRepository(gh<_i671.IBreedsRepository>()),
    );
    gh.factory<_i199.GetCatBreedUseCase>(
      () => _i199.GetCatBreedUseCase(gh<_i671.IBreedsRepository>()),
    );
    gh.factory<_i614.GetCatUseCase>(
      () => _i614.GetCatUseCase(gh<_i580.ICatsRepository>()),
    );
    gh.factory<_i747.DeleteLikedCatUseCase>(
      () => _i747.DeleteLikedCatUseCase(gh<_i1033.ILikedCatsRepository>()),
    );
    gh.factory<_i970.LikeCatUseCase>(
      () => _i970.LikeCatUseCase(gh<_i1033.ILikedCatsRepository>()),
    );
    gh.factory<_i569.DislikeCatUseCase>(
      () => _i569.DislikeCatUseCase(gh<_i1033.ILikedCatsRepository>()),
    );
    gh.factory<_i464.GetLikedCatsUseCase>(
      () => _i464.GetLikedCatsUseCase(gh<_i1033.ILikedCatsRepository>()),
    );
    return this;
  }
}
