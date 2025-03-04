import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_im_v00r01/product/state/base/base_cubit.dart';
import 'package:x_im_v00r01/product/state/view_model/auth_state.dart';

class AuthCubit extends BaseCubit<BaseAuthState> {
  AuthCubit(this.supabase) : super(AuthInitial()) {
    _authListener();
  }
  final SupabaseClient supabase;

  void _authListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session != null) {
        emit(AuthAuthenticated(session.user));
      } else if (event == AuthChangeEvent.signedOut) {
        emit(AuthUnauthenticated());
      } else {
        emit(AuthError('Bilinmeyen kimlik doğrulama durumu.'));
      }
    });
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
