class InvalidLoginWorkFlow implements Exception {
  String cause;
  InvalidLoginWorkFlow(this.cause);
}

class InvalidAnimationAttempt implements Exception {
  String cause;
  InvalidAnimationAttempt(this.cause);
}

class InvalidPassordOrResetMsg implements Exception {
  String cause;
  InvalidPassordOrResetMsg(this.cause);
}

class UnknownPasswordResetError implements Exception {
  String cause;
  UnknownPasswordResetError(this.cause);
}

class IllegalLabelStatus implements Exception {
  String cause;
  IllegalLabelStatus(this.cause);
}