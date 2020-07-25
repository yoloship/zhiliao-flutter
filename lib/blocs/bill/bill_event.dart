import 'package:equatable/equatable.dart';

abstract class BillEvent extends Equatable {
  const BillEvent();
  @override
  List<Object> get props => null;
}

class FetchBill extends BillEvent {
  String year;
  String month;
  final String ledgerId;

  FetchBill({this.ledgerId,this.year,this.month});
}

class DeleteBill extends BillEvent{}
