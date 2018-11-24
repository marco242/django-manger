# Django-Manager Script
# Auteur : Marco.M
# Date : 22 nov 2018
# Version : 2.0
# Dependance : +python3.6, +python3.6-venv, -python3-pip (3.6)


#Définition de l'interpreteur

#!/bin/bash

# Mes packages

pytz_tar=pytz-2018.4.tar.gz
django_tar=Django-2.1.2.tar.gz
#pip_tar=pip-18.1.tar.gz

#Route des PATH (project and venv)
venv_path=/home/$USER/.venv/
project_path=/home/$USER/.project/

#current dir
this="$(dirname "$(realpath "$BASH_SOURCE")")"

#### Packages 
django=$this/.packages/$django_tar
pytz=$this/.packages/$pytz_tar
#pip=./packages/$pip_tar


#Createur de Repos 'Venv et project'
function create_path {
    if [ ! -d $1 ] && [ ! -d $2 ]; then
       mkdir $1
       mkdir $2
       echo 'path crée....'
       clear
    fi
 }


#Fonction de demarage de venv (Si le rep env existe (-d), (-e,-f)pour les fichiers)
# $1 exprime l'argument

 function lance_venv {
    if [ -d $venv_path/$1 ];then
            clear
            source $venv_path/$1/bin/activate
            cd $project_path/$1'_project'
    else
        clear
        echo -e 'Venv not existe..... Please your venv..'
        cree_venv $1
    fi
}

#Fonction de creation de venv 
function cree_venv {

    if [[ ! -d $venv_path/$1 ]]; then

    echo -e "\n Creation de la machine Virtuel...... \n"
    clear
    echo -e "Loading.... \n"
    python3.6 -m venv $venv_path/$1
    source $venv_path/$1/bin/activate
    clear
    echo -e "Installation des Dépendances\n"

    echo -e "Installation de pytz \n"
    pip install  $pytz
    clear
    echo -e "Installation de Django \n"
    pip install  $django

    #Passage de deux arguments ($1:pro.. $2: $1 qui est l'argument du context)
    django_create $project_path $1 
    clear

    else
        lance_venv $1
    fi
}

#Generateur de project 
 function django_create {
    cd  $1 && django-admin startproject $2'_project' 
    cd  $2'_project'
 }
 

 ####### Main #########

 #Création des chemin...
create_path $venv_path $project_path
#Netoyage de l'Ecran 
clear

#Demande de choix (Création ou lancement)
read -p " Hey Marco ! Whats'up ? want you Create or Lanch your project ? (C/L) --> " answer

#Netoyage de l'Ecran 
clear


#Switch d'aprés la réponses (c|C ou l|L)
case ${answer:0:1} in
    c|C )

        #Demande du nom de la Venv
        read -p "What's a name of your project ? -- > " venv

         #Si la reponse est create|Create (c|C)
        cree_venv $venv
    ;;
    l|L )

        #Demande du nom de la Venv
        read -p "What's a name of your project ? -- > " venv
        
        #Si la reponse est lanch|Lanch (l|L)
        lance_venv $venv
    ;;

    * )
    #Si la reponse n'est ni create|Create ou lanch|Lanch
    clear
	echo -e '\nArgumentError... Call Marco please or  \n(C|c : pour creer le projet)\n(L|l : pour lancer le project)\nBye.... Merci de Relancer'

    ;;
esac
