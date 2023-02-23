import 'package:elector/controller/provincial%20controller/madhesh_provider.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:get/get.dart';

class MadheshPRStatsController extends GetxController {
  final MadheshProvider provincial = MadheshProvider();

  var stats = Future.value(<ProvincialPRStats>[]).obs;

  @override
  void onInit() {
    stats.value = provincial.getProvincialPRtats();
    super.onInit();
  }
}
