const int intTrue = 1;
const int intFalse = 0;

int reverseCompletion(int status) {
  return status == intTrue ? intFalse : intTrue;
}

bool getCompletionStatus(int status) {
  return status == intTrue;
}
