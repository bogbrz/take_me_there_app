import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:take_me_there_app/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://gatyxvffvaqpljtifmpa.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdhdHl4dmZmdmFxcGxqdGlmbXBhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY3MTA3MDQsImV4cCI6MjAzMjI4NjcwNH0.XdDiCkoRE6DxjUsSp1GLT7mJ68do36XVA7GZGH9HI2E',
  );
  await Permission.locationWhenInUse.isDenied.then((valueOfPermission) {
    if (valueOfPermission) {
      Permission.locationWhenInUse.request();
    }
  });
  runApp(ProviderScope(child: MyApp()));
}
