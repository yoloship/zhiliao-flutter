
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zhiliao/blocs/moment/bloc.dart';
import 'package:zhiliao/ui/widgets/app_bar.dart';


class PublishMomentPage extends StatelessWidget{

  final billId;

  const PublishMomentPage({Key key, this.billId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MyAppBar(
        titleWidget: Text("发布"),
      ),
      body: BlocProvider(
        create: (BuildContext context) => MomentBloc(),
        child: PublishMoment(billId: billId,),
      ),
    );
  }

}

class PublishMoment extends StatelessWidget{

  final billId;
  String _content="";
  TextEditingController contentController = TextEditingController();

  PublishMoment({Key key, this.billId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MomentBloc,MomentState>(
        builder: (context,state){
          return Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextField(
                    maxLines: 100,
                    maxLength: 500,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        hintText: "请输入文本:",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none
                    ),
                    controller: contentController,
                  ),
                ),
                // imageList.length > 0 ? CLPhotoView(list: imageList,
                // onDeleteItem: (list) {
                //     setState(() {
                //       imageList = list;
                //     });
                // },) : _getAddPhotoContainer(),
              FlatButton(
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
                child: Text(
                  '发布',
                  style: TextStyle(color: Colors.black54),
                ),
                onPressed: () {
                  BlocProvider.of<MomentBloc>(context).add(PublishMomentEvent(billId: billId,coment: contentController.text));

                },
              ),
                SizedBox(height: 200,)

              ],
            ),
          );
        }
    );
  }



}
