class LoginStatus {
  final String? message;

  // Constructor for when a message is provided
  LoginStatus.withMessage(this.message);

  // Constructor for when no message is provided
  LoginStatus.noMessage() : message = null;
}
