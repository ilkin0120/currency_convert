part of 'convert_cubit.dart';

class ConvertState {
  RequestStatus status;
  String fromValue;
  String fromSymbol;
  String finalValue;
  String toSymbol;

  ConvertState(
      {required this.fromSymbol,
      required this.toSymbol,
      required this.finalValue,
      required this.fromValue,
      required this.status});

  ConvertState copyWith(
      {String? fromSymbol,
      String? toSymbol,
      String? finalValue,
      String? fromValue,
      RequestStatus? status}) {
    return ConvertState(
      finalValue: finalValue ?? this.finalValue,
      status: status ?? this.status,
      fromValue: fromValue ?? this.fromValue,
      fromSymbol: fromSymbol ?? this.fromSymbol,
      toSymbol: toSymbol ?? this.toSymbol,
    );
  }
}
