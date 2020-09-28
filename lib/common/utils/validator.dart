
bool duISEmail(String input){
  if(input==null||input.isEmpty)return false;
  String regesEmail="[0-9a-zA-Z]{1,15}[@][0-9a-zA-Z]{1,5}[.][a-z]{1,3}";
  return RegExp(regesEmail).hasMatch(input);
}
bool duCheckStringLength(String input,int length){
  if(input==null||input.isEmpty)return false;
  return input.length>=length;
}