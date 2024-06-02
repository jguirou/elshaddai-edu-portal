

class CustomPlatformExceptions implements Exception {
  final String code;
  CustomPlatformExceptions(this.code);

  String get message {
    switch(code){
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      case 'invalid-password':
        return 'Invalid password. Please try again.';
      case 'invalid-phone-number':
        return 'The provide phone number is invalid.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Contact support for assistance';
      case 'session-cooke-expired':
        return 'The Firebase session cookie has expired. Please sign in again.';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.';
      case 'sign_in_failed':
        return 'Sign-in failed. Please try again.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'internal-error':
        return 'An internal authentication error occurred. Please try again later.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';




      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is to weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';

      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'email-already-exists':
        return 'The email address already exists. Please use a different email.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';

      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';
      case 'credentials-already-in-use':
        return 'The credential is already associated with a different user account.';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';



      case 'missing-app-credential':
        return 'The app credential is missing. Please provide valid app credentials.';


      case 'web-storage-unsupported':
        return 'Web storage is not supported or is disabled. Please provide valid app credentials.';
      case 'app-deleted':
        return 'The instance of FirebaseApp has been deleted.';
      case 'user-token-mismatch':
        return 'The provide user \'s token has a mismatch with the authenticated user \'s user ID.';
      case 'invalid-message-payload':
        return 'The email template verification message payload is invalid.';
      case 'invalid-sender':
        return 'The email template sender is invalid. Please verify the sender \'s email.';
      case 'invalid-recipient-email':
        return 'The  recipient email address is invalid. Please provide a valid recipient email.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code.';
      case 'user-token-expired':
        return 'The user \'s token has expired, and authentication is required. Please sign in again.';

      case 'expired-action-code':
        return 'The action code has expired. Please request a new action.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'credential-already-in-use':
        return 'The credential is already associated with a different user account.';
      default:
        return 'An unexpected Firebase error occurred. Please try again.';

    }
  }
}