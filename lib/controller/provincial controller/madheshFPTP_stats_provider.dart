import 'package:elector/controller/provincial%20controller/madhesh_provider.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:get/get.dart';

class MadheshFPTPStatsController extends GetxController {

  final MadheshProvider provincial = MadheshProvider();

  var stats = Future.value(<ProvincialFPTPStats>[]).obs;

  @override
  void onInit() {
    stats.value = provincial.getProvincialFPTPStats();
    super.onInit();
  }
}
