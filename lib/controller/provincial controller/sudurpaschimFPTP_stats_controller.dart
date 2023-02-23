import 'package:elector/controller/provincial%20controller/sudurpaschim_provider.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:get/get.dart';

class SudurpaschimFPTPStatsController extends GetxController {

  final SudurpaschimProvider provincial = SudurpaschimProvider();

  var stats = Future.value(<ProvincialFPTPStats>[]).obs;

  @override
  void onInit() {
    stats.value = provincial.getProvincialFPTPStats();
    super.onInit();
  }
}
