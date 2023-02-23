import 'package:elector/controller/provincial%20controller/bagmati_provider.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:get/get.dart';

class BagmatiPRStatsController extends GetxController {
  final BagmatiProvider provincial = BagmatiProvider();

  var stats = Future.value(<ProvincialPRStats>[]).obs;

  @override
  void onInit() {
    stats.value = provincial.getProvincialPRtats();
    super.onInit();
  }
}
