import 'package:elector/controller/provincial%20controller/karnali_provider.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:get/get.dart';

class KarnaliPRStatsController extends GetxController {
  final KarnaliProvider provincial = KarnaliProvider();

  var stats = Future.value(<ProvincialPRStats>[]).obs;

  @override
  void onInit() {
    stats.value = provincial.getProvincialPRtats();
    super.onInit();
  }
}
