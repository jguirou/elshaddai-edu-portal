class CustomFormatException implements Exception {
  final String message;
  CustomFormatException([this.message = 'Une erreur de format inattendue s\'est produite. Veuillez vérifier votre saisie.']);

  factory CustomFormatException.fromMessage(String message){
    return CustomFormatException(message);
  }

  String get formattedMessage => message;

  factory CustomFormatException.fromCode(String code){
    switch(code){
      case 'invalid-email-format':
        return CustomFormatException('Le format de l\'adresse électronique est invalide. Veuillez entrer une adresse électronique valide.');
      case 'invalid-phone-number-format':
        return CustomFormatException('Le format du numéro de téléphone fourni est invalide. Veuillez entrer un numéro valide.');
      case 'invalid-date-format':
        return CustomFormatException('Le format de la date est invalide. Veuillez entrer une date valide.');
      case 'invalid-url-format':
        return CustomFormatException('Le format de l\'URL est invalide. Veuillez entrer une URL valide.');
      case 'invalid-credit-card-format':
        return CustomFormatException('Le format de la carte de crédit est invalide. Veuillez entrer un numéro de carte de crédit valide.');
      case 'invalid-numeric-format':
        return CustomFormatException('La saisie doit être un format numérique valide.');
      default:
        return CustomFormatException('Une erreur de format inattendue s\'est produite. Veuillez vérifier votre saisie.');
    }
  }
}
