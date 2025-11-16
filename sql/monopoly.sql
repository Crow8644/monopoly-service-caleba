--
-- This SQL script builds a monopoly database, deleting any pre-existing version.
--
-- @author kvlinden, Caleb Ausema
-- @version Summer, 2015
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS Property;

-- Create the schema.
CREATE TABLE Game (
	ID integer PRIMARY KEY,
	time timestamp
	-- whoseTurn integer REFERENCES Player(ID)
	);

CREATE TABLE Player (
	ID integer PRIMARY KEY, 
	emailAddress varchar(50) NOT NULL,
	name varchar(50)
	);

CREATE TABLE PlayerGame (
	ID integer PRIMARY KEY, -- This was a join table without a primary key, but we are now tracking properties using this
	gameID integer REFERENCES Game(ID), 
	playerID integer REFERENCES Player(ID),
	-- Tracking a lot here allows players to be in multiple in-progress games at once
	score integer, -- Also current money
	currentPosition integer, --This assumes we have numbered every space on the board
	inJail boolean,
	currentTurn boolean
	);

CREATE TABLE Property (
	ownedID integer REFERENCES PlayerGame(ID), 
	baseRent integer,
	numberOfHouses integer
	);

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;


-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO PlayerGame VALUES (1, 1, 1, 0.00, 0, false, true);
INSERT INTO PlayerGame VALUES (2, 1, 2, 0.00, 20, false, false);
INSERT INTO PlayerGame VALUES (3, 1, 3, 2350.00, 4, false, false);
INSERT INTO PlayerGame VALUES (4, 2, 1, 1000.00, 1, false, false);
INSERT INTO PlayerGame VALUES (5, 2, 2, 0.00, 8, false, true);
INSERT INTO PlayerGame VALUES (6, 2, 3, 500.00, 16, false, false);
INSERT INTO PlayerGame VALUES (7, 3, 2, 0.00, 19, false, false);
INSERT INTO PlayerGame VALUES (8, 3, 3, 5500.00, 11, false, false);

INSERT INTO Property VALUES (6, 40, 1);