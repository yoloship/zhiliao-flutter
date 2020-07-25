
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhiliao/data/model/moment_entity.dart';
import 'package:zhiliao/res/colours.dart';
import 'package:zhiliao/res/styles.dart';

class MomentItem extends StatelessWidget{

  final MomentEntity momentEntity;

  const MomentItem({Key key, this.momentEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Card(
      margin:EdgeInsets.all(10),
      child:InkWell(
        child:Container(
          alignment: Alignment.topLeft,
          width: MediaQuery.of(context).size.width,
          padding:EdgeInsets.all(ScreenUtil().setHeight(20)),
          child:Column(
//mainAxisAlignment: MainAxisAlignment.start,  行里用这个
            crossAxisAlignment: CrossAxisAlignment.start, //列里用这个
            children: [
              Row(
                children: <Widget>[
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: NetworkImage(momentEntity.avatarUrl),
                          fit: BoxFit.cover),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                  Container(
//显示用户名
                    margin:EdgeInsets.all(1),
                    child:Text(
                      momentEntity.createName,
                      style:TextStyle(color: Colors.blue, fontSize:16),
                    ),
                  ),
                ],
              ),
              Container(

//显示时间

                margin:EdgeInsets.all(1),

                child:Text(

                  momentEntity.createTime,

                  style:TextStyle(color: Colors.black54, fontSize:14),

                ),

              ),

              Container(

//画一条线

                margin:EdgeInsets.all(1),

                child:Divider(

                  height:0.2,

                  indent:0,

                  color: Colors.black45,

                ),

              ),

              Container(

//显示内容

                margin:EdgeInsets.all(3),

                child:Text(

                  momentEntity.content,

                  style:TextStyle(color: Colors.black87, fontSize:14),

                ),

              ),

              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Gaps.hGap(12),
                        Text(
                          momentEntity.categoryName,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil.getInstance().setSp(32),
                              color: Colours.black),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            momentEntity.money,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil.getInstance().setSp(36),
                                color: Colours.dark),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

            ],

          ),

        ),

      ),

    );

  }

}
