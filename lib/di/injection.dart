import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../data/object_box/objectbox.g.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: 'init', ignoreUnregisteredTypes: [Store])
Future<void> configureDependencies() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();

  getIt.registerSingletonAsync<Store>(() async {
    final likedCatsStore = await openStore(
      directory: join(documentsDirectory.path, 'liked_cats'),
    );
    return likedCatsStore;
  }, instanceName: "liked_cats_store");

  getIt.registerSingletonAsync<Store>(() async {
    final dislikedCatsStore = await openStore(
      directory: join(documentsDirectory.path, 'disliked_cats'),
    );
    return dislikedCatsStore;
  }, instanceName: "disliked_cats_store");

  await getIt.allReady();
  getIt.init();
}
