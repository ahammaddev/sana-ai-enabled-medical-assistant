import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sana/app/utils/constants/helpers/custom_snackbar.dart';
import 'package:sana/app/utils/constants/helpers/log_message.dart';

class GlobalController extends GetxController {
  RxBool isNetAvailable = false.obs;

  Future<bool> checkInternetConnectivity() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity()
        .checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      isNetAvailable.value = true;
      return isNetAvailable.value;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      isNetAvailable.value = true;
      return isNetAvailable.value;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      isNetAvailable.value = false;
      return isNetAvailable.value;
    } else {
      isNetAvailable.value = false;
      return isNetAvailable.value;
    }
  }

  void appStatus() async {
    final status = await checkInternetConnectivity();
    if (status == false) {
      LogMessage.printLogMessage(
        title: 'Failed',
        message: 'No internet connection.',
      );
      CustomSnackbars.failure(
        title: 'Failed',
        message: 'No internet connection.',
      );
    }
  }

  @override
  void onInit() {
    appStatus();
    super.onInit();
  }
}
