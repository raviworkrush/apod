import 'package:apod/logic/cubit/todays_picture_cubit.dart';
import 'package:apod/view/ui_helpers/ui_service.dart';
import 'package:apod/view/widgets/data_widget.dart';
import 'package:apod/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParticulerPicturePage extends StatefulWidget {
  final String date;
  const ParticulerPicturePage({Key? key, required this.date}) : super(key: key);

  @override
  State<ParticulerPicturePage> createState() => _ParticulerPicturePageState();
}

class _ParticulerPicturePageState extends State<ParticulerPicturePage> {
  @override
  void initState() {
    BlocProvider.of<TodaysPictureCubit>(context)
        .getParticulerDatePicture(widget.date)
        .whenComplete(() => null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.date} Astronomy Picture"),
      ),
      body: BlocConsumer<TodaysPictureCubit, TodaysPictureState>(
        listener: (context, state) {
          if (state is TodaysPictureError) {
            showMessage(context, 'Error', state.error);
          }
        },
        builder: (context, state) {
          if (state is TodaysPictureLoading) {
            return Loading(
              eventName: "${widget.date} Picture loading...",
            );
          } else if (state is TodaysPictureLoaded) {
            return DataWidget(
              state: state,
            );
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}
