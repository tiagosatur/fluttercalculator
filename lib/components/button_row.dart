import 'package:flutter/material.dart';
import './button.dart';

class ButtonRow extends StatelessWidget {
  final List<Button> buttons;

  ButtonRow(this.buttons);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //fold it's like the js reduce method
            children: buttons.fold(<Widget>[], (accumulatedList, button) {
              //if the list is not empty, it will add the line and the button
              accumulatedList.isEmpty
                  ? accumulatedList.add(button)
                  : accumulatedList.addAll([SizedBox(width: 1), button]);
              return accumulatedList;
            })));
  }
}
