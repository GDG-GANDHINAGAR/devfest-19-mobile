import 'package:devfest_gandhinagar/home/speaker.dart';
import 'package:devfest_gandhinagar/network/i_client.dart';
import 'package:devfest_gandhinagar/utils/dependency_injection.dart';
import 'package:devfest_gandhinagar/utils/devfest.dart';

abstract class IHomeProvider {
  Future<SpeakersData> getSpeakers();
}

class HomeProvider implements IHomeProvider {
  IClient _client;

  static final String kConstGetSpeakersUrl =
      "${Devfest.baseUrl}/speaker-kol.json";

  HomeProvider() {
    _client = Injector().currentClient;
  }

  @override
  Future<SpeakersData> getSpeakers() async {
    var result = await _client.getAsync(kConstGetSpeakersUrl);
    if (result.networkServiceResponse.success) {
      SpeakersData res = SpeakersData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }
}
