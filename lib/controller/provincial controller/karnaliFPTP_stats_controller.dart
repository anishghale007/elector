import 'package:elector/controller/provincial%20controller/karnali_provider.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:get/get.dart';

class KarnaliFPTPStatsController extends GetxController {

  final KarnaliProvider provincial = KarnaliProvider();

  var stats = Future.value(<ProvincialFPTPStats>[]).obs;

  @override
  void onInit() {
    stats.value = provincial.getProvincialFPTPStats();
    super.onInit();
  }
}
