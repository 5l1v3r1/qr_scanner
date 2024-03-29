import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/services/adver_service.dart';
import 'package:qr_scanner/utils/db_helper.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

// ignore: must_be_immutable
class GenerateHistory extends StatefulWidget {
  List history;
  GenerateHistory(this.history);

  @override
  _GenerateHistoryState createState() => _GenerateHistoryState();
}

class _GenerateHistoryState extends State<GenerateHistory> {
  final AdvertService _advertService = AdvertService();

  Future adsk() async {
    await Firebase.initializeApp();
    await FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-4694190778906605~9514991815', analyticsEnabled: true);
  }

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  void getHistory() async {
    var historyFuture = _databaseHelper.getGenereteHistory();

    await historyFuture.then((data) {
      setState(() {
        widget.history = data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getHistory();
    _advertService.disposeAllAdverTop();
  }

  @override
  void dispose() {
    super.dispose();
    setState(() {
      _advertService.disposeAllAdverTop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D1F22),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Generete History', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: widget.history.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xff325CFD),
            child: ListTile(
              onTap: () {},
              leading: Image.memory(widget.history[index].photo),
              title: Text(
                widget.history[index].text,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Row(
                children: [
                  Text(
                    widget.history[index].type,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (widget.history[index].photo != null) {
                          await WcFlutterShare.share(
                              sharePopupTitle: 'share', fileName: 'share.png', mimeType: 'image/png', bytesOfFile: widget.history[index].photo);
                        }
                      })
                ],
              ),
              trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await _databaseHelper.delete(widget.history[index].id);
                    setState(() {
                      getHistory();
                    });
                  }),
            ),
          );
        },
      ),
    );
  }
}
