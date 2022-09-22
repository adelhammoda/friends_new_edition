


extension on String? {

  bool isNullOrEmpty(){
    if(this == null){
      return true;
    }else if(this!.isEmpty){
      return true;
    }
    else {
      return false;
    }
  }

}