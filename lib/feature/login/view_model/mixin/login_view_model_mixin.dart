

/// Mixin for login view model functionality.
mixin LoginViewModelMixin {
  bool _isLoading = false;

  void startLoading() {
    _isLoading = true;
  }

  void stopLoading() {
    _isLoading = false;
  }

  Future<void> _performLogin(String username, String password) async {
    startLoading();
    try {
      // Add your login logic here
      await Future<void>.delayed(const Duration(seconds: 2));
      print('Login successful');
    } catch (e) {
      print('Login failed: $e');
    } finally {
      stopLoading();
    }
  }
}
