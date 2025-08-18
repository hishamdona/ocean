class AuthService {
  // Dummy user for testing
  static const String _dummyEmail = 'test@ocean.com';
  static const String _dummyPassword = 'password123';
  
  Future<Map<String, dynamic>> signInWithEmailAndPassword(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (email == _dummyEmail && password == _dummyPassword) {
      return {
        'uid': 'dummy_user_123',
        'email': email,
        'success': true,
      };
    } else {
      throw Exception('Invalid email or password');
    }
  }

  Future<Map<String, dynamic>> signUpWithEmailAndPassword(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Always succeed for demo purposes
    return {
      'uid': 'dummy_user_${DateTime.now().millisecondsSinceEpoch}',
      'email': email,
      'success': true,
    };
  }

  Future<void> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> resetPassword(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updatePassword(String newPassword) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updateEmail(String newEmail) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> deleteAccount() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Always succeed for demo purposes
    return {
      'uid': 'google_user_${DateTime.now().millisecondsSinceEpoch}',
      'email': 'google.user@gmail.com',
      'displayName': 'Google User',
      'success': true,
    };
  }

  Future<bool> verifyOTP(String otp) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Accept any 6-digit OTP for demo
    return otp.length == 6 && RegExp(r'^\d+$').hasMatch(otp);
  }
}