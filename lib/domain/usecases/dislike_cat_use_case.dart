import 'package:injectable/injectable.dart';

import '../entities/cat.dart';

@injectable
class DislikeCatUseCase {
  Future<void> execute(Cat cat) { return Future<void>.value(); }
}
