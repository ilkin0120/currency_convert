import 'package:shared_preferences/shared_preferences.dart';

abstract class SymbolsPreferencesBase {
  Future setSymbols(List<String> symbols);

  Future getSymbols();
}

class SymbolsPreferences implements SymbolsPreferencesBase {
  @override
  Future setSymbols(List<String> symbols) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('symbols', symbols);
  }

  @override
  Future<List<String>> getSymbols() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('symbols') ?? [];
  }
}
