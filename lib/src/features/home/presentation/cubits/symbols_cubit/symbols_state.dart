part of 'symbols_cubit.dart';



class SymbolsState {
  RequestStatus status;
  List<String> symbols;


  SymbolsState({
    required this.symbols,
    required this.status,
  });


  SymbolsState copyWith({
    RequestStatus? status,
    List<String>? symbols
  }) {
    return SymbolsState(
      symbols: symbols ?? this.symbols,
      status: status ?? this.status,
    );
  }
}
