unit Personnage;

{$mode objfpc}{$H+}
{$I-}
{$codepage UTF8}
interface
uses
    inventaireLogic;


var
personnage1:typePersonnage;
data : file of Integer;
// Lvl

{Modifie le fichier LVL ce qui permet de mettre à jour le lvl du joueur.}
procedure miseAjourLVL(valeur : Integer);
{Renvoie le niveau actuelle du joueur contenu dans son fichier}
function getlvlActuelle() : Integer;

// Exp

{Modifie le fichier exp ce qui permet de mettre à jour l’EXP du joueur.}
procedure miseAjourExp(valeur : Integer);
{Renvoie l’exp actuelle du joueur contenu dans son fichier}
function getExpActuelle() : Integer;
{Vérifie si le joueur à passer un niveau, s’il a passé un niveau, le passe automatiquement}
procedure verifLvlUp();
{Calcule l’exp nécessaire pour le niveau suivant}
function calculLvlSuivant() : Integer;

// Or

{Modifie le fichier or ce qui permet de mettre à jour l’or du joueur. }
procedure miseAjourOr(valeur : Integer);
{Renvoie l’or actuelle du joueur contenu dans son fichier}
function getOrActuelle() : Integer;

// Stats de base

{Calcule les hpmax du joueur}
function calculHpMaxBase() : Integer;
{Calcule l’armure de base du joueur }
function calculArmureBase() : Integer;
{Calcule l'AD de base du joueur}
function calculADBase() : Integer;



// Création personnage

{Modifie le fichier personnage ce qui permet de vérifier si le joueur à un personnage.
On utilise 0 et 1 (0 -> il n’a pas de personnage, 1 ->  il a un personnage)}
procedure miseAjourPersonnage (valeur : integer);
{Renvoie si le joueur à un personnage (0 -> il n’a pas, 1 -> il a)}
function getPersonnageActuelle () : Integer;
{Modifie le fichier nom qui contient le nom du joueur}
procedure miseAjourNom(var personnageAct:typePersonnage;valeur : String);
{Renvoie le nom actuelle du joueur contenu dans son fichier}
function getNomActuelle(personnageAct:typePersonnage) : String;
{Modifie le fichier sexe qui contient le sexe du joueur}
procedure miseAjourSexe(var personnageAct:typePersonnage;valeur : String);
{Renvoie le sexe actuelle du joueur contenu dans son fichier}
function getSexeActuelle(personnageAct:typePersonnage) : String;
{Modifie le fichier taille qui contient la taille du joueur}
procedure miseAjourTaille(var personnageAct:typePersonnage;valeur : integer);
{Renvoie la taille actuelle du joueur contenu dans son fichier}
function getTailleActuelle(personnageAct:typePersonnage) : Integer;

//--------------------------- CREATION INVENTAIRE ------------------------------

// Creation d'un inventaire pour un joueur
procedure creationInventaire(var personnage:typePersonnage);

// Remplie tout l'inventaire de '0'
procedure initialisationInventaireVide( var personnage:typePersonnage);

// Ajout du stuff de départ
procedure ajoutStuffDepart(var personnage:typePersonnage);

// Remplis un tableau de tous les items disponibles - BASE DE DONNEE A NE PAS OUVRIR
procedure initialisationItemDisponibles();

//------------------------- DATA -------------------------------

{Principe :
1 : LVL
2 : EXP
3 : GOLD
4 : PERSONNAGE
5 : Combats
6 : skiptour
7 : Bonus1
8 : Bonus2
9 : Bonus3
10 : Bonus4
11 : Bonus5
12 : Bonus6
13 : HPduJoueur}
procedure creationDataJoueur(val,pos : Integer);

procedure modificationDataJoueur(val,pos : Integer);

function dataJoueur(pos : Integer) : Integer;

implementation

uses
    Dos, Classes, SysUtils;



//________________________________________________ Zone Lvl
procedure miseAjourLVL(valeur : Integer);
begin
     modificationDataJoueur(valeur,1);
end;

function getlvlActuelle() : Integer;
begin
     getlvlActuelle := dataJoueur(1);
end;


//________________________________________________ Zone EXP
procedure miseAjourExp(valeur : Integer);
begin
     modificationDataJoueur(valeur,2);
end;

function getExpActuelle() : Integer;
begin
     getExpActuelle := dataJoueur(2);
end;

function calculLvlSuivant() : Integer;
begin
     calculLvlSuivant := 900+100*getlvlActuelle();
end;

procedure verifLvlUp();
begin
     if (getExpActuelle() >= calculLvlSuivant()) then
        begin
              miseAjourLVL(getlvlActuelle()+1);
              miseAjourExp(0+getExpActuelle()-(calculLvlSuivant()-100));
        end;
end;

//________________________________________________ Zone Or

procedure miseAjourOr(valeur : Integer);
begin

     modificationDataJoueur(valeur,3);
end;

function getOrActuelle() : Integer;
begin

     getOrActuelle := dataJoueur(3);
end;


//_________________________________________________ Zone des stats de bas

function calculHpMaxBase() : Integer;
begin
    calculHpMaxBase := 500+(80*getlvlActuelle());
end;

function calculArmureBase() : Integer;
begin
    calculArmureBase := 30+(4*getlvlActuelle());
end;

function calculADBase() : Integer;
begin
    calculADBase := 95+(5*getlvlActuelle());
end;

//__________________________________________________ Création personnage

procedure miseAjourPersonnage(var personnageAct:typePersonnage;valeur : integer);
begin
     modificationDataJoueur(valeur,4);
end;

function getPersonnageActuelle(personnageAct:typePersonnage) : integer;
begin
     getPersonnageActuelle := dataJoueur(4);
end;

procedure miseAjourNom(var personnageAct:typePersonnage;valeur : String);
begin
  Assign(personnageAct.pseudo,'C:\MHNewWorld\nom.txt');
  Rewrite(personnageAct.pseudo);
  Writeln(personnageAct.pseudo,valeur) ;
  Close(personnageAct.pseudo);
end;

function getNomActuelle(personnageAct:typePersonnage) : String;
var nom : string;
begin
     Assign(personnageAct.pseudo,'C:\MHNewWorld\nom.txt');
     reset(personnageAct.pseudo);
     Readln(personnageAct.pseudo,nom);
     getNomActuelle := nom;
     Close(personnageAct.pseudo);
end;

procedure miseAjourSexe(var personnageAct:typePersonnage;valeur : String);
begin
  Assign(personnageAct.sexe,'C:\MHNewWorld\sexe.txt');
  Rewrite(personnageAct.sexe);
  Writeln(personnageAct.sexe,valeur) ;
  Close(personnageAct.sexe);
end;

function getSexeActuelle(personnageAct:typePersonnage) : String;
var sexe : string;
begin
     Assign(personnageAct.sexe,'C:\MHNewWorld\sexe.txt');
     reset(personnageAct.sexe);
     Readln(personnageAct.sexe,sexe);
     getSexeActuelle := sexe;
     Close(personnageAct.sexe);
end;

procedure miseAjourTaille(var personnageAct:typePersonnage;valeur : integer);
begin
    Assign(personnageAct.taille,'C:\MHNewWorld\taille.txt');
    Rewrite(personnageAct.taille);
    Writeln(personnageAct.taille,valeur);
    Close(personnageAct.taille);
end;

function getTailleActuelle(personnageAct:typePersonnage) : Integer;
var taille : string;
begin
     Assign(personnageAct.taille,'C:\MHNewWorld\taille.txt');
     reset(personnageAct.taille);
     Readln(personnageAct.taille,taille);
     getTailleActuelle := StrToInt(taille);
     Close(personnageAct.taille);
end;

// Creation d'un inventaire pour un joueur
procedure creationInventaire(var personnage:typePersonnage);
begin
     initialisationInventaireVide(personnage);
     creationInventaireItem(0,70);
     ajoutStuffDepart(personnage);
end;

// Remplie tout l'inventaire de 'EMPTY'
procedure initialisationInventaireVide( var personnage:typePersonnage);
var
  i:Integer;
  j:integer;
begin

     for i:=0 to 3 do
         begin
         for j:=0 to 3 do
             begin
              personnage.inventaire.invArme[i][j]:=stuffDispo.invArmeDispo[0];
              personnage.inventaire.invArmure[i][j]:=stuffDispo.invArmureDispo[0];
              personnage.inventaire.invDrop[i][j]:=stuffDispo.invDropDispo[0];

             end;
         end;

     for i:= 0 to 1 do
     begin
         for j:=0 to 3 do
             begin
              personnage.inventaire.invPotion[i][j]:=stuffDispo.invPotionDispo[0];
              personnage.inventaire.invBombe[i][j]:=stuffDispo.invBombeDispo[0];
             end;
     end;


     for i:= 1 to 2 do
         begin
         for j:=0 to 2 do
             begin
              personnage.inventaire.ArmureEquipee[i][j]:=stuffDispo.invArmureDispo[0];

              end;
         end;
     personnage.inventaire.ArmeEquipee:=stuffDispo.invArmeDispo[0];



end;

// Ajout du stuff de départ
procedure ajoutStuffDepart(var personnage:typePersonnage);
begin
     ajoutItemToPersonnage('arme',4,personnage);

     equipEquipement(personnage,0,0,'arme');

     ajoutItemToPersonnage('armure',1,personnage);
     equipEquipement(personnage,0,0,'armure');

     ajoutItemToPersonnage('armure',2,personnage);
     equipEquipement(personnage,0,1,'armure');

     ajoutItemToPersonnage('armure',3,personnage);
     equipEquipement(personnage,0,2,'armure');

     ajoutItemToPersonnage('armure',4,personnage);
     equipEquipement(personnage,0,3,'armure');

     ajoutItemToPersonnage('armure',5,personnage);
     equipEquipement(personnage,1,0,'armure');

     ajoutItemToPersonnage('potion',1,personnage);
     ajoutItemToPersonnage('potion',1,personnage);
     ajoutItemToPersonnage('potion',1,personnage);
     equipEquipement(personnage,0,0,'arme');

end;

// Remplis un tableau de tous les items disponibles - BASE DE DONNEE A NE PAS OUVRIR
procedure initialisationItemDisponibles();
begin
     stuffDispo.invArmeDispo[0].nomArme:='VIDE';
     stuffDispo.invArmeDispo[0].poids:=0;
     stuffDispo.invArmeDispo[0].ratioAD:=0;
     stuffDispo.invArmeDispo[0].prix:=0;
     stuffDispo.invArmeDispo[1].nomArme:='Grande epee';
     stuffDispo.invArmeDispo[1].poids:=60;
     stuffDispo.invArmeDispo[1].ratioAD:=0.25;
     stuffDispo.invArmeDispo[1].prix:=70;
     stuffDispo.invArmeDispo[2].nomArme:='Rapiere du ktulu';
     stuffDispo.invArmeDispo[2].poids:=20;
     stuffDispo.invArmeDispo[2].ratioAD:=0.10;
     stuffDispo.invArmeDispo[2].prix:=35;
     stuffDispo.invArmeDispo[3].nomArme:='Epee de Sasuke';
     stuffDispo.invArmeDispo[3].poids:=40;
     stuffDispo.invArmeDispo[3].ratioAD:=0.13;
     stuffDispo.invArmeDispo[3].prix:=42;
     stuffDispo.invArmeDispo[4].nomArme:='Epee simple';
     stuffDispo.invArmeDispo[4].poids:=50;
     stuffDispo.invArmeDispo[4].ratioAD:=0.08;
     stuffDispo.invArmeDispo[4].prix:=38;
     stuffDispo.invArmeDispo[5].nomArme:='Machoire d os';
     stuffDispo.invArmeDispo[5].poids:=80;
     stuffDispo.invArmeDispo[5].ratioAD:=0.43;
     stuffDispo.invArmeDispo[5].prix:=130;
     stuffDispo.invArmeDispo[6].nomArme:='Faucheur jagras';
     stuffDispo.invArmeDispo[6].poids:=65;
     stuffDispo.invArmeDispo[6].ratioAD:=0.33;
     stuffDispo.invArmeDispo[6].prix:=96;
     stuffDispo.invArmeDispo[7].nomArme:='Decapiteur Girros';
     stuffDispo.invArmeDispo[7].poids:=30;
     stuffDispo.invArmeDispo[7].ratioAD:=0.30;
     stuffDispo.invArmeDispo[7].prix:=70;
     stuffDispo.invArmeDispo[8].nomArme:='Furie du leviathan';
     stuffDispo.invArmeDispo[8].poids:=70;
     stuffDispo.invArmeDispo[8].ratioAD:=0.60;
     stuffDispo.invArmeDispo[8].prix:=180;
     stuffDispo.invArmeDispo[9].nomArme:='Foudre hurlante';
     stuffDispo.invArmeDispo[9].poids:=23;
     stuffDispo.invArmeDispo[9].ratioAD:=0.40;
     stuffDispo.invArmeDispo[9].prix:=110;
     stuffDispo.invArmeDispo[10].nomArme:='Magda';
     stuffDispo.invArmeDispo[10].poids:=43;
     stuffDispo.invArmeDispo[10].ratioAD:=0.50;
     stuffDispo.invArmeDispo[10].prix:=140;
     stuffDispo.invArmeDispo[11].nomArme:='Lame de glace';
     stuffDispo.invArmeDispo[11].poids:=21;
     stuffDispo.invArmeDispo[11].ratioAD:=0.30;
     stuffDispo.invArmeDispo[11].prix:=83;
     stuffDispo.invArmeDispo[12].nomArme:='Angoisse';
     stuffDispo.invArmeDispo[12].poids:=30;
     stuffDispo.invArmeDispo[12].ratioAD:=0.45;
     stuffDispo.invArmeDispo[12].prix:=150;
     stuffDispo.invArmeDispo[13].nomArme:='Argent';
     stuffDispo.invArmeDispo[13].poids:=60;
     stuffDispo.invArmeDispo[13].ratioAD:=0.70;
     stuffDispo.invArmeDispo[13].prix:=280;
     stuffDispo.invArmeDispo[14].nomArme:='Lame occulte';
     stuffDispo.invArmeDispo[14].poids:=35;
     stuffDispo.invArmeDispo[14].ratioAD:=0.50;
     stuffDispo.invArmeDispo[14].prix:=130;
     stuffDispo.invArmeDispo[15].nomArme:='Agito';
     stuffDispo.invArmeDispo[15].poids:=25;
     stuffDispo.invArmeDispo[15].ratioAD:=0.40;
     stuffDispo.invArmeDispo[15].prix:=97;
     stuffDispo.invArmeDispo[16].nomArme:='Rasoir';
     stuffDispo.invArmeDispo[16].poids:=15;
     stuffDispo.invArmeDispo[16].ratioAD:=0.20;
     stuffDispo.invArmeDispo[16].prix:=70;
     stuffDispo.invArmeDispo[17].nomArme:='Revolution';
     stuffDispo.invArmeDispo[17].poids:=30;
     stuffDispo.invArmeDispo[17].ratioAD:=0.55;
     stuffDispo.invArmeDispo[17].prix:=140;
     stuffDispo.invArmeDispo[18].nomArme:='Makaire Xiph';
     stuffDispo.invArmeDispo[18].poids:=60;
     stuffDispo.invArmeDispo[18].ratioAD:=0.50;
     stuffDispo.invArmeDispo[18].prix:=110;
     stuffDispo.invArmeDispo[19].nomArme:='Espadon d or';
     stuffDispo.invArmeDispo[19].poids:=70;
     stuffDispo.invArmeDispo[19].ratioAD:=0.40;
     stuffDispo.invArmeDispo[19].prix:=500;
     stuffDispo.invArmeDispo[20].nomArme:='Espadon Kjaar';
     stuffDispo.invArmeDispo[20].poids:=35;
     stuffDispo.invArmeDispo[20].ratioAD:=0.25;
     stuffDispo.invArmeDispo[20].prix:=200;

     stuffDispo.invArmureDispo[0].nomArmure:='VIDE';
     stuffDispo.invArmureDispo[0].poids:=0;
     stuffDispo.invArmureDispo[0].defense:=0;
     stuffDispo.invArmureDispo[0].prix:=0;

     stuffDispo.invArmureDispo[1].nomArmure:='Casque de chasseur';
     stuffDispo.invArmureDispo[1].poids:=3;
     stuffDispo.invArmureDispo[1].defense:=2;
     stuffDispo.invArmureDispo[1].prix:=10;
     stuffDispo.invArmureDispo[1].typeArmure:='Casque';
     stuffDispo.invArmureDispo[2].nomArmure:='Gants de chasseur';
     stuffDispo.invArmureDispo[2].poids:=4;
     stuffDispo.invArmureDispo[2].defense:=2;
     stuffDispo.invArmureDispo[2].prix:=15;
     stuffDispo.invArmureDispo[2].typeArmure:='Gants';
     stuffDispo.invArmureDispo[3].nomArmure:='Plastron de chasseur';
     stuffDispo.invArmureDispo[3].poids:=7;
     stuffDispo.invArmureDispo[3].defense:=6;
     stuffDispo.invArmureDispo[3].prix:=35;
     stuffDispo.invArmureDispo[3].typeArmure:='Plastron';
     stuffDispo.invArmureDispo[4].nomArmure:='Jambiere de chasseur';
     stuffDispo.invArmureDispo[4].poids:=6;
     stuffDispo.invArmureDispo[4].defense:=4;
     stuffDispo.invArmureDispo[4].prix:=25;
     stuffDispo.invArmureDispo[4].typeArmure:='Jambiere';
     stuffDispo.invArmureDispo[5].nomArmure:='Botte de chasseur';
     stuffDispo.invArmureDispo[5].poids:=3;
     stuffDispo.invArmureDispo[5].defense:=2;
     stuffDispo.invArmureDispo[5].prix:=130;
     stuffDispo.invArmureDispo[5].typeArmure:='Bottes';
     stuffDispo.invArmureDispo[6].nomArmure:='Casque de Vespoid';
     stuffDispo.invArmureDispo[6].poids:=5;
     stuffDispo.invArmureDispo[6].defense:=4;
     stuffDispo.invArmureDispo[6].prix:=15;
     stuffDispo.invArmureDispo[6].typeArmure:='Casque';
     stuffDispo.invArmureDispo[7].nomArmure:='Gants de Vespoid';
     stuffDispo.invArmureDispo[7].poids:=3;
     stuffDispo.invArmureDispo[7].defense:=3;
     stuffDispo.invArmureDispo[7].prix:=10;
     stuffDispo.invArmureDispo[7].typeArmure:='Gants';
     stuffDispo.invArmureDispo[8].nomArmure:='Plastron de Vespoid';
     stuffDispo.invArmureDispo[8].poids:=10;
     stuffDispo.invArmureDispo[8].defense:=9;
     stuffDispo.invArmureDispo[8].prix:=15;
     stuffDispo.invArmureDispo[8].typeArmure:='Plastron';
     stuffDispo.invArmureDispo[9].nomArmure:='Jambiere de Vespoid';
     stuffDispo.invArmureDispo[9].poids:=6;
     stuffDispo.invArmureDispo[9].defense:=6;
     stuffDispo.invArmureDispo[9].prix:=10;
     stuffDispo.invArmureDispo[9].typeArmure:='Jambiere';
     stuffDispo.invArmureDispo[10].nomArmure:='Bottes de Vespoid';
     stuffDispo.invArmureDispo[10].poids:=3;
     stuffDispo.invArmureDispo[10].defense:=3;
     stuffDispo.invArmureDispo[10].prix:=5;
     stuffDispo.invArmureDispo[10].typeArmure:='Bottes';
     stuffDispo.invArmureDispo[11].nomArmure:='Casque Hornetaur';
     stuffDispo.invArmureDispo[11].poids:=5;
     stuffDispo.invArmureDispo[11].defense:=10;
     stuffDispo.invArmureDispo[11].prix:=20;
     stuffDispo.invArmureDispo[11].typeArmure:='Casque';
     stuffDispo.invArmureDispo[12].nomArmure:='Plastron Hornetaur';
     stuffDispo.invArmureDispo[12].poids:=20;
     stuffDispo.invArmureDispo[12].defense:=20;
     stuffDispo.invArmureDispo[12].prix:=80;
     stuffDispo.invArmureDispo[12].typeArmure:='Plastron';
     stuffDispo.invArmureDispo[13].nomArmure:='Jambiere Hornetaur';
     stuffDispo.invArmureDispo[13].poids:=10;
     stuffDispo.invArmureDispo[13].defense:=10;
     stuffDispo.invArmureDispo[13].prix:=60;
     stuffDispo.invArmureDispo[13].typeArmure:='Jambiere';
     stuffDispo.invArmureDispo[14].nomArmure:='Botte Hornetaur';
     stuffDispo.invArmureDispo[14].poids:=5;
     stuffDispo.invArmureDispo[14].defense:=5;
     stuffDispo.invArmureDispo[14].prix:=50;
     stuffDispo.invArmureDispo[14].typeArmure:='Bottes';
     stuffDispo.invArmureDispo[15].nomArmure:='Gants Hornetaur';
     stuffDispo.invArmureDispo[15].poids:=5;
     stuffDispo.invArmureDispo[15].defense:=5;
     stuffDispo.invArmureDispo[15].prix:=15;
     stuffDispo.invArmureDispo[15].typeArmure:='Gants';
     stuffDispo.invArmureDispo[16].nomArmure:='Casque de guerre';
     stuffDispo.invArmureDispo[16].poids:=15;
     stuffDispo.invArmureDispo[16].defense:=15;
     stuffDispo.invArmureDispo[16].prix:=150;
     stuffDispo.invArmureDispo[16].typeArmure:='Casque';
     stuffDispo.invArmureDispo[17].nomArmure:='Plastron de guerre';
     stuffDispo.invArmureDispo[17].poids:=40;
     stuffDispo.invArmureDispo[17].defense:=40;
     stuffDispo.invArmureDispo[17].prix:=500;
     stuffDispo.invArmureDispo[17].typeArmure:='Plastron';
     stuffDispo.invArmureDispo[18].nomArmure:='Jambiere de guerre';
     stuffDispo.invArmureDispo[18].poids:=20;
     stuffDispo.invArmureDispo[18].defense:=20;
     stuffDispo.invArmureDispo[18].prix:=300;
     stuffDispo.invArmureDispo[18].typeArmure:='Jambiere';
     stuffDispo.invArmureDispo[19].nomArmure:='Bottes de guerre';
     stuffDispo.invArmureDispo[19].poids:=15;
     stuffDispo.invArmureDispo[19].defense:=15;
     stuffDispo.invArmureDispo[19].prix:=150;
     stuffDispo.invArmureDispo[19].typeArmure:='Bottes';
     stuffDispo.invArmureDispo[20].nomArmure:='Gants de guerre';
     stuffDispo.invArmureDispo[20].poids:=10;
     stuffDispo.invArmureDispo[20].defense:=15;
     stuffDispo.invArmureDispo[20].prix:=150;
     stuffDispo.invArmureDispo[20].typeArmure:='Gants';

     stuffDispo.invPotionDispo[0].nomPotion:='VIDE';
     stuffDispo.invPotionDispo[0].HealHP:=0;
     stuffDispo.invPotionDispo[0].prix:=0;
     stuffDispo.invPotionDispo[1].nomPotion:='Potion';
     stuffDispo.invPotionDispo[1].HealHP:= 250;
     stuffDispo.invPotionDispo[1].prix:= 300;
     stuffDispo.invPotionDispo[2].nomPotion:='Mega Potion';
     stuffDispo.invPotionDispo[2].HealHP:= 550;
     stuffDispo.invPotionDispo[2].prix:=1000;
     stuffDispo.invPotionDispo[3].nomPotion:='Guerison';
     stuffDispo.invPotionDispo[3].HealHP:= 900;
     stuffDispo.invPotionDispo[3].prix:= 1500;

     stuffDispo.invBombeDispo[0].nomBombe:='VIDE';
     stuffDispo.invBombeDispo[0].degat:=0;
     stuffDispo.invBombeDispo[0].prix:=0;

     stuffDispo.invBombeDispo[1].nomBombe:='Bombe Barile';
     stuffDispo.invBombeDispo[1].degat:=300;
     stuffDispo.invBombeDispo[1].prix:=250;
     stuffDispo.invBombeDispo[2].nomBombe:='Bombe Flash';
     stuffDispo.invBombeDispo[2].degat:= 0;
     stuffDispo.invBombeDispo[2].prix:= 700;
     stuffDispo.invBombeDispo[3].nomBombe:='Mega Bombe Barile';
     stuffDispo.invBombeDispo[3].degat:= 500;
     stuffDispo.invBombeDispo[3].prix:=1000;

     stuffDispo.invDropDispo[0].nomDrop:='VIDE';
     stuffDispo.invDropDispo[1].nomDrop:='Ecaille';
     stuffDispo.invDropDispo[2].nomDrop:='Oeil';
     stuffDispo.invDropDispo[3].nomDrop:='Cuir';
     stuffDispo.invDropDispo[4].nomDrop:='Queue';
     stuffDispo.invDropDispo[5].nomDrop:='Pattes brullees';
     stuffDispo.invDropDispo[6].nomDrop:='Os de squelette';
     stuffDispo.invDropDispo[7].nomDrop:='Sang fibreux';
     stuffDispo.invDropDispo[8].nomDrop:='Salive';
     stuffDispo.invDropDispo[9].nomDrop:='Minerais d or';
     stuffDispo.invDropDispo[10].nomDrop:='Poils';
     stuffDispo.invDropDispo[11].nomDrop:='Corne';
     stuffDispo.invDropDispo[12].nomDrop:='Langue de chat';
     stuffDispo.invDropDispo[13].nomDrop:='Carapace';
     stuffDispo.invDropDispo[14].nomDrop:='Plumes';
     stuffDispo.invDropDispo[15].nomDrop:='Crocs de crocodile';
     stuffDispo.invDropDispo[16].nomDrop:='Cristal';
     stuffDispo.invDropDispo[17].nomDrop:='Glandes de venin';
     stuffDispo.invDropDispo[18].nomDrop:='Perle rare';
     stuffDispo.invDropDispo[19].nomDrop:='Bec a pointes';
     stuffDispo.invDropDispo[20].nomDrop:='Larme de phoenix';
end;



procedure creationDataJoueur(val,pos : Integer);
begin
     assign(data, 'C:/MHNewWorld/dataJoueur.bin');
     rewrite(data);
     seek(data,pos);
     write(data,val);
     close(data);
end;


procedure modificationDataJoueur(val,pos : Integer);
begin
     assign(data, 'C:/MHNewWorld/dataJoueur.bin');
     reset(data);
     seek(data,pos);
     write(data,val);
     close(data);
end;

function dataJoueur(pos : Integer) : Integer;
var val : Integer;
begin
     assign(data, 'C:/MHNewWorld/dataJoueur.bin');
     reset(data);
     seek(data, pos);
     read(data,val);
     dataJoueur := val;
     close(data);
end;


end.

