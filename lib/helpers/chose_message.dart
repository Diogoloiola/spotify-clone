import 'package:spotify_clone/helpers/message.dart';

String choseMessage(int currentPage) {
  if (currentPage == 0) {
    return createMessage();
  }
  return 'Pesquisar';
}
