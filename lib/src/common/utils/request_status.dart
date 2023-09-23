import '../error/failures.dart';

abstract class RequestStatus {
  const RequestStatus();
}

class InitialRequestStatus extends RequestStatus {
  const InitialRequestStatus();
}

class RequestSubmitting extends RequestStatus {
  const RequestSubmitting();
}

class SubmissionSuccess extends RequestStatus {
  const SubmissionSuccess();
}

class SubmissionFailed extends RequestStatus {
  final Failure failure;

  SubmissionFailed(this.failure);
}
