
import 'package:hive_flutter/adapters.dart';

class CalculatorProvider{

  static Map<String, int> calculateAgeDifference(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(birthDate);

    int years = difference.inDays ~/ 365;
    int months = (difference.inDays % 365) ~/ 30;
    int days = difference.inDays % 30;

    return {
      'years': years,
      'months': months,
      'days': days,
    };
  }

  static Map<String,dynamic> calculateNextBirthday(DateTime birthDate){

    DateTime currentDate=DateTime.now();
    DateTime nextBirthDay;
int nextYear;
    
    if(birthDate.month<currentDate.month||
    birthDate.month==currentDate.month&& birthDate.day<=currentDate.day){
        nextYear = currentDate.year + 1;

    }
    else{
nextYear=currentDate.year;
    }
    nextBirthDay= DateTime(nextYear, birthDate.month, birthDate.day);
    Duration difference=nextBirthDay.difference(currentDate);
    int months = difference.inDays ~/ 30;
    int days = difference.inDays % 30;

    return {
      'months':months,
      'days':days
    };
  }


static Map<String ,dynamic> calculateTotalLife(DateTime birthDate){
   DateTime currentDate = DateTime.now();
    Duration duration = currentDate.difference(birthDate);

    
    int months = (duration.inDays ~/ 30.44).toInt();
    int days = duration.inDays.toInt();
    int weeks = duration.inDays ~/ 7;
    int hours = duration.inHours;

    return {
     
      'months': months,
      'days': days,
      'weeks': weeks,
      'hours': hours,
    };

}
static final userlist=Hive.box("user_list");

 static createuserList(Map<String ,dynamic> userInformation,{String? names})async{

  
  await userlist.add(userInformation);
  
  print("users ${userlist.length}");
  
  print(names);
  
  }
 
static deleteItem(int itemkey)async{
  await userlist.delete(itemkey);
  
  
}

}