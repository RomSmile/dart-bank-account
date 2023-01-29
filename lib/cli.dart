import "dart:io";
import 'package:cli/helpers/Output.dart';
import 'package:cli/helpers/userOperations.dart';

void projectRun() async {
  print("Enter the operation what you want to do");
  print("1.Create account");
  print("2.Enter the account");

  String userOperation = stdin.readLineSync()!;

  switch (int.parse(userOperation)) {
    case 1:
      createAcc();
      break;

    case 2:
      enterTheAcc();
      break;

    default:
      printWarning("We don't have this operation");
      break;
  }
}
