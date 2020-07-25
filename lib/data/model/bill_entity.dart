import 'package:zhiliao/generated/json/base/json_convert_content.dart';

class BillEntity with JsonConvert<BillEntity> {
	String billId;
	String createdTime;
	String createdBy;
	String money;
	String billType;
	String categoryName;
	String imgAdress;
	String remark='';
}
