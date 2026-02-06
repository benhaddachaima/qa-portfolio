*** Settings ***
Library    Selenium2Library
Resource    commun.resource
Test Setup    Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
Test Template    Un Message d'Erreur Doit Etre Visible Apres Une Connexion Incorrecte
Name    RobotFramework Chaima BEN HADDA

*** Test Cases ***
#cas de test                                            #nom d'utilisateur    #mot de passe
Test Utilisateur Valide Mot De Passe Vide                robot                 ${EMPTY}        
Test Utilisateur Vide Mot De Passe Valide                ${EMPTY}              robot
Test Utilisateur Vide Mot De Passe Vide                  ${EMPTY}              ${EMPTY} 
Test Utilisateur Non Valide Mot De Passe Valide          azerty                robot
Test Utilisateur Valide Mot De Passe Non Valide          robot                 azerty
Test Utilisateur Non Valide Mot De Passe Non Valide      azerty                azerty



*** Keywords ***

Accéder A La Page De Connexion
    Wait Until Element Is Visible    ${LIEN SE CONNECTER}    timeout=10s
    Click Element    ${LIEN SE CONNECTER}
    Wait Until Element Is Visible    ${CHAMP NOM UTILISATEUR}

Entrer Le Nom d'Utilisateur
    [Arguments]    ${username}
    Input Text     ${CHAMP NOM UTILISATEUR}    ${username}

Entrer Le Mot De Passe
    [Arguments]    ${password}
    Input Password    ${CHAMP MOT DE PASSE}    ${password}

Soumettre Le Formulaire De Connexion
    Click Button    ${BOUTON VALIDER}

Vérifier Que Le Message d'Erreur Est Visible
    Wait Until Element Is Visible    ${ESPACE POUR AFFICHER LES ERREURS}    timeout=10s
    Element Should Be Visible       ${ESPACE POUR AFFICHER LES ERREURS}
    Element Text Should Not Be      ${ESPACE POUR AFFICHER LES ERREURS}    ${EMPTY}

Un Message d'Erreur Doit Etre Visible Apres Une Connexion Incorrecte
    [Arguments]    ${nom utilisateur}    ${mot de passe}
    Accéder A La Page De Connexion
    Entrer Le Nom d'Utilisateur    ${nom utilisateur}
    Entrer Le Mot De Passe         ${mot de passe}
    Soumettre Le Formulaire De Connexion
    Vérifier Que Le Message d'Erreur Est Visible