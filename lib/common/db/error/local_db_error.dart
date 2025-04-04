import 'package:common_ui/common/db/error/local_db_error_type.dart';

export 'package:common_ui/common/db/error/local_db_error_type.dart';

class LocalDBError {
  LocalDBErrorType localDBErrorType;
  String message;

  LocalDBError(
    this.localDBErrorType,
    this.message,
  );
}
