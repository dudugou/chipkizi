import 'package:chipkizi/models/main_model.dart';
import 'package:chipkizi/models/recording.dart';
import 'package:chipkizi/models/user.dart';
import 'package:chipkizi/values/status_code.dart';
import 'package:chipkizi/views/circular_button.dart';
import 'package:chipkizi/views/my_progress_indicator.dart';
import 'package:chipkizi/views/play_button.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class RecordingCard extends StatelessWidget {
  final Recording recording;

  const RecordingCard({Key key, @required this.recording}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _buildImageSection(MainModel model) => FutureBuilder<User>(
        future: model.userFromId(recording.createdBy),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Icon(
              Icons.mic,
              size: 45.0,
            );
          final User user = snapshot.data;
          return Center(
            child: CircleAvatar(
              radius: 60.0,
              backgroundColor: Colors.black12,
              backgroundImage: NetworkImage(user.imageUrl),
            ),
          );
        });

    _buildActions(MainModel model) => ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularIconButton(
              button: IconButton(
                icon: Icon(
                  Icons.bookmark_border,
                ),
                onPressed: () {},
              ),
              color: Colors.white,
            ),
            PlayButtonView(recording: recording,),
            CircularIconButton(
              button: IconButton(
                icon: Icon(
                  Icons.favorite_border,
                ),
                onPressed: () {},
              ),
              color: Colors.white,
            ),
          ],
        );
    final _shareButton = Positioned(
      top: 0.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: Icon(Icons.share),
          onPressed: () {},
        ),
      ),
    );

    final _infoSection = ListTile(
      title: Text(
        recording.title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      subtitle: Text(
        recording.description,
        textAlign: TextAlign.center,
      ),
    );

    _buildUserInfoSection(MainModel model) => FutureBuilder<User>(
          future: model.userFromId(recording.createdBy),
          builder: (_, snapshot) {
            if (!snapshot.hasData) return Container();
            final user = snapshot.data;
            return ListTile(
              title: Text(
                user.name,
                textAlign: TextAlign.center,
              ),
              subtitle: user.bio != null
                  ? Text(
                      user.name,
                      textAlign: TextAlign.center,
                    )
                  : Container(),
            );
          },
        );
    _buildCardSection(MainModel model) => Card(
        color: Colors.white70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildImageSection(model),
            _infoSection,
            _buildUserInfoSection(model),
            _buildActions(model)
          ],
        ));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ScopedModelDescendant<MainModel>(
        builder: (_, __, model) {
          return Stack(
            children: <Widget>[_buildCardSection(model), _shareButton],
          );
        },
      ),
    );
  }
}