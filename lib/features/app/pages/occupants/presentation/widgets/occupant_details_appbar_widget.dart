import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/entity/occupant_entity.dart';

class OccupantDetailsAppbarWidget extends StatelessWidget {
  const OccupantDetailsAppbarWidget({super.key, required this.occupant});
  final OccupantEntity occupant;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(width * 0.1),
        ),
      ),
      child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: mainColor,
                    radius: 72,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: secondaryColor,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage:
                            AssetImage('assets/images/occupant_image.png'),
                      ),
                    ),
                  ),
                  width20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Azeem ali',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: headingTextColor),
                      ),
                      Text(
                        '7994042391',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '24',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
