import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final userServiceProvider = Provider<UserService>((ref) => UserService());

final authStateProvider = StateNotifierProvider<AuthStateNotifier, User?>((ref) {
  return AuthStateNotifier(ref.read(authServiceProvider), ref.read(userServiceProvider));
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider);
});

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(
    ref.watch(authServiceProvider),
    ref.watch(userServiceProvider),
    ref.watch(authStateProvider.notifier),
  ),
);

class AuthStateNotifier extends StateNotifier<User?> {
  final AuthService _authService;
  final UserService _userService;

  AuthStateNotifier(this._authService, this._userService) : super(null) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');
      if (userId != null) {
        final user = await _userService.getUserById(userId);
        state = user;
      }
    } catch (e) {
      // User not found or error loading
      state = null;
    }
  }

  Future<void> setUser(User user) async {
    state = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', user.id);
  }

  Future<void> clearUser() async {
    state = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
  }
}

class AuthController extends StateNotifier<AuthState> {
  final AuthService _authService;
  final UserService _userService;
  final AuthStateNotifier _authStateNotifier;

  AuthController(this._authService, this._userService, this._authStateNotifier) 
      : super(const AuthState.initial());

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = const AuthState.loading();
    
    try {
      final result = await _authService.signInWithEmailAndPassword(email, password);
      final user = await _userService.getUserById(result['uid']);
      await _authStateNotifier.setUser(user);
      state = AuthState.success(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    UserRole role = UserRole.buyer,
  }) async {
    state = const AuthState.loading();
    
    try {
      final result = await _authService.signUpWithEmailAndPassword(email, password);
      
      final user = User(
        id: result['uid'],
        email: email,
        fullName: fullName,
        phoneNumber: phoneNumber,
        role: role,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await _userService.createUser(user);
      await _authStateNotifier.setUser(user);
      state = AuthState.success(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    
    try {
      final result = await _authService.signInWithGoogle();
      
      // Check if user exists, if not create new user
      User user;
      try {
        user = await _userService.getUserById(result['uid']);
      } catch (e) {
        // User doesn't exist, create new one
        user = User(
          id: result['uid'],
          email: result['email'],
          fullName: result['displayName'] ?? 'Google User',
          role: UserRole.buyer,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _userService.createUser(user);
      }
      
      await _authStateNotifier.setUser(user);
      state = AuthState.success(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    
    try {
      await _authService.signOut();
      await _authStateNotifier.clearUser();
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

  Future<bool> verifyOTP(String otp) async {
    try {
      return await _authService.verifyOTP(otp);
    } catch (e) {
      return false;
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