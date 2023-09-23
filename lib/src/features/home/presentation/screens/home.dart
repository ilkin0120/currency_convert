import 'package:currency_conv/src/common/utils/request_status.dart';
import 'package:currency_conv/src/common/widgets/custom_icon_button.dart';
import 'package:currency_conv/src/features/home/presentation/cubits/convert_cubit/convert_cubit.dart';
import 'package:currency_conv/src/features/home/presentation/cubits/symbols_cubit/symbols_cubit.dart';
import 'package:currency_conv/src/features/home/presentation/widgets/currency_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController finalValueController = TextEditingController();

  void onConvertClick(BuildContext context) {
    final convertCubit = context.read<ConvertCubit>();
    if (convertCubit.state.fromValue.isNotEmpty &&
        convertCubit.state.toSymbol.isNotEmpty &&
        convertCubit.state.fromSymbol.isNotEmpty) {
      convertCubit.convert();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text(
            'Currency Converter',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SymbolsCubit()..getSymbols()),
            BlocProvider(create: (context) => ConvertCubit()),
          ],
          child: BlocBuilder<SymbolsCubit, SymbolsState>(
            builder: (context, state) {
              return state.status is RequestSubmitting
                  ? const Center(
                      child: Text(
                        'Loading',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'You send',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            CurrencyRow(symbols: state.symbols, isFrom: true),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: CustomIconButton(
                                onClick: () => onConvertClick(context),
                                icon: const Icon(
                                  Icons.swap_vert_rounded,
                                  size: 40,
                                  color: Colors.deepPurpleAccent,
                                ),
                                width: 45,
                                height: 45,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'You send',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            BlocConsumer<ConvertCubit, ConvertState>(
                              builder: (context, convertState) {
                                return CurrencyRow(
                                  symbols: state.symbols,
                                  isFrom: false,
                                  controller: finalValueController,
                                );
                              },
                              listener: (context, state) {
                                finalValueController.value =
                                    finalValueController.value.copyWith(
                                  text: state.finalValue,
                                  selection: TextSelection.collapsed(
                                      offset: state.finalValue.length),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ));
  }
}
