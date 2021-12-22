import 'package:apod/logic/cubit/todays_picture_cubit.dart';
import 'package:apod/view/ui_helpers/ui_service.dart';
import 'package:flutter/material.dart';

class DataWidget extends StatefulWidget {
  final TodaysPictureLoaded state;
  const DataWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  State<DataWidget> createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          Text('${widget.state.data.title}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${widget.state.data.explanation}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),
          ),
          const SizedBox(height: 16.0),
          InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(24.0),
            minScale: 0.5,
            maxScale: 4,
            child: Image.network(
              widget.state.data.url ??
                  'https://www.computerhope.com/jargon/e/error.png',
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: 200,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 8.0,
                      backgroundColor: Colors.black38,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Text('Date - ${widget.state.data.date?.formatMyDate() ?? "NASA"}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6),
          Text('Copyright - ${widget.state.data.copyright ?? "NASA"}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
