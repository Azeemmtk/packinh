import 'package:flutter/material.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/entity/hostel_entity.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/constants/colors.dart';
import '../screens/all_occupant_screen.dart';

class HostelCardWidget extends StatelessWidget {
  final HostelEntity hostel;

  const HostelCardWidget({
    super.key,
    required this.hostel,
  });

  @override
  Widget build(BuildContext context) {
    final occupantCount = hostel.occupantsId?.length ?? 0;
    final imageUrl = hostel.mainImageUrl ?? imagePlaceHolder;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllOccupantScreen(hostelId: hostel.id, hostelName: hostel.name,),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.network(
                  imageUrl,
                  width: width * 0.35,
                  height: height * 0.08,
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
                        width: width * 0.35,
                        height: height * 0.08,
                        color: Colors.white,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    imagePlaceHolder,
                    width: width * 0.35,
                    height: height * 0.08,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hostel.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Occupants: $occupantCount',
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    width5,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}