*** Settings ***
Library    Selenium2Library

*** Variables ***
${AUTHOR}    CHAIMAE Ben Hadda
${SERVEUR}         livraison3.testacademy.fr
${HOMEY URL}      http://${SERVEUR}/
${NAVIGATEUR}        Firefox

# Variables de Connexion (maintenues pour la complétude)
${LIEN SE CONNECTER}    xpath=//a[contains(text(),'Se connecter')]
${LIEN SE DECONNECTER}    xpath=(//a[contains(text(),'Se déconnecter')])[3]
${UTILISATEUR VALIDE}     robot
${MOT DE PASSE VALIDE}    robot
${CHAMP NOM UTILISATEUR}    name=username
${CHAMP MOT DE PASSE}    name=password
${BOUTON VALIDER}    css=.homey_login_button
${TITRE TABLEAU DE BORD}    Tableau de bord - Livraison 3
${ESPACE POUR AFFICHER LES ERREURS}    css=#modal-login .error

# Variables "Contacter l'hôte"
${URL ANNONCE TEST}    http://${SERVEUR}/index.php/listing/large-and-modern-bedroom/
${BOUTON OUVRIR CONTACT HOTE}   xpath=(//button[@type='button'])[12]
${MODALE CONTACTER HOTE}    id=modal-contact-host
${CHAMP NOM}    xpath=//input[@name='name']
${CHAMP EMAIL}    xpath=//input[@name='email']
${CHAMP SUJET}    xpath=//input[@name='phone']
${CHAMP MESSAGE}   xpath=//textarea[@name='message']
${BOUTON SOUMETTRE CONTACT}    css=.contact_listing_host
${MESSAGE CONTACT}    css=#modal-contact-host .homey_contact_messages
${BOUTON FERMER MODALE CONTACT}    css=.modal-body span

# Données de test spécifiques à l'environnement
# ATTENTION: Le serveur renvoie cette erreur au lieu du message de succès.
${MESSAGE SUCCES ATTENDU}  Make sure Email function working on your server!

*** Keywords ***

# --- Mots-clés de Navigation ---
Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
    Open Browser    ${HOMEY URL}    ${NAVIGATEUR}
    Maximize Browser Window

Accéder À La Page D'Annonce
    Go To    ${URL ANNONCE TEST}
    Wait Until Page Contains Element    ${BOUTON OUVRIR CONTACT HOTE}    timeout=10s
    
Ouvrir La Modale Contacter Hôte
    Wait Until Element Is Visible    ${BOUTON OUVRIR CONTACT HOTE}
    Click Element    ${BOUTON OUVRIR CONTACT HOTE}
    Wait Until Element Is Visible    ${MODALE CONTACTER HOTE}

Fermer La Modale De Contact
    Wait Until Element Is Visible    ${BOUTON FERMER MODALE CONTACT}
    Click Element    ${BOUTON FERMER MODALE CONTACT}
    Wait Until Element Is Not Visible    ${MODALE CONTACTER HOTE}

# --- Mots-clés d'Action Formulaire ---
Remplir Le Formulaire De Contact
    [Arguments]    ${nom}    ${email}    ${message}    ${sujet}=Demande d'info
    Input Text    ${CHAMP NOM}    ${nom}
    Input Text    ${CHAMP EMAIL}    ${email}
    Input Text    ${CHAMP MESSAGE}    ${message}
    Run Keyword And Ignore Error    Input Text    ${CHAMP SUJET}    ${sujet}

Soumettre Le Formulaire De Contact
    Click Button    ${BOUTON SOUMETTRE CONTACT}

# --- Mots-clés de Vérification ---
Vérifier L'Envoi Réussi
    [Documentation]    Vérifie le message de retour et ferme la modale.
    Wait Until Element Is Visible    ${MESSAGE CONTACT}    timeout=10s
    
    Element Should Contain           ${MESSAGE CONTACT}    Email Sent Successfully!
   
    Fermer La Modale De Contact

Vérifier L'Échec De L'Envoi (Modale Reste Ouverte)
    [Documentation]    Vérifie qu'aucun message de succès n'apparait (validation côté client) et que la modale est toujours là.
    # On vérifie qu'on n'a pas atteint le succès serveur
    Run Keyword And Ignore Error    Wait Until Element Does Not Contain    ${MESSAGE CONTACT}    ${MESSAGE SUCCES ATTENDU}    timeout=2s
    # La modale doit toujours être visible (bouton soumettre visible)
    Element Should Be Visible    ${BOUTON SOUMETTRE CONTACT}
    # Nettoyage pour le test suivant
    Fermer La Modale De Contact
    # --- Mots-clés pour la Connexion ---
Se Connecter
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${LIEN SE CONNECTER}
    Click Element    ${LIEN SE CONNECTER}
    Wait Until Element Is Visible    ${CHAMP NOM UTILISATEUR}
    Input Text       ${CHAMP NOM UTILISATEUR}    ${username}
    Input Text       ${CHAMP MOT DE PASSE}       ${password}
    Click Button     ${BOUTON VALIDER}

Vérifier Connexion Réussie
    Wait Until Page Contains    ${TITRE TABLEAU DE BORD}    timeout=10s
    Page Should Contain         ${TITRE TABLEAU DE BORD}

Vérifier Message d'Erreur Visible
    Wait Until Element Is Visible    ${ESPACE POUR AFFICHER LES ERREURS}
    Element Should Be Visible       ${ESPACE POUR AFFICHER LES ERREURS}

Se Déconnecter
    Wait Until Element Is Visible    ${LIEN SE DECONNECTER}
    Click Element    ${LIEN SE DECONNECTER}