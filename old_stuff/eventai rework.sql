-- Mangletooth does not need EventAI.
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=3430;
UPDATE `creature_template` SET `AIName`='' WHERE `entry`=3430;

-- Some scripts have the same action twice.
UPDATE `creature_ai_scripts` SET `action2_type`=`action3_type`, `action2_param1`=`action3_param1`, `action2_param2`=`action3_param2`, `action2_param3`=`action3_param3`, `action3_type`=0, `action3_param1`=0, `action3_param2`=0, `action3_param3`=0 WHERE (action1_type = action2_type) && (action1_param1 = action2_param1)  && (action1_param2 = action2_param2)  && (action1_param3 = action2_param3) && NOT (comment LIKE "%Summon%");

-- Make Tar Lord cast Sticky Tar on self (its a spawn event).
UPDATE `creature_ai_scripts` SET `action1_param2`=0 WHERE `id`=651901;
UPDATE `creature_ai_scripts` SET `action1_param2`=0 WHERE `id`=651801;
UPDATE `creature_ai_scripts` SET `action1_param2`=0 WHERE `id`=651701;

-- These mobs are casters, adding main ranged spell flag.
UPDATE `creature_spells` SET `delayInitialMin_1`=0, `delayInitialMax_1`=0 WHERE `entry`=5890;
UPDATE `creature_spells` SET `castFlags_1`=`castFlags_1`+8 WHERE `entry` IN (5890, 71200, 129220);
UPDATE `creature_spells` SET `castFlags_3`=`castFlags_3`+8 WHERE `entry` IN (95170);

-- Stromgarde Troll Hunter has wrong event type for Cast Shadow Word: Pain.
-- Just moving it to creature_spells system instead.
DELETE FROM `creature_ai_scripts` WHERE `id`=258301;
UPDATE `creature_template` SET `spells_template`=25830 WHERE `entry`=2583;
INSERT INTO `creature_spells` (`entry`, `name`, `spellId_1`, `probability_1`, `castTarget_1`, `castFlags_1`, `delayInitialMin_1`, `delayInitialMax_1`, `delayRepeatMin_1`, `delayRepeatMax_1`, `scriptId_1`) VALUES (25830, 'Arathi Highlands - Stromgarde Troll Hunter', 2767, 100, 1, 0, 2, 5, 19, 23, 0);

-- Quest How Big A Threat 2, use new interrupt cast command to stop channeling.
UPDATE `quest_end_scripts` SET `command`=5, `datalong`=1 WHERE `id`=985 && `delay`=23 && `command`=15;

-- Remove useless events with no actions.
DELETE FROM `creature_ai_scripts` WHERE `id` IN (1066405, 1145507, 1145706);

-- Use flags from DoCastSpellIfCan for SCRIPT_COMMAND_CAST_SPELL.
-- Triggered and interrupt previous cast flags are reversed.
UPDATE `creature_spells_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `creature_spells_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `creature_spells_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `creature_movement_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `creature_movement_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `creature_movement_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `event_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `event_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `event_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `gameobject_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `gameobject_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `gameobject_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `gossip_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `gossip_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `gossip_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `spell_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `spell_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `spell_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `quest_start_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `quest_start_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `quest_start_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `quest_end_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `quest_end_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `quest_end_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;

-- Switched TARGET_T_SELF with TARGET_T_PROVIDED_TARGET (previously TARGET_T_ACTION_INVOKER).
-- UPDATE `creature_spells` SET `castTarget_1`=6 WHERE `spellId_1`!=0 && `castTarget_1`=0;
-- UPDATE `creature_spells` SET `castTarget_2`=6 WHERE `spellId_2`!=0 && `castTarget_2`=0;
-- UPDATE `creature_spells` SET `castTarget_3`=6 WHERE `spellId_3`!=0 && `castTarget_3`=0;
-- UPDATE `creature_spells` SET `castTarget_4`=6 WHERE `spellId_4`!=0 && `castTarget_4`=0;
-- UPDATE `creature_spells` SET `castTarget_5`=6 WHERE `spellId_5`!=0 && `castTarget_5`=0;
-- UPDATE `creature_spells` SET `castTarget_6`=6 WHERE `spellId_6`!=0 && `castTarget_6`=0;
-- UPDATE `creature_spells` SET `castTarget_7`=6 WHERE `spellId_7`!=0 && `castTarget_7`=0;
-- UPDATE `creature_spells` SET `castTarget_8`=6 WHERE `spellId_8`!=0 && `castTarget_8`=0;

-- SCRIPT_COMMAND_TEMP_SUMMON_CREATURE set attack target to TARGET_T_SELF (none).
UPDATE `creature_spells_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `creature_movement_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `event_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `gameobject_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `gossip_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `spell_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `quest_start_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `quest_end_scripts` SET `dataint3`=6 WHERE `command`=10;

-- SCRIPT_COMMAND_TEMP_SUMMON_CREATURE set despawn type to TEMPSUMMON_TIMED_OR_DEAD_DESPAWN.
UPDATE `creature_spells_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `creature_movement_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `event_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `gameobject_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `gossip_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `spell_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `quest_start_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `quest_end_scripts` SET `dataint4`=1 WHERE `command`=10;

-- SCRIPT_COMMAND_TEMP_SUMMON_CREATURE move flags to dataint.
UPDATE `creature_spells_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `creature_spells_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `creature_spells_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `creature_movement_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `creature_movement_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `creature_movement_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `event_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `event_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `event_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `gameobject_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `gameobject_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `gameobject_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `gossip_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `gossip_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `gossip_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `spell_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `spell_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `spell_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `quest_start_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `quest_start_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `quest_start_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `quest_end_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `quest_end_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `quest_end_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);

-- Fix out of range ids in creature_ai_scripts.
UPDATE `creature_ai_scripts` SET `id`=1188001 WHERE `id`=98800622;
UPDATE `creature_ai_scripts` SET `id`=1188002 WHERE `id`=98800623;
UPDATE `creature_ai_scripts` SET `id`=1574401 WHERE `id`=98800621;
UPDATE `creature_ai_scripts` SET `id`=655701 WHERE `id`=98800619;
UPDATE `creature_ai_scripts` SET `id`=1174401 WHERE `id`=98800618;
UPDATE `creature_ai_scripts` SET `id`=1071801 WHERE `id`=98800610;
UPDATE `creature_ai_scripts` SET `id`=1071802 WHERE `id`=98800611;
UPDATE `creature_ai_scripts` SET `id`=1071803 WHERE `id`=98800612;
UPDATE `creature_ai_scripts` SET `id`=1071804 WHERE `id`=98800613;
UPDATE `creature_ai_scripts` SET `id`=1071805 WHERE `id`=98800614;
UPDATE `creature_ai_scripts` SET `id`=1071806 WHERE `id`=98800615;
UPDATE `creature_ai_scripts` SET `id`=1532402 WHERE `id`=98800604;
UPDATE `creature_ai_scripts` SET `id`=1532403 WHERE `id`=98800605;

-- Implement Griniblix the Spectator yelling properly.
DELETE FROM `game_event` WHERE `entry` IN (42, 43, 44);
DELETE FROM `game_event_creature` WHERE `event` IN (42, 43, 44);
DELETE FROM `creature` WHERE `id` IN (987655, 987656, 987657);
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (987655, 987656, 987657);
DELETE FROM `creature_template` WHERE `entry` IN (987655, 987656, 987657);
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (50061, 0, 0, 0, 33014, 0, 35);
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (50061, 0, 0, 0, 33015, 0, 36);
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (50061, 0, 0, 0, 33016, 0, 37);
UPDATE `event_scripts` SET `buddy_id`=0, `buddy_radius`=0, `buddy_type`=0 WHERE `id` IN (9531, 9532, 9533);

-- Implement tanin basket script properly.
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=987600;
DELETE FROM `creature_template` WHERE `entry`=987600;
DELETE FROM `event_scripts` WHERE `id`=8175;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (8175, 0, 10, 14351, 900000, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1, 539.868, 535.142, 27.9186, 0.0017457, 0, 'Gordok Bushwacker spawn');
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (8175, 3, 15, 33027, 0, 0, 0, 14351, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Bushwacker cast spell to begin event');
DELETE FROM `event_scripts` WHERE `id`=8176;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (8176, 2, 0, 1, 0, 0, 0, 14351, 50, 0, 0, 9304, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Bushwacker yell');
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (8176, 3, 3, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 579.912, 535.036, 7.19701, 6.27315, 0, 'Gordok Bushwacker move');
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (8176, 5, 3, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 587.388, 540.713, 6.7703, 1.38797, 0, 'Gordok Bushwacker move');
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (8176, 6, 3, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 586.825, 561.178, -4.74829, 1.59218, 0, 'Gordok Bushwacker move');
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (8176, 7, 3, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 589.013, 586.198, -4.75469, 1.49007, 0, 'Gordok Bushwacker move');

-- Defias Prisoner - Remove condition param from EVENT_T_SPAWNED and instead add normal condition.
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `flags`) VALUES (1706, 33, 34, 0, 0);
UPDATE `creature_ai_scripts` SET `event_param1`=0, `event_param2`=0, `condition_id`=1706 WHERE `id`=170604;


-- RUN AFTER PARSER
-- RUN AFTER PARSER
-- RUN AFTER PARSER


-- Fix buddy type.
UPDATE `creature_spells_scripts` SET `buddy_type`=`buddy_type`+8 WHERE `buddy_id` != 0;
UPDATE `creature_movement_scripts` SET `buddy_type`=`buddy_type`+8 WHERE `buddy_id` != 0;
UPDATE `event_scripts` SET `buddy_type`=`buddy_type`+8 WHERE `buddy_id` != 0;
UPDATE `gameobject_scripts` SET `buddy_type`=`buddy_type`+8 WHERE `buddy_id` != 0;
UPDATE `gossip_scripts` SET `buddy_type`=`buddy_type`+8 WHERE `buddy_id` != 0;
UPDATE `spell_scripts` SET `buddy_type`=`buddy_type`+8 WHERE `buddy_id` != 0;
UPDATE `quest_start_scripts` SET `buddy_type`=`buddy_type`+8 WHERE `buddy_id` != 0;
UPDATE `quest_end_scripts` SET `buddy_type`=`buddy_type`+8 WHERE `buddy_id` != 0;

-- Rename buddy columns to target.
ALTER TABLE `creature_spells_scripts`
	CHANGE COLUMN `buddy_id` `target_param1` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `datalong4`,
	CHANGE COLUMN `buddy_radius` `target_param2` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param1`,
	CHANGE COLUMN `buddy_type` `target_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param2`;
ALTER TABLE `creature_movement_scripts`
	CHANGE COLUMN `buddy_id` `target_param1` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `datalong4`,
	CHANGE COLUMN `buddy_radius` `target_param2` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param1`,
	CHANGE COLUMN `buddy_type` `target_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param2`;
ALTER TABLE `event_scripts`
	CHANGE COLUMN `buddy_id` `target_param1` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `datalong4`,
	CHANGE COLUMN `buddy_radius` `target_param2` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param1`,
	CHANGE COLUMN `buddy_type` `target_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param2`;
ALTER TABLE `gameobject_scripts`
	CHANGE COLUMN `buddy_id` `target_param1` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `datalong4`,
	CHANGE COLUMN `buddy_radius` `target_param2` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param1`,
	CHANGE COLUMN `buddy_type` `target_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param2`;
ALTER TABLE `gossip_scripts`
	CHANGE COLUMN `buddy_id` `target_param1` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `datalong4`,
	CHANGE COLUMN `buddy_radius` `target_param2` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param1`,
	CHANGE COLUMN `buddy_type` `target_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param2`;
ALTER TABLE `spell_scripts`
	CHANGE COLUMN `buddy_id` `target_param1` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `datalong4`,
	CHANGE COLUMN `buddy_radius` `target_param2` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param1`,
	CHANGE COLUMN `buddy_type` `target_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param2`;
ALTER TABLE `quest_start_scripts`
	CHANGE COLUMN `buddy_id` `target_param1` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `datalong4`,
	CHANGE COLUMN `buddy_radius` `target_param2` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param1`,
	CHANGE COLUMN `buddy_type` `target_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param2`;
ALTER TABLE `quest_end_scripts`
	CHANGE COLUMN `buddy_id` `target_param1` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `datalong4`,
	CHANGE COLUMN `buddy_radius` `target_param2` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param1`,
	CHANGE COLUMN `buddy_type` `target_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `target_param2`;

-- This table is no longer needed.
DROP TABLE `creature_ai_summons`;

-- Rename events table.
RENAME TABLE `creature_ai_scripts` TO `creature_ai_events`;

-- Add script id columns to events table.
ALTER TABLE `creature_ai_events`
	ADD COLUMN `action1_script` INT(11) UNSIGNED NOT NULL DEFAULT '0' AFTER `event_param4`,
	ADD COLUMN `action2_script` INT(11) UNSIGNED NOT NULL DEFAULT '0' AFTER `action1_script`,
	ADD COLUMN `action3_script` INT(11) UNSIGNED NOT NULL DEFAULT '0' AFTER `action2_script`,
	DROP COLUMN `action1_type`,
	DROP COLUMN `action1_param1`,
	DROP COLUMN `action1_param2`,
	DROP COLUMN `action1_param3`,
	DROP COLUMN `action2_type`,
	DROP COLUMN `action2_param1`,
	DROP COLUMN `action2_param2`,
	DROP COLUMN `action2_param3`,
	DROP COLUMN `action3_type`,
	DROP COLUMN `action3_param1`,
	DROP COLUMN `action3_param2`,
	DROP COLUMN `action3_param3`;

-- Add new scripts table.
CREATE TABLE IF NOT EXISTS `creature_ai_scripts` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `datalong3` int(10) unsigned NOT NULL DEFAULT '0',
  `datalong4` int(10) unsigned NOT NULL DEFAULT '0',
  `target_param1` int(10) unsigned NOT NULL DEFAULT '0',
  `target_param2` int(10) unsigned NOT NULL DEFAULT '0',
  `target_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `data_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `dataint2` int(11) NOT NULL DEFAULT '0',
  `dataint3` int(11) NOT NULL DEFAULT '0',
  `dataint4` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `comments` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
