class CustomFirebaseExceptions implements Exception {
  final String code;
  CustomFirebaseExceptions(this.code);

  String get message {
    switch(code){
      case 'unknown':
        return "Une erreur Firebase inconnue s'est produite. Veuillez réessayer.";
      case 'invalid-custom-token':
        return "Le format du jeton personnalisé est incorrect. Veuillez vérifier votre jeton personnalisé.";
      case 'custom-token-mismatch':
        return "Le jeton personnalisé correspond à un public différent.";
      case 'user-disabled':
        return "Ce compte d'utilisateur a été désactivé. Veuillez contacter le service d'assistance pour obtenir de l'aide.";
      case 'user-not-found':
        return "Détails de connexion invalides. Utilisateur non trouvé.";
      case 'invalid-email':
        return "L'adresse électronique fournie n'est pas valide. Veuillez saisir une adresse électronique valide.";
      case 'email-already-in-use':
        return "L'adresse électronique est déjà enregistrée. Veuillez utiliser une autre adresse électronique.";
      case 'wrong-password':
        return "Mot de passe incorrect. Veuillez vérifier votre mot de passe et réessayer.";
      case 'weak-password':
        return "Le mot de passe est trop faible. Veuillez choisir un mot de passe plus fort.";
      case 'provider-already-linked':
        return "Le compte est déjà lié à un autre fournisseur.";
      case 'operation-not-allowed':
        return "Cette opération n'est pas autorisée. Contacter le support pour obtenir de l'aide";
      case 'invalid-credential':
        return "L'identifiant fourni est mal formé ou a expiré.";
      case 'invalid-verification-code':
        return "Code de vérification invalide. Veuillez saisir un code valide.";
      case 'invalid-verification-id':
        return "Code de vérification invalide.Veuillez demander un nouveau code de vérification.";
      case 'captcha-check-failed':
        return "La réponse reCAPTCHA n'est pas valide.Veuillez réessayer.";
      case 'app-not-authorized':
        return "L'application n'est pas autorisée à utiliser Firebase Authentication avec la clé API fournie.";
      case 'keychain-error':
        return "Une erreur s'est produite dans le trousseau.Veuillez vérifier le trousseau et réessayer.";
      case 'internal-error':
        return "Une erreur d'authentification interne s'est produite.Veuillez réessayer plus tard.";
      case 'invalid-app-credential':
        return "L'identifiant de l'application n'est pas valide.Veuillez fournir des informations d'identification valides.";
      default:
        return "Une erreur Firebase inattendue s'est produite.Veuillez réessayer.";

    }
  }
}