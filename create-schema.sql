CREATE SCHEMA pokemon;
SET search_path TO pokemon;

CREATE TABLE pokemon (
  IDpoke SMALLINT NOT NULL ,
  pokename CHAR(12) NOT NULL ,
  HP SMALLINT NOT NULL,
  attack SMALLINT NOT NULL,
  defense SMALLINT NOT NULL,
  spattack SMALLINT NOT NULL,
  spdefense SMALLINT NOT NULL,
  speed SMALLINT NOT NULL,
  dualtype BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (IDpoke)
);

CREATE TABLE egggroup (
  IDegg SMALLINT NOT NULL ,
  eggname CHAR(12) NOT NULL ,
  PRIMARY KEY (IDegg)
);

CREATE TABLE type (
	IDtype SMALLINT NOT NULL,
	typename CHAR(12) NOT NULL,
	PRIMARY KEY (IDtype)
);

CREATE TABLE abilities (
	IDAbility SMALLINT NOT NULL,
	abilityname CHAR(14) NOT NULL,
	abilitydescrip VARCHAR(255) NOT NULL,
	PRIMARY KEY (IDAbility)
);
CREATE TABLE categories (
  IDcat SMALLINT NOT NULL,
  category CHAR(8) NOT NULL,
   PRIMARY KEY (IDcat)
);

CREATE TABLE moves (
  IDmove SMALLINT NOT NULL,
  movename CHAR(16) NOT NULL ,
  IDtype SMALLINT NOT NULL,
  IDcat SMALLINT NOT NULL,
  power SMALLINT NOT NULL,
  accuracy SMALLINT NOT NULL,
  PP SMALLINT NOT NULL,
  effect VARCHAR(255) NOT NULL,
  PRIMARY KEY (IDmove),
  CONSTRAINT fk_moves_type FOREIGN KEY (IDtype) REFERENCES type (IDtype),
  CONSTRAINT fk_moves_cat FOREIGN KEY (IDcat) REFERENCES categories (IDcat)
);

CREATE TABLE pokeType (
	IDpoke SMALLINT NOT NULL ,
	IDtype SMALLINT NOT NULL,
	PRIMARY KEY (IDpoke,IDtype),
	CONSTRAINT fk_poketype_poke FOREIGN KEY (IDpoke) REFERENCES pokemon (IDpoke),
	CONSTRAINT fk_poketype_type FOREIGN KEY (IDtype) REFERENCES type (IDtype)
);

CREATE TABLE pokeEgg (
	IDpoke SMALLINT NOT NULL ,
	IDegg SMALLINT NOT NULL,
	PRIMARY KEY (IDpoke,IDegg),
	CONSTRAINT fk_pokeegg_poke FOREIGN KEY (IDpoke) REFERENCES pokemon (IDpoke),
	CONSTRAINT fk_pokeegg_egg FOREIGN KEY (IDegg) REFERENCES egggroup (IDegg)
);

CREATE TABLE pokeAbility (
	IDpoke SMALLINT NOT NULL ,
	IDAbility SMALLINT NOT NULL,
    slot CHAR(1) NOT NULL,
	PRIMARY KEY (IDpoke,IDAbility),
	CONSTRAINT fk_pokeAbilitys_poke FOREIGN KEY (IDpoke) REFERENCES pokemon (IDpoke),
	CONSTRAINT fk_pokeAbilitys_move FOREIGN KEY (IDAbility) REFERENCES abilities (IDAbility)
);

CREATE TABLE pokeMoves (
	IDpoke SMALLINT NOT NULL ,
	IDMove SMALLINT NOT NULL,
    slot SMALLINT NOT NULL CHECK (slot >= 1 AND slot <= 4),
	PRIMARY KEY (IDpoke,IDMove),
	CONSTRAINT fk_pokeMoves_poke FOREIGN KEY (IDpoke) REFERENCES pokemon (IDpoke),
	CONSTRAINT fk_pokeMoves_move FOREIGN KEY (IDMove) REFERENCES moves (IDmove)
);

INSERT INTO type VALUES (1, 'Normal');
INSERT INTO type VALUES (2, 'Fighting');
INSERT INTO type VALUES (3, 'Flying');
INSERT INTO type VALUES (4, 'Poison');
INSERT INTO type VALUES (5, 'Ground');
INSERT INTO type VALUES (6, 'Rock');
INSERT INTO type VALUES (7, 'Bug');
INSERT INTO type VALUES (8, 'Ghost');
INSERT INTO type VALUES (9, 'Steel');
INSERT INTO type VALUES (10, 'Fire');
INSERT INTO type VALUES (11, 'Water');
INSERT INTO type VALUES (12, 'Grass');
INSERT INTO type VALUES (13, 'Electric');
INSERT INTO type VALUES (14, 'Psychic');
INSERT INTO type VALUES (15, 'Ice');
INSERT INTO type VALUES (16, 'Dragon');
INSERT INTO type VALUES (17, 'Dark');
INSERT INTO type VALUES (18, 'Fairy');


INSERT INTO egggroup VALUES (1, 'Monster');
INSERT INTO egggroup VALUES (2, 'Water 1');
INSERT INTO egggroup VALUES (3, 'Bug');
INSERT INTO egggroup VALUES (4, 'Flying');
INSERT INTO egggroup VALUES (5, 'Field');
INSERT INTO egggroup VALUES (6, 'Fairy');
INSERT INTO egggroup VALUES (7, 'Grass');
INSERT INTO egggroup VALUES (8, 'Human-Like');
INSERT INTO egggroup VALUES (9, 'Water 3');
INSERT INTO egggroup VALUES (10, 'Mineral');
INSERT INTO egggroup VALUES (11, 'Amorphous');
INSERT INTO egggroup VALUES (12, 'Water 2');
INSERT INTO egggroup VALUES (13, 'Ditto');
INSERT INTO egggroup VALUES (14, 'Dragon');
INSERT INTO egggroup VALUES (15, 'Undiscovered');
INSERT INTO egggroup VALUES (16, 'Genderless');

INSERT INTO categories VALUES (1, 'Physical');
INSERT INTO categories VALUES (2, 'Special');
INSERT INTO categories VALUES (3, 'Status');

INSERT INTO moves VALUES
  (1,  'Tackle',         1, 1, 40, 100, 35, 'Basic physical strike'),
  (2,  'Growl',          1, 3, 0,  100, 40, 'Lowers target Attack by 1 stage'),
  (3,  'Vine Whip',     12, 1, 45, 100, 25, 'Whips target with vines'),
  (4,  'Ember',         10, 2, 40, 100, 25, '10% chance to burn'),
  (5,  'Water Gun',     11, 2, 40, 100, 25, 'Sprays water at target'),
  (6,  'Thunderbolt',   13, 2, 90, 100, 15, '10% chance to paralyze'),
  (7,  'Ice Beam',      15, 2, 90, 100, 10, '10% chance to freeze'),
  (8,  'Quick Attack',   1, 1, 40, 100, 30, 'Priority +1'),
  (9,  'Gust',           3, 2, 40, 100, 35, 'Ranged wind attack'),
  (10, 'Peck',           3, 1, 35, 100, 35, 'Jabs with a beak'),
  (11, 'Confusion',     14, 2, 50, 100, 25, '10% chance to confuse'),
  (12, 'Psychic',       14, 2, 90, 100, 10, '10% chance to lower Sp. Def'),
  (13, 'Earthquake',     5, 1,100, 100, 10, 'Hits all adjacent grounded targets'),
  (14, 'Rock Slide',     6, 1, 75,  90, 10, '30% chance to flinch'),
  (15, 'Hyper Beam',     1, 2,150,  90, 5,  'User must recharge next turn'),
  (16, 'Slash',          1, 1, 70, 100, 20, 'High critical-hit ratio'),
  (17, 'Poison Sting',   4, 1, 15, 100, 35, '30% chance to poison'),
  (18, 'String Shot',    7, 3, 0,   95, 40, 'Lowers target Speed by 1 stage'),
  (19, 'Harden',         1, 3, 0,    0, 30, 'Raises user Defense by 1 stage'),
  (20, 'Sleep Powder',  12, 3, 0,   75, 15, 'Puts target to sleep'),
  (21, 'Hypnosis',      14, 3, 0,   60, 20, 'Puts target to sleep'),
  (22, 'Lick',           8, 1, 30, 100, 30, '30% chance to paralyze'),
  (23, 'Night Shade',    8, 2, 0,  100, 15, 'Deals damage equal to user level'),
  (24, 'Dragon Rage',   16, 2, 0,  100, 10, 'Always deals 40 HP damage'),
  (25, 'Surf',          11, 2, 90, 100, 15, 'Powerful water wave'),
  (26, 'Flamethrower',  10, 2, 90, 100, 15, '10% chance to burn'),
  (27, 'Razor Leaf',    12, 1, 55,  95, 25, 'High critical-hit ratio'),
  (28, 'ThunderShock',  13, 2, 40, 100, 30, '10% chance to paralyze'),
  (29, 'Double Kick',    2, 1, 30, 100, 30, 'Hits twice'),
  (30, 'Karate Chop',    2, 1, 50, 100, 25, 'Solid chop'),
  (31, 'Wing Attack',    3, 1, 60, 100, 35, 'Strikes with wings'),
  (32, 'Bubble',        11, 2, 40, 100, 30, '10% chance to lower Speed'),
  (33, 'Scratch',        1, 1, 40, 100, 35, 'Basic claw attack'),
  (34, 'Teleport',      14, 3, 0,    0, 20, 'Escapes/wild battle utility'),
  (35, 'Splash',         1, 3, 0,    0, 40, 'No effect'),
  (36, 'Blizzard',      15, 2,110,  70, 5,  '10% chance to freeze');

INSERT INTO abilities VALUES (65, 'Overgrow', 'Amplifies Grass-type attacks when HP is low');
INSERT INTO abilities VALUES (66, 'Blaze', 'Amplifies Fire-type attacks when HP is low');
INSERT INTO abilities VALUES (67, 'Torrent', 'Amplifies Water-type attacks when HP is low');
INSERT INTO abilities VALUES (14, 'Compound Eyes', 'Boosts Accuracy');
INSERT INTO abilities VALUES (68, 'Swarm', 'Amplifies Bug-type attacks when HP is low');
INSERT INTO abilities VALUES (51, 'Keen Eye', 'Accuracy cannot be reduced by an opponent');
INSERT INTO abilities VALUES (77, 'Tangled Feet', 'Raises Speed when confused');
INSERT INTO abilities VALUES (9, 'Static', 'May paralyze an opponent that makes contact');
INSERT INTO abilities VALUES (8, 'Sand Veil', 'Increases Evasion in a sandstorm');
INSERT INTO abilities VALUES (56, 'Cute Charm', 'May cause infatuation on contact');
INSERT INTO abilities VALUES (98, 'Magic Guard', 'Grants total protection from indirect damage');
INSERT INTO abilities VALUES (11, 'Water Absorb', 'Water-type attacks heal the Pokémon');
INSERT INTO abilities VALUES (6, 'Damp', 'Prevents use of self-destruction attacks by any Pokémon on the field');
INSERT INTO abilities VALUES (26, 'Levitate', 'Grants immunity to Ground-type moves');
INSERT INTO abilities VALUES (12, 'Oblivious', 'Prevents infatuation');
INSERT INTO abilities VALUES (108, 'Forewarn', 'Shows the opponents most powerful move');
INSERT INTO abilities VALUES (33, 'Swift Swim', 'Doubles speed under rain conditions');
INSERT INTO abilities VALUES (75, 'Shell Armor', 'Grants protection from critical hits');
INSERT INTO abilities VALUES (29, 'Clear Body', 'Stats cannot be lowered by an opponent');
INSERT INTO abilities VALUES (34, 'Chlorophyll', 'Doubles speed under intense sunlight');
INSERT INTO abilities VALUES (94, 'Solar Power', 'Under intense sunlight, Sp. Attack increased, 1/8 HP lost every turn');
INSERT INTO abilities VALUES (44, 'Rain Dish', 'Gradually recovers HP in rain');
INSERT INTO abilities VALUES (110, 'Tinted Lens', 'Raises power of uneffective moves');
INSERT INTO abilities VALUES (97, 'Sniper', 'Increases power of critical hits');
INSERT INTO abilities VALUES (145, 'Big Pecks', 'Defense cannot be lowered by an opponent');
INSERT INTO abilities VALUES (31, 'Lightning Rod', 'Redirects Electric-type attacks towards this Pokémon, nullifies them and increases Sp. Attack');
INSERT INTO abilities VALUES (146, 'Sand Rush', 'Doubles speed in a sandstorm');
INSERT INTO abilities VALUES (132, 'Friend Guard', 'Decreases damage inflicted against ally Pokémon');
INSERT INTO abilities VALUES (87, 'Dry Skin', 'Recovers HP in rain, loses HP under intense sunlight');
INSERT INTO abilities VALUES (133, 'Weak Armor', 'Raises Speed and lowers Defense upon being hit');
INSERT INTO abilities VALUES (135, 'Light Metal', 'Halves weight');
INSERT INTO abilities VALUES (201, 'Intimidate',   'Lowers opposing Pokémon Attack on entry');
INSERT INTO abilities VALUES (202, 'Flash Fire',   'Powers up Fire moves if it is hit by one; immunity to Fire');
INSERT INTO abilities VALUES (203, 'Run Away',     'Ensures escape from wild battles');
INSERT INTO abilities VALUES (204, 'Pickup',       'May pick up items after battle');
INSERT INTO abilities VALUES (205, 'Technician',   'Boosts moves with base power 60 or lower');
INSERT INTO abilities VALUES (206, 'Guts',         'Boosts Attack if statused');
INSERT INTO abilities VALUES (207, 'No Guard',     'All moves used by/against this Pokémon never miss');
INSERT INTO abilities VALUES (208, 'Vital Spirit', 'Prevents sleep');
INSERT INTO abilities VALUES (209, 'Insomnia',     'Prevents sleep');
INSERT INTO abilities VALUES (210, 'Synchronize',  'Passes burn/paralyze/poison to the inflictor');
INSERT INTO abilities VALUES (211, 'Own Tempo',    'Prevents confusion');
INSERT INTO abilities VALUES (212, 'Sturdy',       'Survives one-hit KO moves; endures from full HP');
INSERT INTO abilities VALUES (213, 'Rock Head',    'Prevents recoil damage');
INSERT INTO abilities VALUES (214, 'Magnet Pull',  'Prevents Steel-type foes from fleeing; boosts Steel encounters');
INSERT INTO abilities VALUES (215, 'Stench',       'Odor may cause flinching; repels wild encounters');
INSERT INTO abilities VALUES (216, 'Sticky Hold',  'Prevents item theft; sticky grip');
INSERT INTO abilities VALUES (217, 'Liquid Ooze',  'Draining moves damage the user instead of healing');
INSERT INTO abilities VALUES (218, 'Skill Link',   'Multi-hit moves always strike the maximum number of times');
INSERT INTO abilities VALUES (219, 'Thick Fat',    'Halves damage from Fire and Ice moves');
INSERT INTO abilities VALUES (220, 'Hydration',    'Heals status in rain at end of turn');
INSERT INTO abilities VALUES (221, 'Arena Trap',   'Prevents grounded foes from escaping/switching');
INSERT INTO abilities VALUES (222, 'Poison Point', 'Contact may poison the attacker');
INSERT INTO abilities VALUES (223, 'Rivalry',      'Boosts damage vs. same gender; lowers vs. opposite');
INSERT INTO abilities VALUES (224, 'Gluttony',     'Eats pinch berries at higher HP threshold');
INSERT INTO abilities VALUES (225, 'Effect Spore', 'Contact may inflict sleep/poison/paralysis');
INSERT INTO abilities VALUES (226, 'Cloud Nine',   'Negates effects of weather');
INSERT INTO abilities VALUES (227, 'Early Bird',   'Wakes up quickly');
INSERT INTO abilities VALUES (46, 'Pressure', 'The foe uses 2 PP instead of 1 for moves');


ALTER TABLE pokemon ADD CONSTRAINT unique_pokename UNIQUE (pokename);
ALTER TABLE egggroup ADD CONSTRAINT unique_eggname UNIQUE (eggname);
ALTER TABLE type ADD CONSTRAINT unique_typename UNIQUE (typename);
ALTER TABLE abilities ADD CONSTRAINT unique_abilityname UNIQUE (abilityname);
ALTER TABLE categories ADD CONSTRAINT unique_category UNIQUE (category);

-- PostgreSQL function syntax
CREATE OR REPLACE FUNCTION stat_average(pokeno SMALLINT) 
RETURNS DECIMAL(6,2) AS $$
DECLARE 
    statavg DECIMAL(6,2);
BEGIN
    SELECT (HP+attack+defense+spattack+spdefense+speed)/6.0 INTO statavg
    FROM pokemon
    WHERE IDpoke=pokeno;
    RETURN statavg;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION base_stat_total(pokeno SMALLINT) 
RETURNS SMALLINT AS $$
DECLARE 
    bst SMALLINT;
BEGIN
    SELECT HP+attack+defense+spattack+spdefense+speed INTO bst
    FROM pokemon
    WHERE IDpoke=pokeno;
    RETURN bst;
END;
$$ LANGUAGE plpgsql;
