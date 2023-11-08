import 'package:flutter/material.dart';

// pub dev
import 'package:intl/date_symbol_data_local.dart';

// pub dev
import 'package:firebase_core/firebase_core.dart';

@immutable
class AppStart {
  const AppStart._();

  static Future<void> initStart() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    initializeDateFormatting('tr_TR', null); // Türkçe dil ayarlarını başlatın
  }
}
