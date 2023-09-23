import 'package:bloc/bloc.dart';

import '../../../../../common/utils/request_status.dart';
import '../../../data/repositories/home_repository.dart';

part 'convert_state.dart';

class ConvertCubit extends Cubit<ConvertState> {
  final homeRepository = HomeRepository();

  ConvertCubit()
      : super(ConvertState(
            fromSymbol: '',
            toSymbol: '',
            finalValue: '',
            fromValue: '',
            status: const InitialRequestStatus()));

  void onFromSymbolChange(String value) {
    emit(state.copyWith(fromSymbol: value));
  }

  void onFinalValueChange(String value) {
    emit(state.copyWith(finalValue: value));
  }

  void onFromValueChange(String value) {
    emit(state.copyWith(fromValue: value));
  }

  void onToSymbolChange(String value) {
    emit(state.copyWith(toSymbol: value));
  }

  void convert() async {
    emit(state.copyWith(status: const RequestSubmitting()));
    final result = await homeRepository.convert(
        state.fromValue, state.toSymbol, state.fromSymbol);
    result.when(error: (failure) {
      return emit(state.copyWith(status: SubmissionFailed(failure)));
    }, success: (data) {
      emit(state.copyWith(
          status: const SubmissionSuccess(),
          finalValue: (data * double.parse(state.fromValue)).toString()));
    });
  }
}
