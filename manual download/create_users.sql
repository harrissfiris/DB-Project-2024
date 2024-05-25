USE masterchef;

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION; 
GRANT PROCESS ON *.* TO 'admin'@'localhost';

-- Δημιουργία των χρηστών και ανάθεση δικαιωμάτων
CREATE USER 'chef1'@'localhost' IDENTIFIED BY 'pass1';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef1'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef1'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef1'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef1'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef1'@'localhost';

CREATE USER 'chef2'@'localhost' IDENTIFIED BY 'pass2';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef2'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef2'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef2'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef2'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef2'@'localhost';

CREATE USER 'chef3'@'localhost' IDENTIFIED BY 'pass3';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef3'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef3'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef3'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef3'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef3'@'localhost';

CREATE USER 'chef4'@'localhost' IDENTIFIED BY 'pass4';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef4'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef4'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef4'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef4'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef4'@'localhost';

CREATE USER 'chef5'@'localhost' IDENTIFIED BY 'pass5';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef5'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef5'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef5'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef5'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef5'@'localhost';

CREATE USER 'chef6'@'localhost' IDENTIFIED BY 'pass6';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef6'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef6'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef6'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef6'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef6'@'localhost';

CREATE USER 'chef7'@'localhost' IDENTIFIED BY 'pass7';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef7'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef7'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef7'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef7'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef7'@'localhost';

CREATE USER 'chef8'@'localhost' IDENTIFIED BY 'pass8';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef8'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef8'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef8'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef8'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef8'@'localhost';

CREATE USER 'chef9'@'localhost' IDENTIFIED BY 'pass9';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef9'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef9'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef9'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef9'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef9'@'localhost';

CREATE USER 'chef10'@'localhost' IDENTIFIED BY 'pass10';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef10'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef10'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef10'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef10'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef10'@'localhost';

CREATE USER 'chef11'@'localhost' IDENTIFIED BY 'pass11';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef11'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef11'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef11'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef11'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef11'@'localhost';

CREATE USER 'chef12'@'localhost' IDENTIFIED BY 'pass12';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef12'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef12'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef12'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef12'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef12'@'localhost';

CREATE USER 'chef13'@'localhost' IDENTIFIED BY 'pass13';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef13'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef13'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef13'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef13'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef13'@'localhost';

CREATE USER 'chef14'@'localhost' IDENTIFIED BY 'pass14';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef14'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef14'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef14'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef14'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef14'@'localhost';

CREATE USER 'chef15'@'localhost' IDENTIFIED BY 'pass15';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef15'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef15'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef15'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef15'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef15'@'localhost';

CREATE USER 'chef16'@'localhost' IDENTIFIED BY 'pass16';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef16'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef16'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef16'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef16'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef16'@'localhost';

CREATE USER 'chef17'@'localhost' IDENTIFIED BY 'pass17';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef17'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef17'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef17'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef17'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef17'@'localhost';

CREATE USER 'chef18'@'localhost' IDENTIFIED BY 'pass18';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef18'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef18'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef18'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef18'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef18'@'localhost';

CREATE USER 'chef19'@'localhost' IDENTIFIED BY 'pass19';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef19'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef19'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef19'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef19'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef19'@'localhost';

CREATE USER 'chef20'@'localhost' IDENTIFIED BY 'pass20';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef20'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef20'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef20'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef20'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef20'@'localhost';

CREATE USER 'chef21'@'localhost' IDENTIFIED BY 'pass21';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef21'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef21'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef21'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef21'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef21'@'localhost';

CREATE USER 'chef22'@'localhost' IDENTIFIED BY 'pass22';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef22'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef22'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef22'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef22'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef22'@'localhost';

CREATE USER 'chef23'@'localhost' IDENTIFIED BY 'pass23';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef23'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef23'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef23'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef23'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef23'@'localhost';

CREATE USER 'chef24'@'localhost' IDENTIFIED BY 'pass24';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef24'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef24'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef24'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef24'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef24'@'localhost';

CREATE USER 'chef25'@'localhost' IDENTIFIED BY 'pass25';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef25'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef25'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef25'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef25'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef25'@'localhost';

CREATE USER 'chef26'@'localhost' IDENTIFIED BY 'pass26';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef26'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef26'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef26'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef26'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef26'@'localhost';

CREATE USER 'chef27'@'localhost' IDENTIFIED BY 'pass27';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef27'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef27'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef27'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef27'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef27'@'localhost';

CREATE USER 'chef28'@'localhost' IDENTIFIED BY 'pass28';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef28'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef28'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef28'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef28'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef28'@'localhost';

CREATE USER 'chef29'@'localhost' IDENTIFIED BY 'pass29';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef29'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef29'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef29'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef29'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef29'@'localhost';

CREATE USER 'chef30'@'localhost' IDENTIFIED BY 'pass30';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef30'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef30'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef30'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef30'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef30'@'localhost';

CREATE USER 'chef31'@'localhost' IDENTIFIED BY 'pass31';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef31'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef31'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef31'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef31'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef31'@'localhost';

CREATE USER 'chef32'@'localhost' IDENTIFIED BY 'pass32';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef32'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef32'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef32'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef32'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef32'@'localhost';

CREATE USER 'chef33'@'localhost' IDENTIFIED BY 'pass33';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef33'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef33'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef33'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef33'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef33'@'localhost';

CREATE USER 'chef34'@'localhost' IDENTIFIED BY 'pass34';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef34'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef34'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef34'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef34'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef34'@'localhost';

CREATE USER 'chef35'@'localhost' IDENTIFIED BY 'pass35';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef35'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef35'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef35'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef35'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef35'@'localhost';

CREATE USER 'chef36'@'localhost' IDENTIFIED BY 'pass36';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef36'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef36'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef36'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef36'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef36'@'localhost';

CREATE USER 'chef37'@'localhost' IDENTIFIED BY 'pass37';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef37'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef37'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef37'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef37'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef37'@'localhost';

CREATE USER 'chef38'@'localhost' IDENTIFIED BY 'pass38';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef38'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef38'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef38'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef38'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef38'@'localhost';

CREATE USER 'chef39'@'localhost' IDENTIFIED BY 'pass39';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef39'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef39'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef39'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef39'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef39'@'localhost';

CREATE USER 'chef40'@'localhost' IDENTIFIED BY 'pass40';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef40'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef40'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef40'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef40'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef40'@'localhost';

CREATE USER 'chef41'@'localhost' IDENTIFIED BY 'pass41';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef41'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef41'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef41'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef41'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef41'@'localhost';

CREATE USER 'chef42'@'localhost' IDENTIFIED BY 'pass42';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef42'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef42'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef42'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef42'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef42'@'localhost';

CREATE USER 'chef43'@'localhost' IDENTIFIED BY 'pass43';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef43'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef43'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef43'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef43'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef43'@'localhost';

CREATE USER 'chef44'@'localhost' IDENTIFIED BY 'pass44';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef44'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef44'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef44'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef44'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef44'@'localhost';

CREATE USER 'chef45'@'localhost' IDENTIFIED BY 'pass45';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef45'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef45'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef45'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef45'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef45'@'localhost';

CREATE USER 'chef46'@'localhost' IDENTIFIED BY 'pass46';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef46'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef46'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef46'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef46'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef46'@'localhost';

CREATE USER 'chef47'@'localhost' IDENTIFIED BY 'pass47';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef47'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef47'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef47'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef47'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef47'@'localhost';

CREATE USER 'chef48'@'localhost' IDENTIFIED BY 'pass48';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef48'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef48'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef48'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef48'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef48'@'localhost';

CREATE USER 'chef49'@'localhost' IDENTIFIED BY 'pass49';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef49'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef49'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef49'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef49'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef49'@'localhost';

CREATE USER 'chef50'@'localhost' IDENTIFIED BY 'pass50';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef50'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef50'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef50'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef50'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef50'@'localhost';

CREATE USER 'chef51'@'localhost' IDENTIFIED BY 'pass51';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef51'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef51'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef51'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef51'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef51'@'localhost';

CREATE USER 'chef52'@'localhost' IDENTIFIED BY 'pass52';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef52'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef52'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef52'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef52'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef52'@'localhost';

CREATE USER 'chef53'@'localhost' IDENTIFIED BY 'pass53';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef53'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef53'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef53'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef53'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef53'@'localhost';

CREATE USER 'chef54'@'localhost' IDENTIFIED BY 'pass54';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef54'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef54'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef54'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef54'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef54'@'localhost';

CREATE USER 'chef55'@'localhost' IDENTIFIED BY 'pass55';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef55'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef55'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef55'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef55'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef55'@'localhost';

CREATE USER 'chef56'@'localhost' IDENTIFIED BY 'pass56';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef56'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef56'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef56'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef56'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef56'@'localhost';

CREATE USER 'chef57'@'localhost' IDENTIFIED BY 'pass57';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef57'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef57'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef57'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef57'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef57'@'localhost';

CREATE USER 'chef58'@'localhost' IDENTIFIED BY 'pass58';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef58'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef58'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef58'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef58'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef58'@'localhost';

CREATE USER 'chef59'@'localhost' IDENTIFIED BY 'pass59';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef59'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef59'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef59'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef59'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef59'@'localhost';

CREATE USER 'chef60'@'localhost' IDENTIFIED BY 'pass60';
GRANT EXECUTE ON PROCEDURE masterchef.update_info TO 'chef60'@'localhost';
GRANT SELECT ON masterchef.chef_info TO 'chef60'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO 'chef60'@'localhost';
GRANT EXECUTE ON PROCEDURE masterchef.update_assigned_recipe TO 'chef60'@'localhost';
GRANT INSERT ON masterchef.contains TO 'chef60'@'localhost';

-- Ανανέωση των δικαιωμάτων
FLUSH PRIVILEGES;