*** Settings ***
Library     Selenium2Library
Resource    commun.resource
Test Teardown    Close Browser

*** Test Cases ***
Le Tableau De Bord Doit Etre Visible Apres Une Connexion Réussie
    [Setup]    Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
    Effectuer Une Connection Réussie
    Vérifiez Que Le Tableau De Bord Est Visible

Le Lien De Connexion Devrait Etre Visible Après Une Déconnexion Réussie
    [Setup]    Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
    Effectuer Une Connection Réussie
    Effectuer Une Déconnexion Réussie
    Vérifier Que Le Lien De Connexion Est Visible

*** Keywords ***
Effectuer Une Connection Réussie
     
    Se Connecter    ${UTILISATEUR VALIDE}    ${MOT DE PASSE VALIDE}
   
    Sleep    3s

Vérifiez Que Le Tableau De Bord Est Visible
    Wait Until Page Contains    ${TITRE TABLEAU DE BORD}    timeout=15s
    Vérifier Connexion Réussie

Effectuer Une Déconnexion Réussie    
    Se Déconnecter
    Sleep    2s

Vérifier Que Le Lien De Connexion Est Visible
    Wait Until Element Is Visible    ${LIEN SE CONNECTER}    timeout=10s
    Element Should Be Visible        ${LIEN SE CONNECTER}