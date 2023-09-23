import 'package:bloc/bloc.dart';
import 'package:currency_conv/src/common/utils/request_status.dart';
import 'package:currency_conv/src/features/home/data/repositories/home_repository.dart';

part './symbols_state.dart';

class SymbolsCubit extends Cubit<SymbolsState> {
  final homeRepository = HomeRepository();

  SymbolsCubit()
      : super(SymbolsState(symbols: [], status: const InitialRequestStatus()));

  void getSymbols() async {
    emit(state.copyWith(status: const RequestSubmitting()));
    final result = await homeRepository.getAllSymbols();
    result.when(
        error: (failure) {
          return emit(state.copyWith(status: SubmissionFailed(failure)));
        },
        success: (data) => emit(
            state.copyWith(status: const SubmissionSuccess(), symbols: data)));
  }
}
