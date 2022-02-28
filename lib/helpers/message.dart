String createMessage() {
  int hour = DateTime.now().hour;
  if (hour >= 6 && hour <= 12) {
    return 'Bom dia';
  } else if (hour >= 12 && hour <= 18) {
    return 'Boa Tarde';
  } else if (hour >= 18 && hour <= 23) {
    return 'Boa noite';
  }
  return 'Boa madrugada';
}
