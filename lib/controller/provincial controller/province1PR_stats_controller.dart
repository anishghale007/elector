import 'package:elector/controller/provincial%20controller/province1_provider.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:get/get.dart';

class Province1PRStatsController extends GetxController {
  final Province1Provider provincial = Province1Provider();

  var stats = Future.value(<ProvincialPRStats>[]).obs;

  @override
  void onInit() {
    stats.value = provincial.getProvincialPRtats();
    super.onInit();
  }
}
