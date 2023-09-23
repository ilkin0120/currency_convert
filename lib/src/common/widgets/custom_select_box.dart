import 'package:currency_conv/src/features/home/presentation/cubits/convert_cubit/convert_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSelectBox extends StatelessWidget {
  final bool isFrom;

  const CustomSelectBox({Key? key, required this.isFrom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ConvertCubit>(),
      child: Row(
        children: [
          BlocBuilder<ConvertCubit, ConvertState>(builder: (context, state) {
            return Container(
              constraints: const BoxConstraints(minWidth: 40),
              child: Text(
                isFrom ? state.fromSymbol : state.toSymbol,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Colors.deepPurple),
              ),
            );
          }),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.deepPurple,
            size: 25,
          )
        ],
      ),
    );
  }
}
