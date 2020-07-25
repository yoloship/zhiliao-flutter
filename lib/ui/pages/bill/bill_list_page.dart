
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:zhiliao/blocs/bill/bill_bloc.dart';
import 'package:zhiliao/blocs/bill/bill_event.dart';
import 'package:zhiliao/blocs/bill/bill_state.dart';
import 'package:zhiliao/data/model/bill_entity.dart';
import 'package:zhiliao/data/model/bill_group_by_day.dart';
import 'package:zhiliao/db/db_helper.dart';
import 'package:zhiliao/res/colours.dart';
import 'package:zhiliao/res/styles.dart';
import 'package:zhiliao/routers/navigator_util.dart';
import 'package:zhiliao/routers/routes.dart';
import 'package:zhiliao/ui/widgets/app_bar.dart';
import 'package:zhiliao/ui/pages/bill/calendar_page.dart';
import 'package:zhiliao/ui/widgets/highlight_well.dart';
import 'package:zhiliao/ui/widgets/state_layout.dart';
import 'package:zhiliao/util/utils.dart';

class BillListPage extends StatelessWidget {
  final ledgerId;
  String year = "${DateTime.now().year}";
  String month = "${DateTime.now().month.toString().padLeft(2, '0')}";
  BillListPage({this.ledgerId});


//  final ledgerId;
//
//  const BillListPage({Key key, this.ledgerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return BlocProvider(
            create: (BuildContext context) => BillBloc()..add(FetchBill(ledgerId: ledgerId,year: year,month: month)),
            child : BillList(year: year,month: month,ledgerId: ledgerId,)
            );


  }


}

class BillList extends StatelessWidget{
  String year;
  String month;
  final String ledgerId;
  BillList({this.year,this.month, this.ledgerId});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<BillBloc,BillState>(
          builder: (context,state){
          if(state is BillLoaded){

            _showBottomSheet(BillEntity bill) {
              if (bill == null) {
                showToast('查询错误');
                return;
              }

              final TextStyle titleStyle = TextStyle(fontSize: 16, color: Colours.black);
              final TextStyle descStyle = TextStyle(fontSize: 16, color: Colours.black);

              DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
              String timeString = bill.createdTime;

              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 60,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Text(
                                  '账单详情',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Positioned(
                                  left: 0,
                                  child: HighLightWell(
                                    onTap: () {
                                      // 删除记录
                                      BlocProvider.of<BillBloc>(context).add(DeleteBill());
                                      NavigatorUtil.goBack(context);
                                    },
                                    borderRadius: BorderRadius.circular(3),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          border: Border.all(
                                              color: Colours.gray_c, width: 0.5)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 4),
                                        child: Text(
                                          '删除',
                                          style:
                                          TextStyle(fontSize: 16, color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: HighLightWell(
                                    onTap: () {
                                      NavigatorUtil.goBack(context);
                                      NavigatorUtil.push(context, "${Routes.publishMoment}?billId=${bill.billId}");
                                    },
                                    borderRadius: BorderRadius.circular(3),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          border: Border.all(
                                              color: Colours.gray_c, width: 0.5)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 4),
                                        child: Text(
                                          '分享',
                                          style: TextStyle(
                                              fontSize: 16, color: Colours.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gaps.line,
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: <Widget>[
                                Text('金额', style: titleStyle),
                                Gaps.hGap(20),
                                Expanded(
                                  flex: 1,
                                  child: Text(bill.money,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      )),
                                )
                              ],
                            ),
                          ),
                          Gaps.line,
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('分类', style: titleStyle),
                                Gaps.hGap(23),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Gaps.hGap(5),
                                        Text('${bill.categoryName}',
                                            textAlign: TextAlign.right, style: descStyle)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Gaps.line,
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: <Widget>[
                                Text('时间', style: titleStyle),
                                Gaps.hGap(20),
                                Expanded(
                                  flex: 1,
                                  child: Text('$timeString',
                                      textAlign: TextAlign.right, style: descStyle),
                                )
                              ],
                            ),
                          ),
                          Gaps.line,
                          bill.remark.isNotEmpty
                              ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: <Widget>[
                                Text('备注', style: titleStyle),
                                Gaps.hGap(20),
                                Expanded(
                                  flex: 1,
                                  child: Text('${bill.remark}',
                                      textAlign: TextAlign.right, style: descStyle),
                                )
                              ],
                            ),
                          )
                              : Gaps.empty,
                          MediaQuery.of(context).padding.bottom > 0
                              ? SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                              : Gaps.empty,
                        ],
                      ),
                    );
                  });
            }

            Widget buildBillList(BillEntity bill){
              return Container(
                child: HighLightWell(
                    onTap: () {
                      _showBottomSheet(bill);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    Utils.getImagePath('category/${bill.imgAdress}'),
                                    width: ScreenUtil.getInstance().setWidth(55),
                                  ),
                                  Gaps.hGap(12),
                                  Text(
                                    bill.categoryName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil.getInstance().setSp(32),
                                        color: Colours.black),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      bill.money,
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
                              bill.remark.isNotEmpty
                                  ? Padding(
                                padding: EdgeInsets.only(
                                    left:
                                    ScreenUtil.getInstance().setWidth(55) + 12,
                                    top: 2),
                                child: Text(
                                  bill.remark,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: ScreenUtil.getInstance().setSp(30),
                                      color: Colours.black),
                                ),
                              )
                                  : Gaps.empty,
                            ],
                          ),
                        ),
                        Positioned(
                          left: 16,
                          right: 0,
                          bottom: 0,
                          child: Gaps.line,
                        )
                      ],
                    )),
              );
            }

            Widget buildDayList(BillGroupByDay billGroupByDay) {
              List<Widget> groupList = List();
              String moneyString = '收入${billGroupByDay.dayIncomeMoney}  支出${billGroupByDay.dayExpenMoney}';
              Widget day = Container(
                color: Colors.white,
                width: double.infinity,
                child: HighLightWell(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  Utils.getImagePath('icons/icon_calendar'),
                                  width: ScreenUtil.getInstance().setWidth(32),
                                ),
                                Gaps.hGap(10),
                                Text(
                                  '${billGroupByDay.date.year}-${billGroupByDay.date.month.toString().padLeft(2, '0')}-${billGroupByDay.date.day.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                      fontSize: ScreenUtil.getInstance().setSp(30),
                                      color: Colours.dark),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                moneyString,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil.getInstance().setSp(28),
                                    color: Colours.dark),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Gaps.line,
                      )
                    ],
                  ),
                ),
              );
              groupList.add(day);
              for(int i = 0; i< billGroupByDay.bills.length; i++) {
                groupList.add(buildBillList(billGroupByDay.bills[i]));
              }
              return Column(
                children: groupList,
              );
            }
            //支出和收入widget
            Widget amountWidget = Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          bottom: ScreenUtil.getInstance().setHeight(16),
                          child: Column(
                            children: <Widget>[
                              Text(
                                '${state.monthExpenMoney}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(36),
                                    color: Colors.white),
                              ),
                              Text('${Utils.formatDouble(double.parse(this.month))}月支出',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil.getInstance().setSp(26),
                                      color: Colors.white))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          bottom: ScreenUtil.getInstance().setHeight(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                 '${state.monthIncomeMoney}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(36),
                                    color: Colors.white),
                              ),
                              Text('${Utils.formatDouble(double.parse(this.month))}月收入',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil.getInstance().setSp(26),
                                      color: Colors.white))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
            // 头部伸展视图
            Widget flexibleSpaceBar = FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          Utils.getImagePath('', format: 'jpeg'),
                        ),
                        fit: BoxFit.fill)),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                              '${state.monthSurplus}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil.getInstance().setSp(56),
                                  color: Colors.white)),
                          Text(
                            '本月结余',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil.getInstance().setSp(26),
                                color: Colors.white),
                          ),
                          Gaps.vGap(15),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: amountWidget,
                    )
                  ],
                ),
              ),
            );



            List<Widget> sliverBuilder = <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false, elevation: 0.0, //去除导航栏阴影
                pinned: false,
                //导航栏固定
                expandedHeight: ScreenUtil.getInstance().setWidth(340),
                flexibleSpace: flexibleSpaceBar,
              ),
              state.billGroupList.length>0?
              SliverList(
                delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
                  return buildDayList(state.billGroupList[index]);
                }, childCount: state.billGroupList.length),
              ):
              SliverPadding(
                padding:
                EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(120)),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return const StateLayout(
                          hintText: '没有账单~',
                        );
                      }, childCount: 1),
                ),
              ),
            ];
            return Scaffold(
              appBar: MyAppBar(
                isBack: true,
                titleWidget: FlatButton(
                  child: Text(
                    '$year-$month',
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return CalendarMonthDialog(
                          checkTap: (year, month) {
                            if (this.year != year || this.month != month) {
                              BillBloc billBloc = context.bloc<BillBloc>();
                              print(billBloc);
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              body: CustomScrollView(
                slivers: sliverBuilder,
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.child_care),
                onPressed: ()=>{
                  NavigatorUtil.push(context, "${Routes.memberList}?ledgerId=$ledgerId")
                },
              ),
            );
          }


          if(state is LoadingBilState){
            return CircularProgressIndicator();
          }
        }
    );
  }







}
