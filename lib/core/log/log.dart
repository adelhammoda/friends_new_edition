

import 'dart:developer' as dev;



class PrintLog{
 static void call({
    required String tag,
    required String message,
     bool? isError,
})=>
    dev.log(message,
      name: tag,
      error: isError,
      time: DateTime.now(),);
}
