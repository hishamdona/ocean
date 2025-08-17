import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final userServiceProvider = Provider<UserService>((ref) => UserService());

final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  final userService = ref.watch(userServiceProvider);
  
  return authService.authStateChanges.asyncMap((firebaseUser) async {
    if (firebaseUser == null) return null;
    
    try {
      return await userService.getUserById(firebaseUser.uid);
    } catch (e) {
      return null;
    }
  });
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).when(
    data: (user) => user,
    loading: () => null,
    error: (_, __) => null,
  );
});

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(
    ref.watch(authServiceProvider),
    ref.watch(userServiceProvider),
  ),
);

class AuthController extends StateNotifier<AuthState> {
  final AuthService _authService;
  final UserService _userService;

  AuthController(this._authService, this._userService) : super(const AuthState.initial());

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = const AuthState.loading();
    
    try {
      final firebaseUser = await _authService.signInWithEmailAndPassword(email, password);
      final user = await _userService.getUserById(firebaseUser.uid);
      state = AuthState.success(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    UserRole role = UserRole.buyer,
  }) async {
    state = const AuthState.loading();
    
    try {
      final firebaseUser = await _authService.signUpWithEmailAndPassword(email, password);
      
      final user = User(
        id: firebaseUser.uid,
        email: email,
        fullName: fullName,
        role: role,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await _userService.createUser(user);
      state = AuthState.success(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    
    try {
      await _authService.signOut();
      state = const AuthState.initial();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    state = const AuthState.loading();
    
    try {
      await _authService.resetPassword(email);
      state = const AuthState.initial();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}

class AuthState {
  const AuthState();
  
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success(User user) = _Success;
  const factory AuthState.error(String message) = _Error;
  
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(User user) success,
    required T Function(String message) error,
  }) {
    if (this is _Initial) return initial();
    if (this is _Loading) return loading();
    if (this is _Success) return success((this as _Success).user);
    if (this is _Error) return error((this as _Error).message);
    throw Exception('Unknown state');
  }
}

class _Initial extends AuthState {
  const _Initial();
}

class _Loading extends AuthState {
  const _Loading();
}

class _Success extends AuthState {
  final User user;
  const _Success(this.user);
}

class _Error extends AuthState {
  final String message;
  const _Error(this.message);
}