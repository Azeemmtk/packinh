import 'package:flutter/material.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/entity/occupant_entity.dart';

import '../screens/occupant_details_screen.dart';

class OccupantCardWidget extends StatelessWidget {
  final OccupantEntity occupant;
  final String hostelName;
  final String roomType;

  const OccupantCardWidget({
    super.key,
    required this.occupant,
    required this.hostelName,
    required this.roomType,
  });

  @override
  Widget build(BuildContext context) {
    final rentStatus = occupant.rentPaid ? 'Paid' : 'Due';
    final rentColor = occupant.rentPaid ? mainColor : Colors.red;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OccupantDetailsScreen(
              occupantId: occupant.id!,
              hostelName: hostelName,
              roomType: roomType,
            ),
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
                      occupant.profileImageUrl!,
                  width: width * 0.35,
                  height: height * 0.12,
                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) => Image.network(
                    imagePlaceHolder,
                    width: width * 0.35,
                    height: height * 0.12,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          occupant.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        width5,
                        Container()
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(

                      'Phone: ${occupant.phone}',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'RENT - ',
                          style: const TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          rentStatus,
                          style: TextStyle(
                            color: rentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
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
