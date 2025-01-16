--modification dans achat details
CREATE OR REPLACE FUNCTION update_total_achat()
RETURNS TRIGGER AS $$
BEGIN
   UPDATE achats
   SET total = (
      SELECT COALESCE(SUM(quantite * prix_unitaire), 0)
      FROM achat_details
      WHERE id_achat = NEW.id_achat
   )
   WHERE id_achat = NEW.id_achat;

   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_total_achat
AFTER INSERT OR UPDATE ON achat_details
FOR EACH ROW
EXECUTE FUNCTION update_total_achat();


--modification dans vente details
CREATE OR REPLACE FUNCTION update_total_vente()
RETURNS TRIGGER AS $$
BEGIN
   UPDATE ventes
   SET total = (
      SELECT COALESCE(SUM(quantite * prix_unitaire * (1 - COALESCE(reduction, 0) / 100)), 0)
      FROM vente_details
      WHERE id_vente = NEW.id_vente
   )
   WHERE id_vente = NEW.id_vente;

   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_total_vente
AFTER INSERT OR UPDATE ON vente_details
FOR EACH ROW
EXECUTE FUNCTION update_total_vente();



CREATE OR REPLACE FUNCTION generate_identifiant()
RETURNS TRIGGER AS $$
BEGIN
    NEW.identifiant := 'CLI' || TO_CHAR(nextval('seq_identifiant'), 'FM000000');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_generate_identifiant
BEFORE INSERT ON client
FOR EACH ROW
EXECUTE FUNCTION generate_identifiant();