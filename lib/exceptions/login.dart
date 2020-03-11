class InvalidLoginWorkFlowException implements Exception {
  String cause;
  InvalidLoginWorkFlowException(this.cause);
}

class InvalidAnimationAttempt implements Exception {
  String cause;
  InvalidAnimationAttempt(this.cause);
}

class InvalidPassordOrResetMsg implements Exception {
  String cause;
  InvalidPassordOrResetMsg(this.cause);
}
