import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supa = Supabase.instance.client;

  Future<AuthResponse> login(String email, String password) async {
    return await supa.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await supa.auth.signOut();
  }


  Future<String> getRoleByEmail(String email) async {
    final data = await supa
    .from('users')
    .select('role')
    .ilike('email', email)
    .maybeSingle();
    print("QUERY ROLE UNTUK EMAIL: [$email]");
    print("HASIL QUERY DARI SUPABASE: $data");
    print("EMAIL YANG DIKIRIM DARI LOGIN: [$email]");

    if (data == null) {
      throw Exception("Role tidak ditemukan untuk email: $email");
    }

    return data['role'];
  }

  Future<String> getRole() async {
    final uid = supa.auth.currentUser?.id;

    if (uid == null) throw Exception("User belum login");

    final data = await supa
        .from('users')
        .select('role')
        .eq('id', uid)
        .maybeSingle();

    if (data == null) {
      throw Exception("Role tidak ditemukan untuk UID: $uid");
    }

    return data['role'];
  }
}
