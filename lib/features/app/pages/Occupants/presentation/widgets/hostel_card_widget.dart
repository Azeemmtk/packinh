import 'package:flutter/material.dart';
import 'package:packinh/features/app/pages/Occupants/presentation/screens/all_occupant_screen.dart';
import '../../../../../../core/constants/const.dart';

class HostelCardWidget extends StatelessWidget {
  const HostelCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AllOccupantScreen(),));
      },
      child: Padding(
        padding: EdgeInsets.only(left: padding, right: padding,),
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
                child: Image.asset(
                  'assets/images/occupant_image.png',
                  width: width * 0.35,
                  height: height * 0.08,
                  fit: BoxFit.cover,
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
                  children: [
                    height10,
                    Text(
                      'Summit hostel',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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
