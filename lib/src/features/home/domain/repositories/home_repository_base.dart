import '../../../../common/error/either.dart';
import '../../../../common/error/failures.dart';

abstract class HomeRepositoryBase {
  Future<Either<Failure, List<String>>> getAllSymbols();
  Future<Either<Failure, double>> convert(String fromValue, String toSymbol, String fromSymbol);
}
