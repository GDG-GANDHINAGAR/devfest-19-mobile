import 'package:devfest_gandhinagar/home/home_provider.dart';
import 'package:devfest_gandhinagar/network/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(("Api tests"), () {});
  test(
    "Fetch Speakers List",
    () async {
      IClient _client = RestClient();
      final res = await _client.getAsync(HomeProvider.kConstGetSpeakersUrl);
      print(res.mappedResult);
      expect(res.networkServiceResponse.success, true);
    },
  );
}
