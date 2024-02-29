class FormValidations  {
   static String? checkValidations(String val,int min,int max,{String type="ar",bool? isValid=false}){

    // if(val.trim().isEmpty){
    //   return "الحقــل فارغ";
    // }
    if(type !="ar"){//val.isValidName
      if(!val.isValidName)return "يجب أن يكون الحقل باللغة العربية!";
    }
    if(type =="en"){//val.isValidName
      if(!val.isValidEmail) return "اميل غير صــالح...!";
    }
    if(val.trim().length < min){
      return " غير مسموح بأقل من $min أحرف";
    }
    if(val.trim().length > max){
      return "غير مسموح بأكثر من $max أحرف";
    }
    if(!(val.isValidPhone) && isValid ==true){
      return "مسمـوح فقط الأرقـــام";
    }

    return null;
  }
  
}
extension ValidateString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }
  bool get isValidName{
    final nameRegExp =  RegExp(r"^\s*([ا-ي]|[أ-ي]{3,40})+\s*$");
    return nameRegExp.hasMatch(this);
  }
  bool get isValidPassword{
final passwordRegExp = 
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }
  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^[0-9]{5,20}$");//RegExp(r"^\+?0[0-9]{5,20}$");
    return phoneRegExp.hasMatch(this);
  }  
  
}