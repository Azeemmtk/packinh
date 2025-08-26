import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';

class IdProofContainerWidget extends StatelessWidget {
  const IdProofContainerWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(
          image: NetworkImage(
            image ,
          ),
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              // Image loaded → fade in
              return AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 300),
                child: child,
              );
            }
            // Show shimmer while loading
            return Shimmer.fromColors(
              baseColor: secondaryColor,
              highlightColor: mainColor,
              direction: ShimmerDirection.ltr,
              child: Container(
                width: double.infinity,
                height: 96,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}