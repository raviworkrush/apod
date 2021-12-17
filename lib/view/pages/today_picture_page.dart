import 'package:apod/logic/cubit/todays_picture_cubit.dart';
import 'package:apod/view/ui_helpers/ui_service.dart';
import 'package:apod/view/widgets/data_widget.dart';
import 'package:apod/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodayPicturePage extends StatefulWidget {
  const TodayPicturePage({Key? key}) : super(key: key);

  @override
  State<TodayPicturePage> createState() => _TodayPicturePageState();
}

class _TodayPicturePageState extends State<TodayPicturePage> {
  @override
  void initState() {
    BlocProvider.of<TodaysPictureCubit>(context)
        .getTodaysPicture()
        .whenComplete(() => null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Picture"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<TodaysPictureCubit, TodaysPictureState>(
        listener: (context, state) {
          if (state is TodaysPictureError) {
            showMessage(context, 'Error', state.error);
          }
        },
        builder: (context, state) {
          if (state is TodaysPictureLoading) {
            return const Loading();
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
