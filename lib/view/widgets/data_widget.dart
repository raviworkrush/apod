import 'package:apod/logic/cubit/todays_picture_cubit.dart';
import 'package:apod/view/ui_helpers/ui_service.dart';
import 'package:flutter/material.dart';

class DataWidget extends StatelessWidget {
  final TodaysPictureLoaded state;
  const DataWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          Text('${state.data.title}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${state.data.explanation}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),
          ),
          const SizedBox(height: 16.0),
          InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(24.0),
            minScale: 0.5,
            maxScale: 4,
            child: Image.network(
              state.data.url ??
                  'https://www.computerhope.com/jargon/e/error.png',
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: Column(
                    children: [
                      Text(loadingProgress.expectedTotalBytes != null
                          ? "Loading " +
                              ((loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!) *
                                      100)
                                  .toStringAsFixed(2) +
                              " %"
                          : "null"),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: LinearProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Text('Date - ${state.data.date?.formatMyDate() ?? "NASA"}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6),
          Text('Copyright - ${state.data.copyright ?? "NASA"}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
