import 'package:flutter/material.dart';

class ChowDeleteButton extends StatelessWidget {
  ChowDeleteButton({
    Key key,
    this.onTap,
    @required this.isButtonTapped,
  }) : super(key: key);

  final onTap;

  final bool isButtonTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        height: 55,
        width: 55,
        child: Icon(
          Icons.delete,
          size: 30,
          color: isButtonTapped
              ? Color.fromARGB(255, 226, 26, 26)
              : Color.fromARGB(255, 0, 0, 0),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          boxShadow: isButtonTapped
              ? []
              : [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: Offset(6, 6),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-6, -6),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
        ),
      ),
    );
  }
}
