import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Random random = Random();

class RadioButtonContent<T, U> {
  final T data;
  final Widget label;
  final U value;
  final U group;

  const RadioButtonContent(
    this.data, {
    required this.label,
    required this.value,
    required this.group,
  });

  RadioButtonContent copy({
    T? newData,
    Widget? newLabel,
    U? newValue,
    U? newGroup,
  }) {
    return RadioButtonContent(
      newData ?? data,
      label: newLabel ?? label,
      value: newValue ?? value,
      group: newGroup ?? group,
    );
  }

  @override
  String toString() =>
      'RadioButtonContent(data: $data, label: $label, button: $value group: $group)';
}

/// RadioButtonCubit
class RadioButtonCubit extends Cubit<RadioButtonContent> {
  RadioButtonCubit(super.initialState) {
    debugPrint('🤣initialize cubit: $state');
  }

  void setSelectedValue(RadioButtonContent buttonContent) {
    debugPrint('RadioButtonCubit.setSelectedValue: $buttonContent');
    emit(buttonContent);
  }
}

num get kK => random.nextInt(89) + 10;

/// UIRadioButton
class UIRadioButton<T, U> extends StatelessWidget {
  final RadioButtonContent<T, U> buttonContent;
  final bool enabledHeader;

  const UIRadioButton({
    super.key,
    required this.buttonContent,
    this.enabledHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    RadioButtonCubit cubit = context.read<RadioButtonCubit>();

    debugPrint(
        '$kK @build RadioButtonCubit.state: ${cubit.state} button: $buttonContent');
    return BlocBuilder<RadioButtonCubit, RadioButtonContent>(
      bloc: cubit,
      builder: (context, state) {
        debugPrint('$kK RadioButtonCubit: $state $buttonContent');
        return Flexible(
          child: InkWell(
            onTap: enabledHeader
                ? () {
                    if (buttonContent.value != state.group) {
                      cubit.setSelectedValue(
                          buttonContent.copy(newGroup: buttonContent.value));
                    }
                  }
                : null,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Radio<U>(
                  value: buttonContent.value,
                  groupValue: state.group,
                  onChanged: (selectedValue) {
                    debugPrint('ONCHANGE: $selectedValue');
                    // Only update if newValue is not null and different from the current state
                    if (selectedValue != null &&
                        selectedValue != cubit.state.group) {
                      cubit.setSelectedValue(
                          buttonContent.copy(newGroup: selectedValue));
                    }
                  },
                ),
                Flexible(child: Text('$kK ${buttonContent.value}')),
              ],
            ),
          ),
        );
      },
    );
  }
}
