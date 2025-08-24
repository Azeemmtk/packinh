import 'package:flutter/material.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/custom_green_button_widget.dart';
import 'package:packinh/core/widgets/details_row_widget.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';
import 'package:packinh/features/app/pages/Occupants/presentation/widgets/occupant_details_appbar_widget.dart';

class OccupantDetailsScreen extends StatelessWidget {
  const OccupantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          OccupantDetailsAppbarWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height20,
                    if (true) ...[
                      TitleTextWidget(title: 'Guardian details'),
                      height10,
                      DetailsRowWidget(title: 'Name', value: 'Azeem ali'),
                      height5,
                      DetailsRowWidget(title: 'Phone', value: '9487948743'),
                      height5,
                      DetailsRowWidget(title: 'Relation', value: 'Father'),
                    ],
                    height50,
                    TitleTextWidget(title: 'Id proof'),
                    height10,
                    Container(
                      width: double.infinity,
                      height: height * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(imagePlaceHolder),
                            fit: BoxFit.cover),
                      ),
                    ),
                    height5,
                    Container(
                      width: double.infinity,
                      height: height * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(imagePlaceHolder),
                            fit: BoxFit.cover),
                      ),
                    ),
            
                    height50,
                    TitleTextWidget(title: 'Room details'),
                    height10,
                    DetailsRowWidget(title: 'Hostel name', value: 'Summit hostel', isBold: true,),
                    height5,
                    DetailsRowWidget(title: 'Room type', value: 'Shared'),
                    height50,
                    CustomGreenButtonWidget(name: 'Goto hostel', onPressed: () {
                      
                    },)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
