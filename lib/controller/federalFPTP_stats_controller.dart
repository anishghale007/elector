import 'package:elector/controller/federal_provider.dart';
import 'package:elector/models/federal_election.dart';
import 'package:get/get.dart';

class FederalFPTPStatsController extends GetxController {
  final FederalProvider federal = FederalProvider();

  var stats = Future.value(<FederalFPTPStats>[]).obs;

  @override
  void onInit() {
    stats.value = federal.getFederalFPTPStats();
    super.onInit();
  }
}
