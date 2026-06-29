class AppValidators {

  //validate email function
  static String? validateEmail(String? value) {
    if(value==null|| value.trim().isEmpty){
      return 'Email is required';
    }
    final emailRegEx=RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if(!emailRegEx.hasMatch(value)) {
      return'Invalid email format';
    }
    return null;
  }

  //validate password function
  static String? validatePassword(String? value) {
    if(value==null|| value.trim().isEmpty){
      return 'Password is required';
    }
    if(value.length<8){
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  //validate confirm password function
  static String? validateConfirmPassword(String? value,String? password) {
    if(value==null|| value.trim().isEmpty){
      return 'Confirm password is required';
    }
    if(value!=password){
      return 'Passwords don\'t match';
    }
    return null;
  }

}