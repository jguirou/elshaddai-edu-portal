class CustomFirebaseAuthExceptions implements Exception {
  final String code;
  CustomFirebaseAuthExceptions(this.code);

  String get message {
    switch(code){
      case 'email-already-in-use':
        return "L'adresse électronique est déjà enregistrée. Veuillez utiliser une autre adresse électronique.";
      case 'invalid-email':
        return "L'adresse électronique fournie n'est pas valide. Veuillez saisir une adresse électronique valide.";
      case 'weak-password':
        return "Le mot de passe est trop faible. Veuillez choisir un mot de passe plus fort.";
      case 'user-disabled':
        return "Ce compte d'utilisateur a été désactivé. Veuillez contacter le service d'assistance pour obtenir de l'aide.";
      case 'user-not-found':
        return "Détails de connexion invalides. Utilisateur non trouvé.";
      case 'wrong-password':
        return "Mot de passe incorrect. Veuillez vérifier votre mot de passe et réessayer.";
      case 'invalid-verification-code':
        return 'Code de vérification invalide. Veuillez entrer un code valide.';
      case 'invalid-verification-id':
        return 'ID de vérification invalide. Veuillez demander un nouveau code de vérification.';
      case 'quota-exceeded':
        return 'Quota dépassé. Veuillez réessayer plus tard.';
      case 'email-already-exists':
        return 'L\'adresse électronique existe déjà. Veuillez utiliser une autre adresse électronique.';
      case 'provider-already-linked':
        return 'Le compte est déjà lié à un autre fournisseur.';

      case 'requires-recent-login':
        return 'Cette opération est sensible et nécessite une authentification récente. Veuillez vous reconnecter.';
      case 'credentials-already-in-use':
        return 'Les identifiants sont déjà associés à un autre compte utilisateur.';
      case 'user-mismatch':
        return 'Les identifiants fournis ne correspondent pas à l\'utilisateur précédemment connecté.';
      case 'account-exists-with-different-credential':
        return 'Un compte existe déjà avec le même email mais avec des identifiants de connexion différents.';
      case 'operation-not-allowed':
        return 'Cette opération n\'est pas autorisée. Contactez le support pour obtenir de l\'aide.';

      case 'missing-app-credential':
        return 'L\'identifiant de l\'application est manquant. Veuillez fournir des identifiants d\'application valides.';
      case 'session-cookie-expired':
        return 'Le cookie de session Firebase a expiré. Veuillez vous reconnecter.';
      case 'uid-already-exists':
        return 'L\'ID utilisateur fourni est déjà utilisé par un autre utilisateur.';
      case 'web-storage-unsupported':
        return 'Le stockage Web n\'est pas pris en charge ou est désactivé. Veuillez fournir des identifiants d\'application valides.';
      case 'app-deleted':
        return 'L\'instance de FirebaseApp a été supprimée.';
      case 'user-token-mismatch':
        return 'Le jeton de l\'utilisateur fourni ne correspond pas à l\'ID utilisateur authentifié.';
      case 'invalid-message-payload':
        return 'Le contenu du message de vérification du modèle d\'email est invalide.';
      case 'invalid-sender':
        return 'L\'expéditeur du modèle d\'email est invalide. Veuillez vérifier l\'adresse électronique de l\'expéditeur.';
      case 'invalid-recipient-email':
        return 'L\'adresse électronique du destinataire est invalide. Veuillez fournir une adresse électronique valide du destinataire.';
      case 'missing-action-code':
        return 'Le code d\'action est manquant. Veuillez fournir un code d\'action valide.';
      case 'user-token-expired':
        return 'Le jeton de l\'utilisateur a expiré, et une authentification est requise. Veuillez vous reconnecter.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Identifiants de connexion invalides.';
      case 'expired-action-code':
        return 'Le code d\'action a expiré. Veuillez demander une nouvelle action.';
      case 'invalid-action-code':
        return 'Le code d\'action est invalide. Veuillez vérifier le code et réessayer.';
      case 'credential-already-in-use':
        return 'Les identifiants sont déjà associés à un autre compte utilisateur.';
      default:
        return 'Une erreur inattendue de Firebase s\'est produite. Veuillez réessayer.';
    }
  }
}
