

import 'dart:developer' as dev;



class PrintLog{
 static void call({
    required String tag,
    required String message,
     String? error,
})=>
    dev.log(message,
      name: tag,
      error: error,
      time: DateTime.now(),);
}
