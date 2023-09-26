import 'package:currency_conv/src/common/error/either.dart';
import 'package:currency_conv/src/common/error/failures.dart';
import 'package:currency_conv/src/features/home/data/services/home_service.dart';
import 'package:currency_conv/src/features/home/domain/repositories/home_repository_base.dart';
import 'package:currency_conv/src/features/home/shared_preferences/symbols_preferences.dart';

import '../../../../common/utils/network_checker.dart';

class HomeRepository implements HomeRepositoryBase {
  final homeService = const HomeService();
  final networkChecker = NetworkChecker();

  @override
  Future<Either<Failure, List<String>>> getAllSymbols() async {
    final isConnected = await networkChecker.checkInternetConnectivity();
    if (isConnected) {
      try {
        final result = await homeService.getAllSymbols();
        SymbolsPreferences symbolsPreferences = SymbolsPreferences();
        symbolsPreferences.setSymbols(result);
        return Success(result);
      } catch (e) {
        return Error(OtherFailure());
      }
    } else {
      final result = await homeService.getAllSymbolsOffline();
      if (result.isNotEmpty) {
        return Success(result);
      }
      return Error(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, double>> convert(
    String fromValue,
    String toSymbol,
    String fromSymbol,
  ) async {
    final isConnected = await networkChecker.checkInternetConnectivity();
    if (isConnected) {
      try {
        final result = await homeService.convert(
          fromValue,
          toSymbol,
          fromSymbol,
        );
        return Success(result);
      } catch (e) {
        return Error(OtherFailure());
      }
    } else {
      return Error(NetworkFailure());
    }
  }
}
