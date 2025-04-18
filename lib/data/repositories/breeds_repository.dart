import 'dart:convert';

import 'package:cat_tinder/domain/repositories/i_breeds_repository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../../domain/entities/breed.dart';

@Singleton(as: IBreedsRepository)
class BreedsRepository implements IBreedsRepository {
  late final Future<Map<String, Breed>> _breeds;
  final _client = http.Client();
  final _breedsUrl = Uri.parse('https://api.thecatapi.com/v1/breeds');

  BreedsRepository() {
    _breeds = _getBreeds();
  }

  @override
  Future<List<Breed>> getAll() async {
    final breeds = await _breeds;
    return breeds.values.toList();
  }

  Future<Map<String, Breed>> _getBreeds() async {
    final response = await _client.get(_breedsUrl);
    final List<dynamic> data = jsonDecode(response.body);

    final Map<String, Breed> breeds = {};
    for (final breedMap in data) {
      if (breedMap is! Map<String, dynamic>) {
        continue;
      }

      final breedID = breedMap["id"];
      final breedName = breedMap["name"];
      final breedDescription = breedMap["description"];
      final breedTemperament = breedMap["temperament"];
      final breedOrigin = breedMap["origin"];
      if (breedID is! String ||
          breedName is! String ||
          breedDescription is! String ||
          breedTemperament is! String ||
          breedOrigin is! String) {
        continue;
      }

      breeds[breedID] = Breed(
        id: breedID,
        name: breedName,
        description: breedDescription,
        temperament: breedTemperament,
        origin: breedOrigin,
      );
    }
    return breeds;
  }

  void dispose() {
    _client.close();
  }
}
