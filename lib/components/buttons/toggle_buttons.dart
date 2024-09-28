// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class ToggleButtonsWidget extends StatefulWidget {
  final List<String> options;
  final Function(int) onPressed;

  const ToggleButtonsWidget({
    Key? key,
    required this.options,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ToggleButtonsWidgetState createState() => _ToggleButtonsWidgetState();
}

class _ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(widget.options.length, (_) => false);
    isSelected[0] = true; // Select the first button by default
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: widget.options.map((option) => Text(option)).toList(),
      isSelected: isSelected,
      onPressed: (int newIndex) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == newIndex;
          }
        });
        widget.onPressed(newIndex);
      },
    );
  }
}
