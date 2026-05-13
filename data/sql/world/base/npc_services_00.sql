SET
@Entry      := 300000,
@Model      := 24877,
@Name       := "Cromi",
@Title      := "Instance Reset";

DELETE FROM `creature_template` WHERE `entry` = @Entry;
INSERT INTO `creature_template` (`entry`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `rank`, `unit_class`, `unit_flags`, `type`, `type_flags`, `RegenHealth`, `flags_extra`, `ScriptName`) VALUES(@Entry, @Name, @Title, "Speak", 0, 80, 80, 35, 0, 1, 1.14286, 0, 1, 2, 7, 138936390, 1, 2, "mod_npc_services");
UPDATE `creature_template` SET `npcflag`=`npcflag`|1, `flags_extra`=`flags_extra`|16777216 WHERE `entry`=@Entry;

DELETE FROM `creature_template_model` where creatureid=@Entry;
INSERT INTO `creature_template_model` (CreatureID, Idx, CreatureDisplayID, DisplayScale, Probability, VerifiedBuild) VALUES
(@Entry, '0', @Model, '1', '1', NULL);

DELETE FROM `creature` WHERE (`id1` = @Entry);
INSERT INTO `creature` (`id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@Entry, 0, 0, 571, 0, 0, 1, 1, 0, 5641.15, 671.146, 651.993, 1.67377, 300, 0, 0, 5342, 0, 0, 0, 0, 0, '', NULL, 0, NULL), -- Dalaran (Eventide)
(@Entry, 0, 0, 571, 0, 0, 1, 1, 0, 5966, 630.046, 650.627, 4.8625, 300, 0, 0, 5342, 0, 0, 0, 0, 0, '', NULL, 0, NULL), -- Dalaran (Antonidas)
(@Entry, 0, 0, 0, 0, 0, 1, 1, 0, -8803.54, 670.785, 96.2018, 4.56429, 300, 0, 0, 5342, 0, 0, 0, 0, 0, '', NULL, 0, NULL), -- Stormwind (Auctionhouse)
(@Entry, 0, 0, 0, 0, 0, 1, 1, 0, -4890.18, -983.204, 503.941, 4.76355, 300, 0, 0, 5342, 0, 0, 0, 0, 0, '', NULL, 0, NULL), -- Ironforge (Bank)
(@Entry, 0, 0, 1, 0, 0, 1, 1, 0, 9929.9, 2506.91, 1318.11, 4.5686, 300, 0, 0, 5342, 0, 0, 0, 0, 0, '', NULL, 0, NULL), -- Darnassus (Bank)
(@Entry, 0, 0, 1, 0, 0, 1, 1, 0, -7235.16, -3798.66, -1.13841, 5.83534, 300, 0, 0, 5342, 0, 0, 0, 0, 0, '', NULL, 0, NULL), -- Gadgetzan (Auctionhouse)
(@Entry, 0, 0, 530, 0, 0, 1, 1, 0, -2004.8, 5352.89, -9.35103, 0.775923, 300, 0, 0, 5342, 0, 0, 0, 0, 0, '', NULL, 0, NULL), -- Shattrath (Scryer Bank)
(@Entry, 0, 0, 530, 0, 0, 1, 1, 0, -1718.07, 5495.11, -9.79913, 3.31763, 300, 0, 0, 5342, 0, 0, 0, 0, 0, '', NULL, 0, NULL), -- Shattrath (Aldor Bank)
(@Entry, 0, 0, 530, 0, 0, 1, 1, 0, -695.188, 2705.66, 94.4671, 4.01217, 300, 0, 0, 5342, 0, 0, 0, 0, 0, '', NULL, 0, NULL); -- Honor Hold (Inn)