class InvalidLoginWorkFlowException implements Exception {
  String cause;
  InvalidLoginWorkFlowException(this.cause);
}
