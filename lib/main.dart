import 'package:flutter/material.dart';

import 'app.dart';
import 'package:movierse/injection.dart' as di;

void main() {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}


