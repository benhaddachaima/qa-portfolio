*** Settings ***
Library         Selenium2Library
Resource        commun.resource
Test Setup      Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
Test Teardown   Close All Browsers
Force Tags      ContacterHote
Metadata        Author    ${AUTHOR}
Metadata        Description    Tests fonctionnels pour la modale "Contacter l'hôte"

*** Test Cases ***

Contacter l'hôte - 01 - Succès de l'envoi (Scénario Nominal)
    [Documentation]    Vérifie l'envoi d'un message avec tous les champs valides.
    ...                Le test passe si le serveur renvoie une réponse (même l'erreur d'envoi d'email).
    Accéder À La Page D'Annonce
    Ouvrir La Modale Contacter Hôte
    Remplir Le Formulaire De Contact    Chaimae    benchaimae@gmail.com    Ceci est un message de test valide.    06299203
    Soumettre Le Formulaire De Contact
    Vérifier L'Envoi Réussi

Contacter l'hôte - 02 - Échec : Nom manquant
    [Documentation]    Vérifie que le formulaire n'est pas soumis si le champ Nom est vide.
    Accéder À La Page D'Annonce
    Ouvrir La Modale Contacter Hôte
    Remplir Le Formulaire De Contact    ${EMPTY}    benchaimae@gmail.com    Test sans nom
    Soumettre Le Formulaire De Contact
    Vérifier L'Échec De L'Envoi (Modale Reste Ouverte)

Contacter l'hôte - 03 - Échec : Email manquant
    [Documentation]    Vérifie que le formulaire n'est pas soumis si le champ Email est vide.
    Accéder À La Page D'Annonce
    Ouvrir La Modale Contacter Hôte
    Remplir Le Formulaire De Contact    Chaimae    ${EMPTY}    Test sans email
    Soumettre Le Formulaire De Contact
    Vérifier L'Échec De L'Envoi (Modale Reste Ouverte)

Contacter l'hôte - 04 - Échec : Format Email invalide (manque @)
    [Documentation]    Vérifie que le formulaire rejette un format d'email invalide (sans @).
    Accéder À La Page D'Annonce
    Ouvrir La Modale Contacter Hôte
    Remplir Le Formulaire De Contact    Chaimae    emailinvalide.com    Test email invalide
    Soumettre Le Formulaire De Contact
    Vérifier L'Échec De L'Envoi (Modale Reste Ouverte)

Contacter l'hôte - 05 - Échec : Message manquant
    [Documentation]    Vérifie que le formulaire n'est pas soumis si le corps du Message est vide.
    Accéder À La Page D'Annonce
    Ouvrir La Modale Contacter Hôte
    Remplir Le Formulaire De Contact    Chaimae    benchaimae@gmail.com    ${EMPTY}
    Soumettre Le Formulaire De Contact
    Vérifier L'Échec De L'Envoi (Modale Reste Ouverte)

# --- Nouveaux Cas de Test (6 à 10) ---

Contacter l'hôte - 06 - Succès : Champ Sujet vide (Acceptation)
    [Documentation]    Vérifie l'envoi réussi lorsque le champ Sujet est laissé vide. (Champ non obligatoire selon l'HTML/IHM).
    Accéder À La Page D'Annonce
    Ouvrir La Modale Contacter Hôte
    Remplir Le Formulaire De Contact    Chaimae    test@valid.com    Ceci est un message valide.   06299203  
    Soumettre Le Formulaire De Contact
    Vérifier L'Envoi Réussi

Contacter l'hôte - 07 - Succès : Utilisation de caractères spéciaux dans le Message
    [Documentation]    Vérifie l'envoi réussi avec des caractères non standard (e.g., accents, émojis simulés).
    Accéder À La Page D'Annonce
    Ouvrir La Modale Contacter Hôte
    Remplir Le Formulaire De Contact    Chaimae    test@valid.com    Test avec caractères : éàç!@#$ %^& * ( ) +
    Soumettre Le Formulaire De Contact
    Vérifier L'Envoi Réussi

Contacter l'hôte - 08 - Échec : Format Email invalide (espace au milieu)
    [Documentation]    Vérifie que le formulaire rejette un format d'email invalide (espace au milieu).
    Accéder À La Page D'Annonce
    Ouvrir La Modale Contacter Hôte
    Remplir Le Formulaire De Contact    Chaimae    email invalide@test.com    Test email invalide
    Soumettre Le Formulaire De Contact
    Vérifier L'Échec De L'Envoi (Modale Reste Ouverte)

Contacter l'hôte - 09 - Échec : Nom et Email manquants
    [Documentation]    Vérifie que la soumission échoue lorsque deux champs obligatoires sont manquants (combinaison d'erreurs).
    Accéder À La Page D'Annonce
    Ouvrir La Modale Contacter Hôte
    Remplir Le Formulaire De Contact    ${EMPTY}    ${EMPTY}    Message valide
    Soumettre Le Formulaire De Contact
    Vérifier L'Échec De L'Envoi (Modale Reste Ouverte)

Contacter l'hôte - 10 - Échec : Nom, Email et Message manquants
    [Documentation]    Vérifie que la soumission échoue lorsque tous les champs obligatoires (Nom, Email, Message) sont vides.
    Accéder À La Page D'Annonce
    Ouvrir La Modale Contacter Hôte
    Remplir Le Formulaire De Contact    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Soumettre Le Formulaire De Contact
    Vérifier L'Échec De L'Envoi (Modale Reste Ouverte)


*** Keywords ***
New Keyword
    Vérifier L'Envoi Réussi
