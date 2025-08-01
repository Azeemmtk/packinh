import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';

class FacilitiesContainerWidget extends StatelessWidget {
  const FacilitiesContainerWidget({
    super.key,
    required this.facility,
    required this.onRemove,
  });

  final String facility;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.037,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              facility,
              style: const TextStyle(fontSize: 17, color: Colors.black),
            ),
             width5,
            InkWell(
              onTap: onRemove,
              child: const Icon(
                FontAwesomeIcons.xmark,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}