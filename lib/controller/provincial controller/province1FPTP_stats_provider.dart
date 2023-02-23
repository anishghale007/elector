import 'package:elector/controller/provincial%20controller/province1_provider.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:get/get.dart';

class Province1FPTPStatsController extends GetxController {

  final Province1Provider provincial = Province1Provider();

  var stats = Future.value(<ProvincialFPTPStats>[]).obs;

  @override
  void onInit() {
    stats.value = provincial.getProvincialFPTPStats();
    super.onInit();
  }
}
