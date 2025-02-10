
abstract class Failure {
  @override
  List<Object?> get props => [getMessage()];

  String getMessage() {
    throw UnimplementedError();
  }
}



class OfflineFailure extends Failure {
  @override
  String getMessage() => "No internet connection";
}

class EmptyCacheFailure extends Failure {
  @override
  String getMessage() => "Error in cache";
}

class ServerFailure extends Failure {
  final Exception error;

  ServerFailure({
    required this.error,
  });

  @override
  String getMessage() => error.toString();
}
