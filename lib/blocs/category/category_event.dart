import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GetIncomeCategory extends CategoryEvent{}

class GetExpenCategory extends CategoryEvent{}
