import 'package:elector/controller/provincial%20controller/lumbini_provider.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:get/get.dart';

class LumbiniFPTPStatsController extends GetxController {

  final LumbiniProvider provincial = LumbiniProvider();

  var stats = Future.value(<ProvincialFPTPStats>[]).obs;

  @override
  void onInit() {
    stats.value = provincial.getProvincialFPTPStats();
    super.onInit();
  }
}
