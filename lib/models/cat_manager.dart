import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cat.dart';
import 'breed.dart';
import 'dart:math';

class CatManager {
  static final instance = CatManager();
  Map<String, Breed> breeds = {};
  List<String> breedsIDs = [];
  final client = http.Client();
  final breedsUrl = Uri.parse('https://api.thecatapi.com/v1/breeds');
  final catUrl = Uri.parse('https://api.thecatapi.com/v1/images/search');
  final catNotFoundUrl = Uri.parse(
    'https://i.pinimg.com/736x/d8/ac/f8/d8acf86da7d512c130ac1bf2cb2fe39e.jpg',
  );

  CatManager();

  Future<Cat> getRandomCat() async {
    await initBreeds();
    final breedInd = Random().nextInt(breedsIDs.length);
    final breedID = breedsIDs[breedInd];
    final queryParameters = {'breed_ids': breedID};
    final resultUrl = catUrl.replace(queryParameters: queryParameters);
    final response = await client.get(resultUrl);
    Map<String, dynamic> catMap = jsonDecode(response.body)[0];
    final imageUrlDynamic = catMap['url'];
    final Uri imageUrl;
    if (imageUrlDynamic is! String) {
      imageUrl = catNotFoundUrl;
    } else {
      imageUrl = Uri.parse(imageUrlDynamic);
    }
    return Cat(imageUrl: imageUrl, breedID: breedID);
  }

  Future<void> initBreeds() async {
    if (breeds.isNotEmpty) {
      return;
    }
    final response = await client.get(breedsUrl);
    final List<dynamic> data = jsonDecode(response.body);
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
        name: breedName,
        description: breedDescription,
        temperament: breedTemperament,
        origin: breedOrigin,
      );
    }
    breedsIDs = breeds.keys.toList();
    breeds["error"] = Breed.error;
  }

  void dispose() {
    client.close();
  }
}
