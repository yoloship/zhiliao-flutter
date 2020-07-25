import 'package:zhiliao/data/model/ledger_entity.dart';

ledgerEntityFromJson(LedgerEntity data, Map<String, dynamic> json) {
	if (json['ledgerId'] != null) {
		data.ledgerId = json['ledgerId']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['role'] != null) {
		data.role = json['role']?.toString();
	}
	return data;
}

Map<String, dynamic> ledgerEntityToJson(LedgerEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ledgerId'] = entity.ledgerId;
	data['name'] = entity.name;
	data['role'] = entity.role;
	return data;
}
