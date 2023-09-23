import 'package:currency_conv/src/features/home/shared_preferences/symbols_preferences.dart';
import 'package:dio/dio.dart';

import '../../../../common/error/exceptions.dart';
import '../../../../config/config.dart';

abstract class HomeServiceBase {
  Future<List<String>> getAllSymbols();

  Future<List<String>> getAllSymbolsOffline();

  Future<double> convert(String fromValue, String toSymbol, String fromSymbol);
}

class HomeService implements HomeServiceBase {
  const HomeService();

  @override
  Future<List<String>> getAllSymbols() async {
    try {
      final dio = Dio();
      final response = await dio.get('${Configs.apiLink}/currencies.json');
      return (response.data as Map).keys.toList() as List<String>;
    } catch (e) {
      throw OtherException();
    }
  }

  @override
  Future<double> convert(fromValue, toSymbol, fromSymbol) async {
    Future.delayed(const Duration(seconds: 1));
    return 1.7;
  }

  @override
  Future<List<String>> getAllSymbolsOffline() async {
    SymbolsPreferences symbolsPreferences = SymbolsPreferences();
    return symbolsPreferences.getSymbols();
  }
}
