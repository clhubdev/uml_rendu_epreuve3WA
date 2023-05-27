-- REQUETE 1 : Liste des informations (date, heure, immatriculation, marque, modèle, nom et prénom de l'expert) des véhicules à expertiser, à trier par date et heure croissantes ;


    -- Des informations sont absentes pour la réalisation de l'exercice.
    -- Je pars du postulat que dans la table expertise, les colonnes immatriculationn, marque et modele sont des clés étrangères pointant vers vers la table Véhicule. 
    -- Pour les besoins de l'exercice, on considèrera que la table Expertise contient une colonne identité_expert (string) 

    SELECT e.dateHeureRDV, e.immatriculation, e.identite_expert, v.marque, v.modele
    FROM expertise e
    LEFT JOIN vehicule v ON e.immatriculation = v.immatriculation
    ORDER BY e.dateHeureRDV ASC


    SELECT m.dateMission, m.heure, m.immatriculation, v.marque, v.modele, e.nom, e.prenom 
    FROM MissionExpertise m 
    LEFT JOIN Expert e ON (m.idExpert = e.idExpert)
    LEFT JOIN VehiculeExpertise v ON (m.immatriculation = v.immatriculation)
    ORDER BY m.dateMission, m.heureDebut

-- REQUETE 2 : Nombre de véhicules expertisés en 2018 pour chaque expert (nom et prénom);

    SELECT e.nom, e.prenom COUNT(*) AS "nombre_vehicules_expertises"
    FROM Expert e
    LEFT JOIN MissionExpertise m ON (e.idExpert = m.idExpert) 
    WHERE m.dateMission BETWEEN '01/01/18' AND '31/12/2018'
    GROUP BY e.nom;

-- REQUETE 3 Liste des garages (identifiant, nom, ville et téléphone) dans lesquels il y a eu plus de 100 missions créées.

    -- Pour les besoins de l'exercice, on considère qu'il y a une table garage avec comme clé primaire id. Elle comporte aussi les colonnes nom, ville et téléphone. 
    -- Au sein de la table expertise on rajoute une clé étrangère id_garage pointant vers la table garage. 

    SELECT g.idGarage, g.nom, g.ville, g.tel
    FROM garage g
    LEFT JOIN MissionExpertise m ON g.id = m.id_garage
    GROUP BY g.id, g.nom, g.ville, g.telephone
    HAVING COUNT(COALESCE(m.id, 0)) > 100;

-- REQUETE 4 : Requête SQL permettant de créer les tables et les clés étrangères 

    -- Table EXPERT

        CREATE TABLE Expert (
            idExpert INT PRIMARY KEY AUTO_INCREMENT,
            nom VARCHAR(45),
            prenom VARCHAR(45),
            email VARCHAR(45),
            login VARCHAR(45),
            mdp VARCHAR(45)
        );

    -- Table Garage

    CREATE TABLE Garage (
        idGarage INT PRIMARY KEY AUTO_INCREMENT,
        nom VARCHAR(45),
        adnum VARCHAR(45),
        rue VARCHAR(45),
        cp VARCHAR(45),
        ville VARCHAR(45),
        tel VARCHAR(10),
        latitude FLOAT
        longitude FLOAT,
    );

    -- Table MissionExpertise


    CREATE TABLE MissionExpertise (
        idMission INT PRIMARY KEY AUTO_INCREMENT,
        dateMission DATE,
        heureDebut TIME,
        idGarage INT,
        idExpert INT,
        kilometresCompteur INT,
        immatriculation VARCHAR(20),
        FOREIGN KEY (idGarage) REFERENCES Garage(idGarage),
        FOREIGN KEY (idExpert) REFERENCES Expert(idExpert)
    );

    -- Table VéhiculeExpertisé

    CREATE TABLE VehiculeExpertise (
        immatriculation VARCHAR(20),
        marque VARCHAR(45),
        modele VARCHAR(45),
        anneeMiseEnCirculation INT,
        couleur VARCHAR(45),
        idMission INT,
        FOREIGN KEY (idMission) REFERENCES MissionExpertise(idMission)
    );

-- REQUETE 5 : AJOUTER DONNEES DANS LA BDD
    -- Exemple utilisé pour les besoins de l'exercice, table garage.
    -- nom : Garage du bonheur, adnum: 007, rue: rue du bonheur, cp 75001, ville Paris, tel 0100000000, latitude : 90.5, longitude 45.4 

INSERT INTO Garage (nom, adnum, rue, cp, ville, tel, latitude, longitude)
VALUES ('Garage du bonheur', '007', 'rue du bonheur', '75001', 'Paris', '0100000000', 90.5, 45.4);

-- REQUETE 6 : Supprimer des entrées.
    -- Suppression de l'entrée créée par le requête 5.

DELETE FROM Garage WHERE adnum = "007";

