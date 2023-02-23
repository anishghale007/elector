import 'package:elector/controller/provincial%20controller/sudurpaschim_provider.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:get/get.dart';

class SudurpaschimPRStatsController extends GetxController {
  final SudurpaschimProvider provincial = SudurpaschimProvider();

  var stats = Future.value(<ProvincialPRStats>[]).obs;

  @override
  void onInit() {
    stats.value = provincial.getProvincialPRtats();
    super.onInit();
  }
}
