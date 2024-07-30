class SignUp_AccountFailure {
  final String message;

  const SignUp_AccountFailure([this.message = 'Đã xảy ra lỗi không xác định']);

  factory SignUp_AccountFailure.code(String code) {
    switch (code) {
      case 'invalid-credential':
        return const SignUp_AccountFailure('Thông tin không chính xác');
      case 'too-many-requests':
        return const SignUp_AccountFailure('Vui lòng thử sau ít phút');
      case 'user-not-found':
        return const SignUp_AccountFailure('Tài khoản không tồn tại');
      case 'wrong-password':
        return const SignUp_AccountFailure('Mật khẩu không chính xác');
      case 'weak-password':
        return const SignUp_AccountFailure('Vui lòng thử mật khẩu mạnh hơn');
      case 'invalid-password':
        return const SignUp_AccountFailure('Mật khẩu không chính xác');
      case 'invalid-email':
        return const SignUp_AccountFailure(
            'Email không chính xác hoặc sai định dạng');
      case 'internal-error':
        return const SignUp_AccountFailure('Vui lòng quay lại sau ít phút');
      case 'uid-already-exists':
        return const SignUp_AccountFailure('Người dùng đã tồn tại');
      case 'email-already-in-use':
        return const SignUp_AccountFailure('Email đã tồn tại');
      case 'operation-not-allowed':
        return const SignUp_AccountFailure('Hoạt động không cho phép');
      case 'user-disable':
        return const SignUp_AccountFailure('Tài khoản không khả dụng');
      default:
        return const SignUp_AccountFailure();
    }
  }
}
