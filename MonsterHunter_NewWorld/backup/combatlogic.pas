unit combatLogic;

{$mode objfpc}{$H+}

interface

type joueurstat = RECORD
     hp : Integer;
     Armure : Integer;
     ad : Integer;
     mobilite : Integer;
     end;


// On initialise les dégats du monstre et du joueur
procedure initStat(num : Integer);

// On fait attaquer le monstre
function monstreAttaque() : Integer;
// On fait attaque le joueur
procedure joueurAttaque();

// Principalement utiliser pour les effets de poison ou autre
procedure degatDebutTour(num : integer);


var poidsarmetemp : Integer = 15;
    poidsarmuretemp : Integer = 30;
    monstreEnCours : Integer;


    // ----------- Combat -------------

    // Joueur
    HPJoueur : Real;
    ArmureJoueur : Integer;
    AdJoueur : Integer;
    MobiliteJoueur : Integer;
    defenseJoueur : Integer = 40;
    ratioArme : Real = 0.25;
    // Monstre
    HPMonstre : Real;
    ArmureMonstre : Real;
    AdMonstre : Integer;

    //fuite
    chancefuite : Integer = 0;

implementation

uses
  Classes, SysUtils,personnage,bestiaireLogic,combatIHM;




procedure initStat(num : Integer);
var i : Integer;
    difficulte : Integer;
    facilerand : Integer;
begin
    randomize;
    monstreEnCours := num;
    facilerand := random(2)+1;

  if (facilerand = 1) then
       facilerand := 1
    else
        facilerand := -1;

    difficulte := random(2);
    //Joueur
    HPJoueur := calculHpMaxBase();
    ArmureJoueur := calculArmureBase() + defenseJoueur;
    AdJoueur := calculADBase();
    MobiliteJoueur := 100 - (poidsarmuretemp+poidsarmetemp);


    // Monstre


    for i:= 1 to (getlvlActuelle(personnage1)) do//+(difficulte*facilerand)) do
        begin
          if (i = 1) then
             begin
                  HPMonstre := EnvoyerMonstre(num).hpBase;
                  ArmureMonstre := EnvoyerMonstre(num).armureBase;
                  AdMonstre := EnvoyerMonstre(num).ad;
             end
          else
             begin
                  HPMonstre := HPMonstre + EnvoyerMonstre(num).ratioHP;
                  ArmureMonstre := ArmureMonstre + EnvoyerMonstre(num).ratioArmure;
                  AdMonstre := AdMonstre + EnvoyerMonstre(num).ratioAd;
             end;
        end;

end;


procedure degatDebutTour(num : integer);
begin
    HPJoueur := HPJoueur - (num*calculHpMaxBase())
end;

function monstreAttaque() : Integer;

var attaque : Integer;
    nattaque : Integer = 0;
    esquive : Integer;
    cesquive : Integer;
begin
    randomize;
    esquive := random(100) + 1;
    cesquive := (EnvoyerMonstre(monstreEnCours).mobilite + (MobiliteJoueur div 2)) div 2;

    if (esquive <= cesquive) then
       begin
            attaque := random(100) + 1;
            if (attaque < EnvoyerMonstre(monstreEnCours).attaque1Chance) then
               nattaque := 1
            else if (attaque >= EnvoyerMonstre(monstreEnCours).attaque1Chance) and (attaque < EnvoyerMonstre(monstreEnCours).attaque2Chance) then
               nattaque := 2
            else if (attaque >= EnvoyerMonstre(monstreEnCours).attaque2Chance) and (attaque < EnvoyerMonstre(monstreEnCours).attaque3Chance) then
               nattaque := 3
            else if (attaque >= EnvoyerMonstre(monstreEnCours).attaque3Chance) and (attaque < EnvoyerMonstre(monstreEnCours).attaque4Chance) then
               nattaque := 4;


            if (nattaque = 1) then
               HPJoueur := HPJoueur - Int((adMonstre + (adMonstre * EnvoyerMonstre(monstreEnCours).attaque1)) / (1+(Int(ArmureJoueur)/500)));
            if (nattaque = 2) then
               HPJoueur := HPJoueur - Int((adMonstre + (adMonstre * EnvoyerMonstre(monstreEnCours).attaque2)) / (1+(Int(ArmureJoueur)/500)));
            if (nattaque = 3) then
               HPJoueur := HPJoueur - Int((adMonstre + (adMonstre * EnvoyerMonstre(monstreEnCours).attaque3)) / (1+(Int(ArmureJoueur)/500)));
            if (nattaque = 4) then
               HPJoueur := HPJoueur - Int((adMonstre + (adMonstre * EnvoyerMonstre(monstreEnCours).attaque4)) / (1+(Int(ArmureJoueur)/500))) ;


       end
    else
        writeln('Equive !');

    monstreAttaque := nattaque;
end;



procedure joueurAttaque();

var
    esquive : Integer;
    cesquive : Integer;
begin
    randomize;
    esquive := random(100) + 1;
    writeln(esquive);
    cesquive := (EnvoyerMonstre(monstreEnCours).mobilite + (MobiliteJoueur div 2)) div 2;
    if (esquive >= cesquive) then
       begin
            HPMonstre := HPMonstre - Int((adJoueur + (adJoueur * ratioArme)) / (1+(Int(EnvoyerMonstre(monstreEnCours).armureBase))/500));
            chancefuite := chancefuite + 2;
       end

    else writeln('Equive !');

end;



end.

