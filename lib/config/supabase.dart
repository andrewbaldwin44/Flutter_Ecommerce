import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shopper/secrets.dart';

Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
}

final supabase = Supabase.instance.client;
