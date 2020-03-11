class InvalidAnimationAttempt implements Exception {
  String cause;
  InvalidAnimationAttempt(this.cause);
}