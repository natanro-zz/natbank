
import 'package:flutter_test/flutter_test.dart';
import 'package:natbank/models/transaction.dart';

void main(){
  test('Should return the value when create transaction', (){
    final transaction = Transaction(null, 200, null);
    expect(transaction.value, 200);
  });

  test("Should show error when create a transaction with a value less then or equal to zero",(){
    expect(() => Transaction(null, 0, null), throwsAssertionError);
  });
}