import 'package:currency_conv/src/common/constants/regexp_constants.dart';
import 'package:currency_conv/src/features/home/presentation/cubits/convert_cubit/convert_cubit.dart';
import 'package:currency_conv/src/features/home/presentation/widgets/currency_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/custom_select_box.dart';

class CurrencyRow extends StatelessWidget {
  final bool isFrom;
  final List<String> symbols;
  final TextEditingController? controller;

  const CurrencyRow(
      {Key? key, required this.symbols, required this.isFrom, this.controller})
      : super(key: key);

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (_) {
        return BlocProvider.value(
          value: context.read<ConvertCubit>(),
          child: AlertDialog(
            actionsPadding: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: const Text('Choose a currency'),
            content: SizedBox(
              height: 250,
              child: ListView.builder(
                  itemCount: symbols.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => isFrom
                          ? context
                              .read<ConvertCubit>()
                              .onFromSymbolChange(symbols[index])
                          : context
                              .read<ConvertCubit>()
                              .onToSymbolChange(symbols[index]),
                      child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: BlocBuilder<ConvertCubit, ConvertState>(
                            builder: (context, state) => CurrencyItem(
                              text: symbols[index],
                              isActive: isFrom
                                  ? symbols[index] == state.fromSymbol
                                  : symbols[index] == state.toSymbol,
                            ),
                          )),
                    );
                  }),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<ConvertCubit, ConvertState>(
            builder: (context, state) {
              return TextField(
                controller: controller,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExpConstants.currencyRegex)
                ],
                readOnly: !isFrom,
                style:
                    const TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
                onChanged: (value) => isFrom
                    ? context.read<ConvertCubit>().onFromValueChange(value)
                    : null,
              );
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () => _showAlertDialog(context),
          child: CustomSelectBox(
            isFrom: isFrom,
          ),
        )
      ],
    );
  }
}
