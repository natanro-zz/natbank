import 'package:mockito/mockito.dart';
import 'package:natbank/database/dao/contact_dao.dart';
import 'package:natbank/http/webclients/transactions_webclient.dart';

class MockContactDAO extends Mock implements ContactDAO {}

class MockTransactionWebClient extends Mock implements TransactionsWebClient {}
