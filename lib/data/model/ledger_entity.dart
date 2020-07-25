import 'package:zhiliao/generated/json/base/json_convert_content.dart';

class LedgerEntity with JsonConvert<LedgerEntity> {
	String ledgerId;
	String name;
	String role;
}
