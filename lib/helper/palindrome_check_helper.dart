class PalindromeCheckHelper {
  static bool checkPalindrome(dynamic param) {
    if (param is String) {
      return checkString(param);
    } else if (param is int) {
      return checkInt(param);
    } else {
      return false;
    }
  }

  static bool checkString(String param) {
    String? original = param;
    String? reverse = original.split('').reversed.join('');

    if (original == reverse) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkInt(int param) {
    int reminder, sum = 0, temp;
    int number = param;
    temp = number;
    while (number > 0) {
      reminder = number % 10; //get remainder
      sum = (sum * 10) + reminder;
      number = number ~/ 10;
    }

    if (sum == temp) {
      return true;
    } else {
      return false;
    }
  }
}
