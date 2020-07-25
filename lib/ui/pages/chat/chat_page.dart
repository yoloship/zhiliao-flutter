

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zhiliao/blocs/authentication/bloc.dart';
import 'package:zhiliao/blocs/chat/bloc.dart';
import 'package:zhiliao/common/refresh_controller.dart';
import 'package:zhiliao/data/model/message_entity.dart';
import 'package:zhiliao/data/model/token_entity.dart';
import 'package:zhiliao/ui/pages/chat/expanded_viewport.dart';

final ThemeColor = Color.fromRGBO(237, 237, 237, 1.0);

class ChatPage extends StatelessWidget {
  final String hisEmail;

  const ChatPage({Key key, this.hisEmail}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    AuthenticationAuthenticated state = BlocProvider.of<AuthenticationBloc>(context).state;
    String myEmail = state.email;
    return BlocProvider(
    create: (BuildContext context) => ChatBloc()..add(FetchMessage(hisEmail: hisEmail,myEmail: myEmail)),
    child: ChatList(hisEmail: hisEmail));
  }
}


class ChatList extends StatelessWidget {
  TextEditingController _textController = TextEditingController();
  final String hisEmail;

  ChatList({Key key, this.hisEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ChatBloc,ChatState>(
      builder: (context,state){
        AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
        String myEmail = "";
        TokenEntity tokenEntity = null;
        if(authenticationBloc.state is AuthenticationAuthenticated){
          AuthenticationAuthenticated auState = authenticationBloc.state;
          myEmail = auState.email;
          tokenEntity = auState.tokenEntity;
        }
        List<_MessageItem> data = List();
        if (state is ChatLoaded){
          if (state.messageEntitys.length != null) {
            for(int i = state.messageEntitys.length-1 ; i >= 0 ; i--) {
                        _MessageItem _messageItem = _MessageItem(
                          content : state.messageEntitys[i].content,
                          isMe: state.messageEntitys[i].isMe,
                          author: state.messageEntitys[i].author,
                          url: state.messageEntitys[i].avatarUrl,
                        );
                        data.add(_messageItem);
                      }
          }
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("聊天"),
              leading: GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                  size: 20,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              trailing: Icon(
                Icons.group,
                color: Colors.grey,
                size: 24,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SmartRefresher(
                      enablePullDown: false,
                      onLoading: () async {
                        BlocProvider.of<ChatBloc>(context).add(FetchMessage(myEmail: myEmail,hisEmail: hisEmail));
                        refreshController.loadComplete();
                      },
                      footer: CustomFooter(
                        loadStyle: LoadStyle.ShowAlways,
                        builder: (context, mode) {
                          if (mode == LoadStatus.loading) {
                            return Container(
                              height: 60.0,
                              child: Container(
                                height: 20.0,
                                width: 20.0,
                                child: CupertinoActivityIndicator(),
                              ),
                            );
                          } else
                            return Container();
                        },
                      ),
                      enablePullUp: true,
                      child: Scrollable(
                        controller: state.scrollController,
                        axisDirection: AxisDirection.up,
                        viewportBuilder: (context, offset) {
                          return ExpandedViewport(
                            offset: offset,
                            axisDirection: AxisDirection.up,
                            slivers: <Widget>[
                              SliverExpanded(),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                        (c, i) => data[i],
                                    childCount: data.length),
                              )
                            ],
                          );
                        },
                      ),
                      controller: refreshController,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 56.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: CupertinoTextField(
                              controller: _textController,
                              placeholder: "输入你想发送的信息",
                              onSubmitted: (s) {

                                MessageEntity messageEntity = MessageEntity(
                                  myEmail: myEmail,
                                  hisEmail:hisEmail,
                                  content: _textController.text,
                                  author: tokenEntity.username,
                                  isMe: true,
                                  avatarUrl: tokenEntity.avatarUrl,
                                );
                                BlocProvider.of<ChatBloc>(context).add(SendMessage(messageEntity: messageEntity));
                                state.scrollController.jumpTo(0.0);
                                _textController.clear();
                              },
                            ),
                            margin: EdgeInsets.all(10.0),
                          ),
                        ),
                        RaisedButton(
                          child: Text("发送"),
                          color: Colors.blueAccent,
                          onPressed: () {
                            MessageEntity messageEntity = MessageEntity(
                              myEmail: myEmail,
                              hisEmail:hisEmail,
                              content: _textController.text,
                              author: tokenEntity.username,
                              isMe: true,
                              avatarUrl: tokenEntity.avatarUrl,
                            );
                            BlocProvider.of<ChatBloc>(context).add(SendMessage(messageEntity: messageEntity));
                            state.scrollController.jumpTo(0.0);
                            _textController.clear();
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        if (state is LoadingChatState){
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class _MessageItem extends StatelessWidget {
  final String content;
  final String author;
  final bool isMe;
  final String url;

  _MessageItem({this.content, this.author, this.isMe, this.url});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Wrap(
        textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(url),
            radius: 20.0,
          ),
          Container(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 25.0,
                width: 222.0,
                alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                child: Text(
                  author,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minWidth: 100.0,
                  minHeight: 100.0,
                  maxWidth: 222.0,
                ),
                alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  content,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize : 17,
                    fontWeight : FontWeight.normal),
                ),
                padding: EdgeInsets.all(10.0),
              )
            ],
          )
        ],
      ),
    );
  }
}
