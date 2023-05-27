<?php

class SocieteFinancement {

    private array $expertises = [];


    public function __construct(
        private int $code,
        private string $nom
    ) {
    }

    // Il existe une relation de composition où SocieteFinancement est le composant de Expertises. Si je supprime la Societe de financement alors je supprime l'ensemble des expertise
    public function __destruct() {
        foreach ($this->expertises as $expertise) {
            unset($expertise);
        }
    }

    public function SocieteFinancement() {

    }
    
    public function AjouterExpertisePool(Pool_garage $pool_garage){
        $this->expertises[] = $pool_garage;
    }

    public function AjouterExpertiseClient(RDV_Client $rdv_client){
        $this->expertises[] = $rdv_client;
    }

    // Question 2.4 Ecrire la méthode Les ExpertisesIndispos de la classe SocieteFinancement qui retourne la collection de toutes les expertises qui ont donné lieu à une indisponibilité
    public function LesExpertiseIndispos(){
        $expertisesIndispos = [];

        foreach( $this->expertises as $mission ) {
            if ($mission->GetIndisponibilite()) {
                $expertisesIndispos[] = $mission->getCodeDossier();
            }
        }

        return $expertisesIndispos;

    }


    // Question 2.5 Ecrire la methode NbIndisponibilits qui retourne le nbs d'expertises indisponibles correspondant au motif passé en paramètre
    public function NbIndisponibilites($motif) {
        
        $nbIndisponibilites = 0;

        foreach( $this->expertises as $mission ) {
            
            if($mission->GetIndisponibilite()->getMotif() === $motif) {
                return $nbIndisponibilites += 1;
            };
        }

        return $nbIndisponibilites;
    }

    public function NbIndisponibilitesParMotif() {
        
    }


        /**
         * Get the value of code
         */ 
        public function getCode()
        {
                return $this->code;
        }

        /**
         * Set the value of code
         *
         * @return  self
         */ 
        public function setCode($code)
        {
                $this->code = $code;

                return $this;
        }

        /**
         * Get the value of nom
         */ 
        public function getNom()
        {
                return $this->nom;
        }

        /**
         * Set the value of nom
         *
         * @return  self
         */ 
        public function setNom($nom)
        {
                $this->nom = $nom;

                return $this;
        }
}


abstract class Expertise {

    private Indisponibilite $indisponibilite;

    public function __construct(
        private int $codeDossier,
        private DateTime $dateHeureRDV,
        private string $lieuRDV,
        private string $adresse, 
        private int $immatriculation,
        private string $marque,
        private string $modele,
    ) {
    }

    
    public function Expertise() {

    }

    public function CreerIndisponiblite() {

    }

    public function EtatExpertise() {

    }

    public function GetIndisponibilite(){
        return $this->indisponibilite;
    }

    public function getCodedossier() {
        return $this->codeDossier;
    }
}


class Pool_garage extends Expertise {
    public function pool_garage() {

    }
}

class RDV_Client extends Expertise {
    public function __construct(
        private string $nomContact,
        private int $tel,
        private int $mail,
    ) {
    }

    public function RDV_Client() {

    }
}

class Indisponibilite {

    public function __construct(
        private bool $clientResponsable,
        private string $motif
    ) {
    }

    public function indisponibilite() {

    }

    public function clientEstResponsable() {

    }


    // Question 2.3 Ecrire la méthode GetMotif de la classe Indisponibilite qui retourne le motif de l'indisponibilité
    public function  getMotif() {
        return $this->motif;
    }

    public function setMotif($motif) {
        $this->motif = $motif;
        return $this;
    }


        /**
         * Get the value of clientResponsable
         */ 
        public function getClientResponsable()
        {
                return $this->clientResponsable;
        }

        /**
         * Set the value of clientResponsable
         *
         * @return  self
         */ 
        public function setClientResponsable($clientResponsable)
        {
                $this->clientResponsable = $clientResponsable;

                return $this;
        }
        
}

