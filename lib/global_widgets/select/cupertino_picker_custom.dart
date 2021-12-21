import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CupertionPickerCustom<T> extends StatelessWidget {
  const CupertionPickerCustom(
      {Key? key,
      this.label = '',
      this.labelStyle,
      this.alignment = Alignment.centerLeft,
      this.textAlign = TextAlign.start,
      required this.builder,
      required this.list,
      required this.onSelected})
      : super(key: key);

  final List<T> list;
  final String label;
  final TextStyle? labelStyle;
  final TextAlign textAlign;
  final Alignment alignment;
  final Widget Function(BuildContext, dynamic) builder;
  final Function(T) onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.focusScope?.unfocus();
        final result = await Get.dialog(CupertionPickerCustomDialog<T>(
          builder: builder,
          list: list,
        ));
        if (result != null) {
          onSelected(result as T);
        }
      },
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(.1),
            borderRadius: BorderRadius.circular(15)),
        child: Align(
            alignment: alignment,
            child: Text(
              label,
              textAlign: textAlign,
              style: labelStyle ??
                  const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),
            )),
      ),
    );
  }
}

class CupertionPickerCustomDialog<T> extends StatefulWidget {
  const CupertionPickerCustomDialog({
    Key? key,
    required this.list,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext, dynamic) builder;
  final List<T> list;

  @override
  State<CupertionPickerCustomDialog> createState() =>
      _CupertionPickerCustomDialogState<T>();
}

class _CupertionPickerCustomDialogState<T>
    extends State<CupertionPickerCustomDialog> {
  late T item;

  @override
  void initState() {
    super.initState();
    setState(() {
      item = widget.list[0];
    });
  }

  void _onSelectedItemChanged(int value) {
    setState(() {
      item = widget.list[value];
    });
  }

  void _pickedItem() {
    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          CupertinoPicker(
              onSelectedItemChanged: _onSelectedItemChanged,
              itemExtent: 70,
              children: List.generate(widget.list.length, (index) {
                return widget.builder(context, widget.list[index]);
              })),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                onPressed: _pickedItem,
                child: const Text(
                  'Selected',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ))
        ],
      ),
    );
  }
}
