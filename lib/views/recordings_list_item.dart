import 'package:chipkizi/models/main_model.dart';
import 'package:chipkizi/models/recording.dart';
import 'package:chipkizi/models/user.dart';
import 'package:chipkizi/pages/login.dart';
import 'package:chipkizi/pages/player.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class RecordingsListItemView extends StatelessWidget {
  final Recording recording;

  const RecordingsListItemView({Key key, this.recording}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _leadingSection =
        ScopedModelDescendant<MainModel>(builder: (_, __, model) {
      return FutureBuilder<User>(
        future: model.userFromId(recording.createdBy),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Icon(Icons.music_note);
          User user = snapshot.data;
          return CircleAvatar(
            backgroundColor: Colors.black12,
            backgroundImage: NetworkImage(user.imageUrl),
          );
        },
      );
    });

    // Future<void> _handleUpvote(MainModel model) async {
    //   if (!model.isLoggedIn)
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (_) => LoginPage(), fullscreenDialog: true));
    //   else
    //     model.hanldeUpvoteRecording(recording, model.currentUser.id);
    // }

    // _handlePlayRecording() => Scaffold.of(context).showBottomSheet((context) {
    //       return ListTile(
    //         leading: _leadingSection,
    //         title: Text(recording.title),
    //         subtitle: FutureBuilder(
    //             future: model.userFromId(recording.createdBy),
    //             builder: (context, snapshot) {
    //               if (!snapshot.hasData || snapshot.hasError)
    //                 return Container();
    //               User user = snapshot.data;
    //               return Text(user.name);
    //             }),
    //         trailing: IconButton(
    //             icon: Icon(Icons.favorite), onPressed: () => _handleUpvote()),
    //       );
    //     });

    return ListTile(
        leading: _leadingSection,
        title: Text(recording.title),
        isThreeLine: true,
        subtitle: Text(recording.description),
        trailing: PopupMenuButton(
          child: Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) {},
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => PlayerPage(recording: recording),
                fullscreenDialog: true)) //_handlePlayRecording(),
        );
  }
}
