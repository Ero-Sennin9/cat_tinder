import 'dart:convert';
import 'dart:math';

import 'package:cat_tinder/domain/repositories/i_breeds_repository.dart';
import 'package:cat_tinder/domain/repositories/i_cats_repository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../../domain/entities/cat.dart';

@Singleton(as: ICatsRepository)
class CatsRepository implements ICatsRepository {
  final IBreedsRepository _breedsRepository;

  final _client = http.Client();
  final _catsUrl = Uri.parse('https://api.thecatapi.com/v1/images/search');

  final catNotFoundUrl = Uri.parse(
    'https://i.pinimg.com/736x/d8/ac/f8/d8acf86da7d512c130ac1bf2cb2fe39e.jpg',
  );

  CatsRepository(this._breedsRepository);

  @override
  Future<Cat> get() async {
    final allBreeds = await _breedsRepository.getAll();
    final breedInd = Random().nextInt(allBreeds.length);
    final breed = allBreeds[breedInd];
    final breedID = breed.id;

    final queryParameters = {'breed_ids': breedID};
    final resultUrl = _catsUrl.replace(queryParameters: queryParameters);
    final response = await _client.get(resultUrl);

    Map<String, dynamic> catMap = jsonDecode(response.body)[0];
    final imageUrlDynamic = catMap['url'];
    final Uri imageUrl;
    if (imageUrlDynamic is! String) {
      imageUrl = catNotFoundUrl;
    } else {
      imageUrl = Uri.parse(imageUrlDynamic);
    }

    return Cat(imageUrl: imageUrl, breed: breed);
  }

  void dispose() {
    _client.close();
  }
}
