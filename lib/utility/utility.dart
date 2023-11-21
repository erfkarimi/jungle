int createUniqueID(){
  return DateTime.now().millisecondsSinceEpoch.remainder(10000);
}