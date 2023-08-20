import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:uicn/services/storage_services.dart';
import '../firebase_options.dart';
import 'api/api_client.dart';
import 'api_services.dart';

class Global {
  static late StorageServices storageServices;
  static late ApiClient apiClient;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    storageServices = await StorageServices().init();
    apiClient = ApiServices().init();
  }
}
