import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/di/injection.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../provider/bloc/rent_bloc.dart';
import '../widgets/wallet_card_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarWidget(
            title: 'Payments',
            enableChat: true,
          ),
          BlocProvider(
            create: (context) => getIt<RentBloc>()..add(GetRentEvent()),
            child: Builder(
              builder: (context) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async{
                      log('refreshed');
                      context.read<RentBloc>().add(GetRentEvent());
                      await Future.delayed(Duration(microseconds: 500));
                    },
                    child: BlocBuilder<RentBloc, RentState>(
                      builder: (context, state) {
                        if (state is RentLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: mainColor,
                            ),
                          );
                        } else if (state is RentLoaded) {
                          if (state.payments.isEmpty) {
                            return Center(
                              child: Text('No payment done yet,'),
                            );
                          }
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(padding),
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return WalletCardWidget(
                                    payment: state.payments[index],
                                  );
                                },
                                separatorBuilder: (context, index) => height20,
                                itemCount: state.payments.length,
                              ),
                            ),
                          );
                        } else if (state is RentError) {
                          return Center(
                            child: Text(
                              'Add your hostels',
                            ),
                          );
                        } else {
                          return Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'No payment done yet',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
