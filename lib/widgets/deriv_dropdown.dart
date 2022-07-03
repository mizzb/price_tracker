import 'package:flutter/material.dart';

class DerivDropDown extends StatelessWidget {
  const DerivDropDown({
    Key? key,
    required this.placeholder,
    required this.onChanged,
    required this.dropdownValue,
    required this.buildList,
  }) : super(key: key);

  final String placeholder;
  final dynamic dropdownValue;
  final Function buildList;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
          vertical: MediaQuery.of(context).size.width * 0.01),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<dynamic>(
        dropdownColor: Colors.black.withOpacity(0.9),
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.yellowAccent),
        hint: Text(
          placeholder,
          style: const TextStyle(
            color: Colors.yellowAccent,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        isExpanded: true,
        isDense: false,
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: buildList(),
        onChanged: (dynamic value) {
          onChanged(value);
        },
      ),
    );
  }
}
