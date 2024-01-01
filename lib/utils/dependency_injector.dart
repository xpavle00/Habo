import 'package:habo/repositories/habo_local_repo.dart';
import 'package:habo/repositories/habo_remote_repo.dart';
import 'package:habo/repositories/habo_repository.dart';

class DependencyInjector {
  static HaboLocalRepository? _haboLocalRepository;
  static HaboRemoteRepository? _haboRemoteRepository;
  static HaboRepository? _haboRepository;

  static Future<HaboLocalRepository> getHaboLocalRepository() async{
    _haboLocalRepository ??= await HaboLocalRepository.create();
    return _haboLocalRepository!;
  }

  static HaboRemoteRepository getHaboRemoteRepository() {
    _haboRemoteRepository ??= HaboRemoteRepository();
    return _haboRemoteRepository!;
  }

  static Future<HaboRepository> getHaboRepository() async {
    _haboRepository ??= HaboRepository(
        localRepo: await getHaboLocalRepository(),
        remoteRepo: getHaboRemoteRepository());

    return _haboRepository!;
  }
}
