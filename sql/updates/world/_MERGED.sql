-- -------------------------------------------------------- 
-- 2011_03_06_0_world_procedures.sql 
-- -------------------------------------------------------- 
-- == ================= ==
-- ==     DROP LIST 27  ==
-- == ================= ==

-- Prevent query execution stop on '' statement
-- SET max_error_count=0;

-- Procedures
DROP PROCEDURE IF EXISTS `sp_CheckNPCOrGO`;
DROP PROCEDURE IF EXISTS `sp_CheckGobjEntry`;
DROP PROCEDURE IF EXISTS `sp_CheckNpcEntry`;
DROP PROCEDURE IF EXISTS `sp_CheckQuestEntry`;
DROP PROCEDURE IF EXISTS `sp_CheckTriggerId`;
DROP PROCEDURE IF EXISTS `sp_eai_CastSpellOnSpawn`;
DROP PROCEDURE IF EXISTS `sp_eai_KillCreditOnDeath`;
DROP PROCEDURE IF EXISTS `sp_eai_KillCreditOnSpellhit`;
DROP PROCEDURE IF EXISTS `sp_eai_selectID`;
DROP PROCEDURE IF EXISTS `sp_GetDifficultyEntry`;
DROP PROCEDURE IF EXISTS `sp_GetLootIdForChest`;
DROP PROCEDURE IF EXISTS `sp_GetReferenceId`;
DROP PROCEDURE IF EXISTS `sp_IgnoreAggro`;
DROP PROCEDURE IF EXISTS `sp_KillQuestgiver`;
DROP PROCEDURE IF EXISTS `sp_MakeAttackable`;
DROP PROCEDURE IF EXISTS `sp_MakeLootable`;
DROP PROCEDURE IF EXISTS `sp_MakeNotAttackable`;
DROP PROCEDURE IF EXISTS `sp_MakeNotLootable`;
DROP PROCEDURE IF EXISTS `sp_NotIgnoreAggro`;
DROP PROCEDURE IF EXISTS `sp_QuestRelations`;
DROP PROCEDURE IF EXISTS `sp_SetFaction`;
DROP PROCEDURE IF EXISTS `sp_SetLootId`;
DROP PROCEDURE IF EXISTS `sp_SetLootIdByList`;
DROP PROCEDURE IF EXISTS `sp_SetNotSelectable`;
DROP PROCEDURE IF EXISTS `sp_SetQuestlevel`;
DROP PROCEDURE IF EXISTS `sp_SetSelectable`;
DROP PROCEDURE IF EXISTS `sp_SpellScriptTarget`;
DROP PROCEDURE IF EXISTS `sp_TriggerSettings`;
DROP PROCEDURE IF EXISTS `sp_ReGuidAlterTables`;
DROP PROCEDURE IF EXISTS `sp_ReGuid`;
DROP PROCEDURE IF EXISTS `sp_eAI_SpawnOnSpellhit`;
DROP PROCEDURE IF EXISTS `sp_GetEntryList`;
DROP PROCEDURE IF EXISTS `sp_eAI_TablePhaseMask`;
DROP PROCEDURE IF EXISTS `sp_eAI_InversePhaseMask`;
DROP PROCEDURE IF EXISTS `sp_UpdateByList`;
DROP PROCEDURE IF EXISTS `sp_UpdateDifficultyEntries`;
DROP PROCEDURE IF EXISTS `sp_UpdateByMap`;

-- == =================== ==
-- ==   DROP LIST 29      ==
-- == =================== ==

DROP PROCEDURE IF EXISTS `sp_error_trigger`;
DROP PROCEDURE IF EXISTS `sp_error_entry`;
DROP PROCEDURE IF EXISTS `sp_error_guid`;
DROP PROCEDURE IF EXISTS `sp_set_npc_lootable_bylist`;
DROP PROCEDURE IF EXISTS `sp_set_npc_lootable`;
DROP PROCEDURE IF EXISTS `sp_set_npc_civilian_bylist`;
DROP PROCEDURE IF EXISTS `sp_set_npc_civilian`;
DROP PROCEDURE IF EXISTS `sp_set_npc_attackable`;
DROP PROCEDURE IF EXISTS `sp_set_npc_attackable_bylist`;
DROP PROCEDURE IF EXISTS `sp_set_npc_targetable`;
DROP PROCEDURE IF EXISTS `sp_set_npc_targetable_bylist`;
DROP PROCEDURE IF EXISTS `sp_set_npc_aggro`;
DROP PROCEDURE IF EXISTS `sp_set_npc_aggro_bylist`;
DROP PROCEDURE IF EXISTS `sp_set_npc_faction`;
DROP PROCEDURE IF EXISTS `sp_set_npc_faction_bylist`;
DROP PROCEDURE IF EXISTS `sp_set_npc_selectable`;
DROP PROCEDURE IF EXISTS `sp_set_npc_selectable_bylist`;
DROP PROCEDURE IF EXISTS `sp_set_npc_deadquest`;
DROP PROCEDURE IF EXISTS `sp_set_spell_target`;
DROP PROCEDURE IF EXISTS `sp_set_npc_trigger`;
DROP PROCEDURE IF EXISTS `sp_set_npc_trigger_bylist`;
DROP PROCEDURE IF EXISTS `sp_set_npc_lootid`;
DROP PROCEDURE IF EXISTS `sp_set_npc_lootid_bylist`;
DROP PROCEDURE IF EXISTS `sp_set_npc_lootid_bytable`;
DROP PROCEDURE IF EXISTS `sp_set_npc_path`;
DROP PROCEDURE IF EXISTS `sp_set_item_money`;
DROP PROCEDURE IF EXISTS `sp_set_item_money_bylist`;
DROP PROCEDURE IF EXISTS `sp_set_entry_list`;
DROP PROCEDURE IF EXISTS `sp_set_quest_previous`;
DROP PROCEDURE IF EXISTS `sp_set_quest_next`;
DROP PROCEDURE IF EXISTS `sp_set_quest_level`;
DROP PROCEDURE IF EXISTS `sp_get_ref_id`;
DROP PROCEDURE IF EXISTS `sp_get_npc_diffentry`;
DROP PROCEDURE IF EXISTS `sp_get_go_lootid`;
DROP PROCEDURE IF EXISTS `sp_eai_inverse_phase_mask`;
DROP PROCEDURE IF EXISTS `sp_eai_table_phase_mask`;
DROP PROCEDURE IF EXISTS `sp_eai_select_id`;
DROP PROCEDURE IF EXISTS `sp_eai_quest_credit_on_spellhit`;
DROP PROCEDURE IF EXISTS `sp_eai_spawn_spellhit`;
DROP PROCEDURE IF EXISTS `sp_eai_cast_onspawn`;
DROP PROCEDURE IF EXISTS `sp_eai_kill_ondeath`;
DROP PROCEDURE IF EXISTS `sp_dev_re_guid`;
DROP PROCEDURE IF EXISTS `sp_dev_reguid_alter_tables`;
DROP PROCEDURE IF EXISTS `sp_dev_cleanup_world`;
DROP PROCEDURE IF EXISTS `sp_dev_cleanup_loot`;
DROP PROCEDURE IF EXISTS `sp_dev_cleanup_reference_loot`;
DROP PROCEDURE IF EXISTS `sp_delete_spell_area`;
DROP PROCEDURE IF EXISTS `sp_delete_spell_position`;
DROP PROCEDURE IF EXISTS `sp_delete_spell_position_bylist`;
DROP PROCEDURE IF EXISTS `sp_delete_spell_target`;
DROP PROCEDURE IF EXISTS `sp_delete_questgiver`;
DROP PROCEDURE IF EXISTS `sp_delete_questtaker`;
DROP PROCEDURE IF EXISTS `sp_delete_spawn`;
DROP PROCEDURE IF EXISTS `sp_delete_script`;
DROP PROCEDURE IF EXISTS `sp_delete_script_bylist`;
DROP PROCEDURE IF EXISTS `sp_delete_npc_trainer`;
DROP PROCEDURE IF EXISTS `sp_delete_npc_vendor`;
DROP PROCEDURE IF EXISTS `sp_delete_loot`;

-- == =================== ==
-- ==   UPDATEPACK 29     ==
-- == =================== ==

-- == =================== ==
-- == delete procedures   ==
-- == =================== ==

DELIMITER //

-- sp_delete_spell_area
CREATE PROCEDURE `sp_delete_spell_area`(IN spell_id INT(10), IN area_id INT(10))
BEGIN
/*
 * DEGREE: BASIC
 * TABLES AFFECTED: spell_area
 * PROCS USED:  none
 *
 * spell_id - NULLABLE. If present, deletes using the spell as a qualifier (if null, only uses area)
 * area_id - NULLABLE. If present, deletes using the area as a qualifier (if null, only uses spell)
 *
 * CALL `sp_delete_spell_area`(1000,NULL); -- delete spell_area entry for spell 1000
 * CALL `sp_delete_spell_area`(NULL,200); -- delete spell_area entry for area 200
 * CALL `sp_delete_spell_area`(1000,200); -- deletes spell_area entry for spell 1000 and area 200
 */ 
        IF spell_id IS NOT NULL OR area_id IS NOT NULL THEN
                DELETE FROM `spell_area` WHERE `spell`=IFNULL(spell_id,`spell`) AND `area`=IFNULL(area_id,`area`);
        ELSE
                CALL MUST_PROVIDE_SPELL_OR_AREA;
        END IF;
END //
        
-- sp_delete_spell_position
CREATE PROCEDURE `sp_delete_spell_position`(IN spell_id INT(10))
BEGIN
/*
 * DEGREE: BASIC
 * TABLES AFFECTED: spell_area
 * PROCS USED:  none
 *
 * CALL `sp_delete_spell_position` (1000); -- delete spell target position entry for spell 1000
 */
        DELETE FROM `spell_target_position` WHERE `id`=spell_id;
END //

-- sp_delete_spell_position_bylist
CREATE PROCEDURE `sp_delete_spell_position_bylist`(IN spell_list LONGTEXT)
BEGIN
/*
 * DEGREE: BASIC
 * TABLES AFFECTED: spell_area
 * PROCS USED:  none
 *
 * CALL `sp_delete_spell_position` (1000); -- delete spell target position entry for spell 1000
 */
        CALL `sp_set_entry_list` (spell_list,null);

        DELETE FROM `spell_target_position` WHERE `id` IN (SELECT * FROM `tdb_entry_list`);

        DROP TABLE `tdb_entry_list`; -- dont forget the cleanup!
END //

-- sp_delete_spell_target
CREATE PROCEDURE `sp_delete_spell_target` (IN spell_id INT(10),IN target_entry INT(10))
BEGIN
/*
 * DEGREE: BASIC
 * TABLES AFFECTED: spell_script_target
 * PROCS USED:  none
 *
 * spell_id - NULLABLE. If present, the spell is used as a qualifier (if null, only use target)
 * target_entry - NULLABLE. If present, the target (either gobj or npc) is used as a qualifer (if null, only use spell)
 *
 * Remove quest relations for gameobject, example of use:
 * CALL `sp_delete_spell_target`(1000,NULL); -- deletes spell_script_target for spell 1000
 * CALL `sp_delete_spell_target`(NULL,200); -- deletes required targets with target entry of creature/gobj id 200
 * CALL `sp_delete_spell_target`(1000,200); -- deletes spell required target for spell id 1000 and creature/gobj entry of 200 only (safest way to delete spell target)
 */
        IF spell_id IS NOT NULL OR target_entry IS NOT NULL THEN
                DELETE FROM `spell_script_target` WHERE `entry`=IFNULL(spell_id,`entry`) AND `targetEntry`=IFNULL(target_entry,`targetEntry`);
        ELSE
                CALL MUST_PROVIDE_SPELL_OR_TARGET;
        END IF;
END //

-- sp_delete_questgiver 
CREATE PROCEDURE `sp_delete_questgiver`(IN qg_type VARCHAR(10),IN qg_entry INT(10), IN quest_entry INT(10))
BEGIN
/*
 * DEGREE: BASIC
 * TABLES AFFECTED: gameobject_questrelation
 * PROCS USED:  none
 *
 * qg_type - The type of quest giver. the only acceptable values are 'GO' and 'NPC'
 * qg_entry - NULLABLE. If present, entry of the gobj or npc whose questrelations is used as a qualifier (if null, only the quest_entry is used)
 * quest_entry - NULLABLE. If present, entry of the quest to use as a qualifier (if null, only the entry is used)
 *
 * CALL `sp_delete_questgiver`('GO',1000,NULL); -- deletes all quest given by object id 1000
 * CALL `sp_delete_questgiver`('GO',NULL,200); -- deletes all go relations to quest 200
 * CALL `sp_delete_questgiver`('NPC',1000,200); -- deletes where NPC 1000 gives quest 200
 */
        IF qg_entry IS NOT NULL OR quest_entry IS NOT NULL THEN
                CASE UCASE(qg_type)
                        WHEN 'NPC' THEN BEGIN
                                DELETE FROM `creature_questrelation` WHERE `id`=IFNULL(qg_entry,`id`) AND `quest`=IFNULL(quest_entry,`quest`);
                        END;
                        WHEN 'GO' THEN BEGIN
                                DELETE FROM `gameobject_questrelation` WHERE `id`=IFNULL(qg_entry,`id`) AND `quest`=IFNULL(quest_entry,`quest`);
                        END;
                        ELSE CALL INVALID_ENTRY_TYPE;
                END CASE;
        ELSE CALL MUST_PROVIDE_ENTRY_OR_QUEST;
        END IF;
END //

-- sp_delete_questtaker
CREATE PROCEDURE `sp_delete_questtaker`(IN qt_type VARCHAR(10),IN qt_entry INT(10), IN quest_entry INT(10))
BEGIN
/*
 * DEGREE: BASIC
 * TABLES AFFECTED: gameobject_questrelation
 * PROCS USED:  none
 *
 * qt_type - The type of quest taker. the only acceptable values are 'GO' and 'NPC'
 * qt_entry - NULLABLE. If present, entry of the gobj or npc whose involvedrelations is used as a qualifier (if null, only the quest_entry is used)
 * quest_entry - NULLABLE. If present, entry of the quest to use as a qualifier (if null, only the entry is used)
 *
 * CALL `sp_delete_questtaker`('GO',1000,NULL); -- deletes all quest taken by object id 1000
 * CALL `sp_delete_questtaker`('GO',NULL,200); -- deletes all go involved gobjs to quest 200
 * CALL `sp_delete_questtaker`('NPC',1000,200); -- deletes where NPC 1000 takes quest 200
 */
        IF qt_entry IS NOT NULL OR quest_entry IS NOT NULL THEN
                CASE UCASE(qt_type)
                        WHEN 'NPC' THEN BEGIN
                                DELETE FROM `creature_involvedrelation` WHERE `id`=IFNULL(qt_entry,`id`) AND `quest`=IFNULL(quest_entry,`quest`);
                        END;
                        WHEN 'GO' THEN BEGIN
                                DELETE FROM `gameobject_involvedrelation` WHERE `id`=IFNULL(qt_entry,`id`) AND `quest`=IFNULL(quest_entry,`quest`);
                        END;
                        ELSE CALL INVALID_ENTRY_TYPE;
                END CASE;
        ELSE CALL MUST_PROVIDE_ENTRY_OR_QUEST;
        END IF;
END //

-- sp_delete spawn
CREATE PROCEDURE `sp_delete_spawn`(IN spawn_type VARCHAR(10),IN spawn_guid INT(10), IN spawn_entry INT(10))
BEGIN
/*
 * DEGREE: BASIC
 * TABLES AFFECTED: gameobject
 * PROCS USED:  none
 *
 * spawn_type - Type of spawn to delete. The only acceptable values are 'GO' or 'NPC'
 * spawn_guid - NULLABLE. If present, the guid is used as a qualifier (if null, only use id and game_event_* is not affected)
 * spawn_entry - NULLABLE. If present, the id is used as a qualifier (if null, only use the guid)
 *
 * CALL `sp_delete_spawn` ('GO',20000,NULL); -- deletes gobj of guid 200000
 * CALL `sp_delete_spawn` ('GO',NULL,10000); -- deletes all gobj spawns of id 10000
 * CALL `sp_delete_spawn` ('NPC',20000,10000); -- deletes a specific npc spawn where guid is 20000 and id is 10000 (safest way to delete spawn)
 */
        IF spawn_guid IS NOT NULL OR spawn_entry IS NOT NULL THEN
                CASE UCASE(spawn_type)
                        WHEN 'NPC' THEN BEGIN
                                DELETE FROM `creature` WHERE `guid`=IFNULL(spawn_guid,`guid`) AND `id`=IFNULL(spawn_entry,`id`);
                                DELETE FROM `game_event_creature` WHERE `guid`=IFNULL(spawn_guid,-1);
                        END;
                        WHEN 'GO' THEN BEGIN
                                DELETE FROM `gameobject` WHERE `guid`=IFNULL(spawn_guid,`guid`) AND `id`=IFNULL(spawn_entry,`id`);
                                DELETE FROM `game_event_gameobject` WHERE `guid`=IFNULL(spawn_guid,-1);
                        END;
                        ELSE CALL INVALID_SPAWN_TYPE;
                END CASE;
        ELSE 
                CALL MUST_PROVIDE_GUID_OR_ENTRY;
        END IF;
END //

-- sp_delete_script
CREATE PROCEDURE `sp_delete_script`(IN script_type VARCHAR(10), IN script_id INT(10))
BEGIN
/*
 * DEGREE: BASIC
 * TABLES AFFECTED: Any table with a name like *_scripts
 * PROCS USED:  none
 *
 * script_type - The type of script to delete (deterimines which table is modified). 
 *             - Only accetable values are 'EAI','GO','GOSSIP','Q_START','Q_END','SPELL', or 'WP'
 * script_id - ID associcated with the script to be deleted
 * 
 * CALL `sp_delete_script`('GO',1000); -- deletes the script of id=1000 from gameobject_scripts
 */
        CASE UCASE(script_type)
                WHEN 'EAI' THEN BEGIN
                        DELETE FROM `creature_ai_scripts` WHERE `id`=script_id;
                END;
                WHEN 'GO' THEN BEGIN
                        DELETE FROM `gameobject_scripts` WHERE `id`=script_id;
                END;
                WHEN 'GOSSIP' THEN BEGIN
                        DELETE FROM `gossip_scripts` WHERE `id`=script_id;
                END;
                WHEN 'Q_START' THEN BEGIN
                        DELETE FROM `quest_start_scripts` WHERE `id`=script_id;
                END;
                WHEN 'Q_END' THEN BEGIN
                        DELETE FROM `quest_end_scripts` WHERE `id`=script_id;
                END;
                WHEN 'SPELL' THEN BEGIN
                        DELETE FROM `spell_scripts` WHERE `id`=script_id;
                END;
                WHEN 'WP' THEN BEGIN
                        DELETE FROM `waypoint_scripts` WHERE `id`=script_id;
                END;
                ELSE CALL INVALID_SCRIPT_TYPE;
        END CASE;
END //

-- sp_delete_script_bylist
CREATE PROCEDURE `sp_delete_script_bylist`(IN script_type VARCHAR(10), IN script_id_list LONGTEXT)
BEGIN
/*
 * DEGREE: BASIC
 * TABLES AFFECTED: Any table with a name like *_scripts
 * PROCS USED:  none
 *
 * script_type - The type of script to delete (deterimines which table is modified). 
 *             - Only accetable values are 'EAI','GO','GOSSIP','Q_START','Q_END','SPELL', or 'WP'
 * script_id - ID associcated with the script to be deleted
 * 
 * CALL `sp_delete_script`('GO',1000); -- deletes the script of id=1000 from gameobject_scripts
 */
        CALL `sp_set_entry_list` (script_id_list,null);

        CASE UCASE(script_type)
                WHEN 'EAI' THEN BEGIN
                        DELETE FROM `creature_ai_scripts` WHERE `id` IN (SELECT * FROM `tdb_entry_list`);
                END;
                WHEN 'GO' THEN BEGIN
                        DELETE FROM `gameobject_scripts` WHERE `id` IN (SELECT * FROM `tdb_entry_list`);
                END;
                WHEN 'GOSSIP' THEN BEGIN
                        DELETE FROM `gossip_scripts` WHERE `id` IN (SELECT * FROM `tdb_entry_list`);
                END;
                WHEN 'Q_START' THEN BEGIN
                        DELETE FROM `quest_start_scripts` WHERE `id` IN (SELECT * FROM `tdb_entry_list`);
                END;
                WHEN 'Q_END' THEN BEGIN
                        DELETE FROM `quest_end_scripts` WHERE `id` IN (SELECT * FROM `tdb_entry_list`);
                END;
                WHEN 'SPELL' THEN BEGIN
                        DELETE FROM `spell_scripts` WHERE `id` IN (SELECT * FROM `tdb_entry_list`);
                END;
                WHEN 'WP' THEN BEGIN
                        DELETE FROM `waypoint_scripts` WHERE `id` IN (SELECT * FROM `tdb_entry_list`);
                END;
                ELSE CALL INVALID_SCRIPT_TYPE;
        END CASE;

        DROP TABLE `tdb_entry_list`; -- dont forget the cleanup!
END //

-- sp_delete_npc_trainer
CREATE PROCEDURE `sp_delete_npc_trainer`(IN npc_entry INT(10), IN spell_id INT(10))
BEGIN
/*
 * DEGREE: BASIC
 * TABLES AFFECTED: npc_trainer
 * PROCS USED:  none
 *
 * npc_entry - NULLABLE. If present, use entry as a qualifier (if null, only use spell)
 * spell_id - NULLABLE. If present, use spell as a qualifier (if null, only use entry)
 *
 * CALL `sp_delete_npc_trainer`(1000,NULL); -- removes entire trainer list for creature with ID 1000
 * CALL `sp_delete_npc_trainer`(NULL,200); -- deletes all trainer entries for spell 200
 * CALL `sp_delete_npc_trainer`(1000,200); -- deletes trainer list for npc 1000 and spell 200
 */
        IF spell_id IS NOT NULL OR npc_entry IS NOT NULL THEN
                DELETE FROM `npc_trainer` WHERE `entry`=IFNULL(npc_entry,`entry`) AND `spell`=IFNULL(spell_id,`spell`);
        ELSE 
                CALL MUST_PROVIDE_ENTRY_OR_SPELL;
        END IF;
END //

-- sp_delete_npc_vendor
CREATE PROCEDURE `sp_delete_npc_vendor`(IN npc_entry INT(10), IN item_entry INT(10))
BEGIN
/*
 * DEGREE: BASIC
 * TABLES AFFECTED: npc_trainer
 * PROCS USED:  none
 *
 * npc_entry - NULLABLE. If present, use entry as a qualifier (if null, only use item)
 * item_entry - NULLABLE. If present, use item as a qualifier (if null, only use entry)
 * 
 * CALL `sp_delete_npc_trainer`(1000,NULL); -- deletes vendor list for NPC 1000
 * CALL `sp_delete_npc_trainer`(NULL,200); -- deletes vendor entries for item 200
 * CALL `sp_delete_npc_trainer`(1000,200); -- deletes vendor list for npc 1000 and item 200
 */
        IF item_entry IS NOT NULL OR npc_entry IS NOT NULL THEN
                DELETE FROM `npc_vendor` WHERE `entry`=IFNULL(npc_entry,`entry`) AND `item`=IFNULL(item_entry,`item`);
        ELSE
                CALL MUST_PROVIDE_ENTRY_OR_ITEM;
        END IF;
END //

-- sp_delete_loot (bitchslap to this proc brought to you by denyde)
CREATE PROCEDURE `sp_delete_loot` (IN loot_type VARCHAR(10),IN loot_entry INT(10),IN item_entry INT(10))
BEGIN
/*
 * DEGREE: BASIC
 * TABLES AFFECTED: *_loot_template
 * PROCS USED:  none
 *
 * loot_type - Type of loot to delete
 *           - The only acceptable values are 'FISH','NPC','GO','ITEM','DISENCH','PROSPECT','MILL','PICKPOCKET','SKIN','QUEST', or 'REF'
 * loot_entry - NULLABLE. If present, use entry as a qualifier in the specified table (if null, only use item)
 * item_entry - NULLABLE. If present, use item as a qualifier in the specified table (if null, only use entry)
 *
 * CALL `sp_delete_loot`('GO',20000,NULL); -- deletes all loot of gobj whose type=3 (chest) and data1 is 20000
 * CALL `sp_delete_loot`('PROSPECT',NULL,10000); -- deletes all loot of item_template entry 10000 from prospecting loot
 * CALL `sp_delete_loot`('NPC',20000,10000); -- deletes a loot of an npc whose lootid=20000 and drops item 10000 directly from 
 */
        IF loot_entry IS NOT NULL OR item_entry IS NOT NULL THEN
                CASE UCASE(loot_type)
                        WHEN 'FISH' THEN BEGIN
                                DELETE FROM `fishing_loot_template` WHERE `entry`=IFNULL(loot_entry,`entry`) AND `item`=IFNULL(item_entry,`item`);
                        END;
                        WHEN 'NPC' THEN BEGIN
                                DELETE FROM `creature_loot_template` WHERE `entry`=IFNULL(loot_entry,`entry`) AND `item`=IFNULL(item_entry,`item`);
                        END;
                        WHEN 'GO' THEN BEGIN
                                DELETE FROM `gameobject_loot_template` WHERE `entry`=IFNUofcLL(loot_entry,`entry`) AND `item`=IFNULL(item_entry,`item`);
                        END;
                        WHEN 'ITEM' THEN BEGIN
                                DELETE FROM `item_loot_template` WHERE `entry`=IFNULL(loot_entry,`entry`) AND `item`=IFNULL(item_entry,`item`);
                        END;
                        WHEN 'DISENCH' THEN BEGIN
                                DELETE FROM `disenchant_loot_template` WHERE `entry`=IFNULL(loot_entry,`entry`) AND `item`=IFNULL(item_entry,`item`);
                        END;
                        WHEN 'PROSPECT' THEN BEGIN
                                DELETE FROM `propspecting_loot_template` WHERE `entry`=IFNULL(loot_entry,`entry`) AND `item`=IFNULL(item_entry,`item`);
                        END;
                        WHEN 'MILL' THEN BEGIN
                                DELETE FROM `millling_loot_template` WHERE `entry`=IFNULL(loot_entry,`entry`) AND `item`=IFNULL(item_entry,`item`);
                        END;
                        WHEN 'PICKPOCKET' THEN BEGIN
                                DELETE FROM `pickpocketing_loot_template` WHERE `entry`=IFNULL(loot_entry,`entry`) AND `item`=IFNULL(item_entry,`item`);
                        END;
                        WHEN 'SKIN' THEN BEGIN
                                DELETE FROM `skinning_loot_template` WHERE `entry`=IFNULL(loot_entry,`entry`) AND `item`=IFNULL(item_entry,`item`);
                        END;
                        WHEN 'QUEST' THEN BEGIN
                                DELETE FROM `quest_loot_template` WHERE `entry`=IFNULL(loot_entry,`entry`) AND `item`=IFNULL(item_entry,`item`);
                        END;
                        WHEN 'REF' THEN BEGIN
                                IF loot_entry IS NOT NULL THEN
                                        DELETE FROM `creature_loot_template` WHERE `mincountOrRef`=-loot_entry;
                                        DELETE FROM `disenchant_loot_template` WHERE `mincountOrRef`=-loot_entry;
                                        DELETE FROM `fishing_loot_template` WHERE `mincountOrRef`=-loot_entry;
                                        DELETE FROM `gameobject_loot_template` WHERE `mincountOrRef`=-loot_entry;
                                        DELETE FROM `item_loot_template` WHERE `mincountOrRef`=-loot_entry;
                                        DELETE FROM `mail_loot_template` WHERE `mincountOrRef`=-loot_entry;
                                        DELETE FROM `milling_loot_template` WHERE `mincountOrRef`=-loot_entry;
                                        DELETE FROM `pickpocketing_loot_template` WHERE `mincountOrRef`=-loot_entry;
                                        DELETE FROM `prospecting_loot_template` WHERE `mincountOrRef`=-loot_entry;
                                        DELETE FROM `skinning_loot_template` WHERE `mincountOrRef`=-loot_entry;
                                        DELETE FROM `spell_loot_template` WHERE `mincountOrRef`=-loot_entry;
                                END IF;
                                
                                DELETE FROM `reference_loot_template` WHERE `entry`=IFNULL(loot_entry,`entry`) AND `item`=IFNULL(item_entry,`item`);
                        END;
                        ELSE CALL INVALID_LOOT_TYPE;
                END CASE;
        ELSE 
                CALL MUST_PROVIDE_ENTRY_OR_ITEM;
        END IF;
END //


-- ------------------ --
-- EAI procedures     --
-- ------------------ --

CREATE PROCEDURE `sp_eai_select_id`(IN npc_entry INT(10), OUT event_id INT(10))
BEGIN
/**
 * DEGREE: UTILITY
 * TABLES AFFECT: creature_ai_scripts
 * PROCS USERD: none
 *
 * Check if eAI exists and add pick best id for new entries
 * To be used inside other eAI procs only!
 * 
 * ex: CALL `sp_eai_select_id` (257); -- selects new creature_ai_scripts.id for NPC entry 257 (Kobold Worker) and deletes old eAI added by procedures 
 */
        CALL `sp_error_entry`('NPC',npc_entry);
        SET event_id = (SELECT MAX(id)+1 FROM `creature_ai_scripts` WHERE `creature_id`=npc_entry);
    DELETE FROM `creature_ai_scripts` WHERE `creature_id`=npc_entry AND `comment` LIKE "Stored procedures eAI%";
END //

-- `eai_TablePhaseMask`
CREATE
    PROCEDURE `sp_eai_table_phase_mask`()
    BEGIN
 /*
 * DEGREE: UTILITY
 * TABLES AFFECTED: NONE
 * PROCS USED: NONE
 *
 * THIS PROCEDURE IS AN INTEGRAL PART OF `sp_eai_inverse_phase_mask` PROC. AND HAS NO OTHER USE!!!
 *
 */
CREATE TABLE `phase_mask`(
`phaseID` INT(2) NOT NULL DEFAULT '0' ,
`phase_mask` INT(11) UNSIGNED NOT NULL DEFAULT '0' ,
PRIMARY KEY (`phaseID`));
INSERT INTO phase_mask VALUES
(0,1),
(1,2),
(2,4),
(3,8),
(4,16),
(5,32),
(6,64),
(7,128),
(8,256),
(9,512),
(10,1024),
(11,2048),
(12,4096),
(13,8192),
(14,16384),
(15,32768),
(16,65536),
(17,131072),
(18,262144),
(19,524288),
(20,1048576),
(21,2097152),
(22,4194304),
(23,8388608),
(24,16777216),
(25,33554432),
(26,67108864),
(27,134217728),
(28,268435456),
(29,536870912),
(30,1073741824),
(31,2147483648);
    END//

CREATE
    PROCEDURE `sp_eai_inverse_phase_mask`(IN max_phase INT, IN phase_list VARCHAR(255))
    BEGIN
/*
 * DEGREE:UTILITY
 * TABLES AFFECTED: NONE
 * PROCS USED: sp_set_entry_list
 *
 *
 * Procedure to select value for field event_inverse_phase_mask in creature_ai_scripts table
 *
 * max_phase = number of maximum phase used for creature:
 * phase_list = list of phase IDs in which event will occur 
 * example call: CALL `sp_eai_inverse_phase_mask`(3,"2,1");
 * If creature will should enter phase: 0,1,2,3 - then max_phase value is 3
 * phase_list assigns in which phases event WILL occur
 * so if we want NPC using 3 phases (0-3) to take action from eAI while he's in phase 2 OR 3
 * the call for procedure would be: CALL `sp_eAI_InversePhaseMask`(3,"2,3");
 *
 */
DECLARE max_phase_mask INT;
DECLARE phase_yes INT;
DECLARE inverse_phase_mask INT;
CALL `sp_eai_table_phase_mask`();
CALL `sp_set_entry_list`(phase_list);
SET max_phase_mask = (SELECT SUM(phase_mask) FROM phase_mask WHERE phaseID <= max_phase);
SET phase_yes = (SELECT SUM(phase_mask) FROM phase_mask WHERE phaseID IN (SELECT `value` FROM tdb_entry_list));
SET inverse_phase_mask = (max_phase_mask - phase_yes);
DROP TABLE `tdb_entry_list`;
DROP TABLE `phase_mask`;
IF inverse_phase_mask < 0 THEN
SELECT "PhaseID is bigger then maximum phase entered" AS `inverse_phase_mask`;
ELSE IF phase_list="0" THEN
SELECT 0 AS `inverse_phase_mask`;
ELSE
SELECT inverse_phase_mask;
END IF;
END IF;
    END//

-- ------------------ --
--  SINGLE RUN PROC   --
-- ------------------ --

CREATE
    PROCEDURE `sp_dev_reguid_alter_tables`()
    BEGIN
/**
 * DEGREE: UTILITY
 * TABLES AFFECT: many
 * PROCS USERD: none
 *
 * THIS PROCEDURE IS A PART OF `sp_dev_re_guid` AND HAS NO OTHER USE!
 */
            CREATE TABLE `creature_temp` (
  `guid` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Global Unique Identifier',
  `id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Creature Identifier',
  `map` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `spawnMask` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `phaseMask` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '1',
  `modelid` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `equipment_id` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `position_x` FLOAT NOT NULL DEFAULT '0',
  `position_y` FLOAT NOT NULL DEFAULT '0',
  `position_z` FLOAT NOT NULL DEFAULT '0',
  `orientation` FLOAT NOT NULL DEFAULT '0',
  `spawntimesecs` INT(10) UNSIGNED NOT NULL DEFAULT '120',
  `spawndist` FLOAT NOT NULL DEFAULT '5',
  `currentwaypoint` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `curhealth` INT(10) UNSIGNED NOT NULL DEFAULT '1',
  `curmana` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `DeathState` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `MovementType` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `old_guid` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`guid`),
  KEY `idx_map` (`map`),
  KEY `idx_id` (`id`)
) ENGINE=MYISAM AUTO_INCREMENT=250001 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature System';
        ALTER TABLE `creature_addon` ADD COLUMN `new_guid` INT(10) UNSIGNED NOT NULL;
        ALTER TABLE `creature_formations` ADD COLUMN `new_guid_leader` INT(10) UNSIGNED NOT NULL;
        ALTER TABLE `creature_formations` ADD COLUMN `new_guid_member` INT(10) UNSIGNED NOT NULL;
        ALTER TABLE `creature_linked_respawn` ADD COLUMN `new_guid` INT(10) UNSIGNED NOT NULL;
        ALTER TABLE `creature_linked_respawn` ADD COLUMN `new_linked_guid` INT(10) UNSIGNED NOT NULL;
        ALTER TABLE `game_event_creature` ADD COLUMN `new_guid` INT(10) UNSIGNED NOT NULL;
        ALTER TABLE `pool_creature` ADD COLUMN `new_guid` INT(10) UNSIGNED NOT NULL;
        ALTER TABLE `game_event_model_equip` ADD COLUMN `new_guid` INT(10) UNSIGNED NOT NULL;
        ALTER TABLE `game_event_npc_gossip` ADD COLUMN `new_guid` INT(10) UNSIGNED NOT NULL;
        ALTER TABLE `game_event_npc_vendor` ADD COLUMN `new_guid` INT(10) UNSIGNED NOT NULL;
        ALTER TABLE `game_event_npcflag` ADD COLUMN `new_guid` INT(10) UNSIGNED NOT NULL;
        ALTER TABLE `npc_gossip` ADD COLUMN `new_guid` INT(10) UNSIGNED NOT NULL;
    END//
        
        
CREATE
    PROCEDURE `sp_dev_re_guid`(IN new_base_guid INT(10))
    BEGIN
/**
 * DEGREE: UTILITY
 * TABLES AFFECT: any with creature.guid value in use
 * PROCS USED: `sp_dev_re_guid_alter_tables`
 *
 * THIS PROCEDURE IS IN A TESTING PHASE, USE AT OWN RISK!
 * 
 * ex: CALL `sp_dev_re_guid`(1000); -- will renumber all existing guids in creature table starting with 1000 as initial
 */
    CALL `sp_dev_reguid_alter_tables`();
    SET @s = CONCAT("ALTER TABLE `creature_temp` AUTO_INCREMENT=",new_base_guid,";");
    PREPARE STM FROM @s;
    EXECUTE STM;
    INSERT INTO `creature_temp` (id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType,old_guid)
    SELECT id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType,guid FROM `creature` ORDER BY `id` ASC;
    UPDATE `creature_temp` SET guid = old_guid WHERE `old_guid`>250000;    
                UPDATE game_event_npc_gossip p
                INNER JOIN creature_temp pp
                ON p.guid = pp.old_guid
                SET p.new_guid = pp.guid;
                UPDATE game_event_npc_vendor p
                INNER JOIN creature_temp pp
                ON p.guid = pp.old_guid
                SET p.new_guid = pp.guid;
                UPDATE game_event_npcflag p
                INNER JOIN creature_temp pp
                ON p.guid = pp.old_guid
                SET p.new_guid = pp.guid;
                UPDATE npc_gossip p
                INNER JOIN creature_temp pp
                ON p.npc_guid = pp.old_guid
                SET p.new_guid = pp.guid;
                UPDATE game_event_model_equip p
                INNER JOIN creature_temp pp
                ON p.guid = pp.old_guid
                SET p.new_guid = pp.guid;
                UPDATE creature_addon p
                INNER JOIN creature_temp pp
                ON p.guid = pp.old_guid
                SET p.new_guid = pp.guid;
                UPDATE creature_formations p
                INNER JOIN creature_temp pp
                ON p.leaderGUID = pp.old_guid
                SET p.new_guid_leader = pp.guid;
                UPDATE creature_formations p
                INNER JOIN creature_temp pp
                ON p.memberGUID = pp.old_guid
                SET p.new_guid_member = pp.guid;
                UPDATE creature_linked_respawn p
                INNER JOIN creature_temp pp
                ON p.guid = pp.old_guid
                SET p.new_guid = pp.guid;
                UPDATE creature_linked_respawn p
                INNER JOIN creature_temp pp
                ON p.guid = pp.old_guid
                SET p.new_linked_guid = pp.guid;
                UPDATE game_event_creature p
                INNER JOIN creature_temp pp
                ON p.guid = pp.old_guid
                SET p.new_guid = pp.guid;
                UPDATE pool_creature p
                INNER JOIN creature_temp pp
                ON p.guid = pp.old_guid
                SET p.new_guid = pp.guid;
                ALTER TABLE `creature_temp` DROP COLUMN `old_guid`;
                DROP TABLE `creature`;
                RENAME TABLE `creature_temp` TO `creature`;
                ALTER TABLE game_event_npc_gossip DISABLE KEYS;
                UPDATE `game_event_npc_gossip` SET `guid`=`new_guid`;        
                ALTER TABLE `game_event_npc_gossip` DROP COLUMN `new_guid`;
                ALTER TABLE game_event_npc_gossip ENABLE KEYS;
                ALTER TABLE game_event_npc_vendor DISABLE KEYS;
                UPDATE `game_event_npc_vendor` SET `guid`=`new_guid`;        
                ALTER TABLE `game_event_npc_vendor` DROP COLUMN `new_guid`;
                ALTER TABLE game_event_npc_vendor ENABLE KEYS;
                ALTER TABLE game_event_npcflag DISABLE KEYS;
                UPDATE `game_event_npcflag` SET `guid`=`new_guid`;        
                ALTER TABLE `game_event_npcflag` DROP COLUMN `new_guid`;
                ALTER TABLE game_event_npcflag ENABLE KEYS;
                ALTER TABLE `npc_gossip` DROP PRIMARY KEY;
                UPDATE `npc_gossip` SET `npc_guid`=`new_guid`;      
                SELECT npc_guid,new_guid FROM npc_gossip;  
                ALTER TABLE `npc_gossip` DROP COLUMN `new_guid`;
                ALTER TABLE `npc_gossip` ADD PRIMARY KEY(`npc_guid`);
                ALTER TABLE game_event_model_equip DISABLE KEYS;
                UPDATE `game_event_model_equip` SET `guid`=`new_guid`;        
                ALTER TABLE `game_event_model_equip` DROP COLUMN `new_guid`;
                ALTER TABLE game_event_model_equip ENABLE KEYS;
                ALTER TABLE `creature_addon` DROP PRIMARY KEY;
                UPDATE `creature_addon` SET `guid`=`new_guid`;        
                ALTER TABLE `creature_addon` DROP COLUMN `new_guid`;
                ALTER TABLE `creature_addon` ADD PRIMARY KEY(`guid`);
                ALTER TABLE creature_formations DISABLE KEYS;
                UPDATE `creature_formations` SET leaderGUID = new_guid_leader;
                ALTER TABLE `creature_formations` DROP COLUMN `new_guid_leader`;
                UPDATE `creature_formations` SET memberGUID = new_guid_member;
                ALTER TABLE `creature_formations` DROP COLUMN `new_guid_member`;
                ALTER TABLE creature_formations ENABLE KEYS;
                ALTER TABLE `creature_linked_respawn` DROP PRIMARY KEY;
                UPDATE `creature_linked_respawn` SET guid = new_guid;
                ALTER TABLE `creature_linked_respawn` DROP COLUMN `new_guid`;
                UPDATE `creature_linked_respawn` SET linkedGuid = new_linked_guid;
                ALTER TABLE `creature_linked_respawn` DROP COLUMN `new_linked_guid`;
                ALTER TABLE `creature_linked_respawn` ADD PRIMARY KEY(`guid`);
                ALTER TABLE `game_event_creature` DROP PRIMARY KEY;
                UPDATE `game_event_creature` SET guid = new_guid;
                ALTER TABLE `game_event_creature` DROP COLUMN `new_guid`;
                ALTER TABLE `game_event_creature` ADD PRIMARY KEY(`guid`);
                ALTER TABLE pool_creature DISABLE KEYS;
                UPDATE `pool_creature` SET guid = new_guid;
                ALTER TABLE `pool_creature` DROP COLUMN `new_guid`;
                ALTER TABLE pool_creature ENABLE KEYS;

    END //
        
        
CREATE
    PROCEDURE `sp_dev_cleanup_reference_loot`()
    BEGIN
/*SQL by Gyullo
 * Cleanup procedure for referenced loot tables
 * Remember to have backup before running!
 * Example call:
 * USE `your_world_db_name`;
 * CALL sp_dev_cleanup_reference_loot();
 * */
-- DROP TABLE IF EXISTS `RL_temp`;
CREATE TABLE `RL_temp` (
    `ref_id` INT(8) UNSIGNED NOT NULL PRIMARY KEY DEFAULT '0'
);
INSERT IGNORE INTO `RL_temp` SELECT DISTINCT(`mincountOrRef`)*-1 FROM `gameobject_loot_template` WHERE `mincountOrRef` <0;
INSERT IGNORE INTO `RL_temp` SELECT DISTINCT(`mincountOrRef`)*-1 FROM `item_loot_template` WHERE `mincountOrRef` <0;
INSERT IGNORE INTO `RL_temp` SELECT DISTINCT(`mincountOrRef`)*-1 FROM `creature_loot_template` WHERE `mincountOrRef` <0;
INSERT IGNORE INTO `RL_temp` SELECT DISTINCT(`mincountOrRef`)*-1 FROM `spell_loot_template` WHERE `mincountOrRef` <0;
INSERT IGNORE INTO `RL_temp` SELECT DISTINCT(`mincountOrRef`)*-1 FROM `prospecting_loot_template` WHERE `mincountOrRef` <0;
INSERT IGNORE INTO `RL_temp` SELECT DISTINCT(`mincountOrRef`)*-1 FROM `milling_loot_template` WHERE `mincountOrRef` <0;
INSERT IGNORE INTO `RL_temp` SELECT DISTINCT(`mincountOrRef`)*-1 FROM `mail_loot_template` WHERE `mincountOrRef` <0;
INSERT IGNORE INTO `RL_temp` SELECT DISTINCT(`mincountOrRef`)*-1 FROM `reference_loot_template` WHERE `mincountOrRef`<0;
DELETE FROM `reference_loot_template` WHERE `entry` NOT IN (SELECT `ref_id` FROM `RL_temp`);
DROP TABLE `RL_temp`;

    END //

        
CREATE
    PROCEDURE `sp_dev_cleanup_loot`()
    BEGIN
/*
 * Cleanup procedure for loot tables
 * Remember to have backup before running!
 * Example call:
 * USE `your_world_db_name`;
 * CALL sp_dev_cleanup_loot();
  */
-- DROP TABLE IF EXISTS `Loot_temp`;
CREATE TABLE `Loot_temp` (
    `lootid` INT(8) UNSIGNED NOT NULL PRIMARY KEY DEFAULT '0'
);
INSERT IGNORE INTO `Loot_temp` SELECT `entry` FROM `item_template`;
DELETE FROM `prospecting_loot_template` WHERE `entry` NOT IN (SELECT `lootid` FROM `Loot_temp`);
DELETE FROM `Loot_temp`;
INSERT IGNORE INTO `Loot_temp` SELECT `skinloot` FROM `creature_template` WHERE skinloot>0;
DELETE FROM `skinning_loot_template` WHERE `entry` NOT IN (SELECT `lootid` FROM `Loot_temp`);
DELETE FROM `Loot_temp`;
INSERT IGNORE INTO `Loot_temp` SELECT `lootid` FROM `creature_template` WHERE lootid>0;
DELETE FROM `creature_loot_template` WHERE `entry` NOT IN (SELECT `lootid` FROM `Loot_temp`);
DELETE FROM `Loot_temp`;
DROP TABLE `Loot_temp`;

DELETE FROM `disenchant_loot_template` WHERE `item` NOT IN (SELECT `entry` FROM `item_template`);
DELETE FROM `disenchant_loot_template` WHERE `entry` NOT IN (SELECT `disenchantid` FROM `item_template`);
DELETE FROM `pickpocketing_loot_template` WHERE `item` NOT IN (SELECT `entry` FROM `item_template`);
DELETE FROM `prospecting_loot_template` WHERE `entry` NOT IN (SELECT `entry` FROM `item_template`);
DELETE FROM `prospecting_loot_template` WHERE `item` NOT IN (SELECT `entry` FROM `item_template`);
DELETE FROM `mail_loot_template` WHERE `item` NOT IN (SELECT `entry` FROM `item_template`);
    END //
        
        
CREATE
    PROCEDURE `sp_dev_cleanup_world`()
    BEGIN
/* Procedure to clean world database
 *
 *Example call:
 * USE `your_world_db_name`;
 * CALL sp_dev_cleanup_world();
 *
 */
DELETE FROM `gameobject` WHERE `id` NOT IN (SELECT `entry` FROM `gameobject_template`);
DELETE FROM `creature` WHERE `id` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM areatrigger_involvedrelation WHERE `quest` NOT IN (SELECT `entry` FROM `quest_template`);
DELETE FROM `battlemaster_entry` WHERE `entry` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `battlemaster_entry` WHERE `bg_template` NOT IN (SELECT `id` FROM `battleground_template`);
UPDATE `creature` SET `equipment_id`=0 WHERE `equipment_id` NOT IN (SELECT `entry` FROM `creature_equip_template`) AND `equipment_id`!=0;
DELETE FROM `creature_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `creature_ai_scripts` WHERE `creature_id` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `creature_formations` WHERE leaderGUID NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `creature_formations` WHERE memberGUID NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `creature_involvedrelation` WHERE `id` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `creature_involvedrelation` WHERE `quest` NOT IN (SELECT `entry` FROM `quest_template`);
DELETE FROM `creature_linked_respawn` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `creature_linked_respawn` WHERE `linkedGuid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `creature_questrelation` WHERE `id` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `creature_questrelation` WHERE `quest` NOT IN (SELECT `entry` FROM `quest_template`);
DELETE FROM `creature_template_addon` WHERE `entry` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `game_event_creature_quest` WHERE `id` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `game_event_creature_quest` WHERE `quest` NOT IN (SELECT `entry` FROM `quest_template`);
DELETE FROM `game_event_creature_quest` WHERE `event` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_gameobject_quest` WHERE `id` NOT IN (SELECT `entry` FROM `gameobject_template`);
DELETE FROM `game_event_gameobject_quest` WHERE `quest` NOT IN (SELECT `entry` FROM `quest_template`);
DELETE FROM `game_event_gameobject_quest` WHERE `event` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_npc_gossip` WHERE `event_id` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_model_equip` WHERE `event` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_battleground_holiday` WHERE `event` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_condition` WHERE `event_id` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_creature` WHERE `event` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_gameobject` WHERE `event` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_npc_vendor` WHERE `item` NOT IN (SELECT `entry` FROM `item_template`);
DELETE FROM `game_event_npc_vendor` WHERE `event` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_npcflag` WHERE `event_id` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_pool` WHERE `event` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_prerequisite` WHERE `event_id` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_prerequisite` WHERE `prerequisite_event` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_quest_condition` WHERE `event_id` NOT IN (SELECT `entry` FROM `game_event`);
DELETE FROM `game_event_quest_condition` WHERE `quest` NOT IN (SELECT `entry` FROM `quest_template`);
DELETE FROM `gameobject_involvedrelation` WHERE `id` NOT IN (SELECT `entry` FROM `gameobject_template`);
DELETE FROM `gameobject_involvedrelation` WHERE `quest` NOT IN (SELECT `entry` FROM `quest_template`);
DELETE FROM `item_required_target` WHERE `targetEntry` NOT IN (SELECT `entry` FROM `creature_template`) AND `type` IN (1,2);
DELETE FROM `mail_level_reward` WHERE `senderEntry` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `npc_gossip` WHERE `npc_guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `npc_spellclick_spells` WHERE `quest_start` NOT IN (SELECT `entry` FROM `quest_template`) AND `quest_start`<>0;
DELETE FROM `npc_spellclick_spells` WHERE `quest_end` NOT IN (SELECT `entry` FROM `quest_template`) AND `quest_end`<>0;
DELETE FROM `npc_trainer` WHERE `entry` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `npc_vendor` WHERE `entry` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `npc_vendor` WHERE `item` NOT IN (SELECT `entry` FROM `item_template`);
DELETE FROM `pet_levelstats` WHERE `creature_entry` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `quest_end_scripts` WHERE `id` NOT IN (SELECT `CompleteScript` FROM `quest_template`);
DELETE FROM `quest_start_scripts` WHERE `id` NOT IN (SELECT `StartScript` FROM `quest_template`);
DELETE FROM `spell_script_target` WHERE `targetEntry` NOT IN (SELECT `entry` FROM `creature_template`) AND `type` IN (1,2,3) AND `targetEntry`!=0;
DELETE FROM `spell_script_target` WHERE `targetEntry` NOT IN (SELECT `entry` FROM `gameobject_template`) AND `type`=0 AND `targetEntry`!=0;
    END //
        

-- ------------------ --
--   ERROR HANDLERS   --
-- ------------------ --

-- sp_error_entry
CREATE PROCEDURE `sp_error_entry`(IN entry_type VARCHAR(10), IN e_entry INT(10))
BEGIN
/**
 * DEGREE: ERROR-HANDLING
 * TABLES AFFECTED: creature_template, gameobject_template
 * PROCS USED: none
 * 
 * Validate whether or not a entry for an npc/gameobject exists in its respective spawn table. Will error out if does not exist.
 *
 * e_entry - entry of the npc or gameobject you are validating
 * entry_type - 'NPC','GO','ITEM', and 'QUEST' are the only values accepted (for npc or gameobject)
 *
 * ex: CALL `sp_error_entry`('NPC',98753); -- make sure an npc spawn of entry 98753 exists in the db before performing actions using that entry
*/
        DECLARE check_entry INT;

        CASE UPPER(entry_type)
                WHEN 'NPC' THEN
                        SET check_entry = (SELECT COUNT(`entry`) FROM `creature_template` WHERE `entry`=e_entry);
                WHEN 'GO' THEN
                        SET check_entry = (SELECT COUNT(`entry`) FROM `gameobject_template` WHERE `entry`=e_entry);
                WHEN 'ITEM' THEN
                        SET check_entry = (SELECT COUNT(`entry`) FROM `item_template` WHERE `entry`=e_entry);
                WHEN 'QUEST' THEN
                        SET check_entry = (SELECT COUNT(`entry`) FROM `quest_template` WHERE `entry`=e_entry);
                ELSE
                        CALL INCORRECT_ENTRY_TYPE;
        END CASE;
        
        IF check_entry=0 THEN
                CALL INCORRECT_ENTRY;
        END IF;
END//   
        
CREATE
    PROCEDURE `sp_error_trigger`(IN trigger_entry INT)
    BEGIN
/**
 * DEGREE: ERROR HANDLER
 * TABLES AFFECTED: quest_template
 * PROCS USED: none
 *
 * Error handling for TDB procedure: check if triggerID for eAI is objective of any quest
 *
 * trigger_id - ID to check against the db for quest objective
 *
 * ex: CALL `sp_error_trigger` (257); -- make sure trigger (creature_template.entry = 257) is requirement for a quest
 */
    DECLARE Check_trigger INT;
    SET Check_trigger = (SELECT COUNT(ReqCreatureOrGOId1) FROM `quest_template` WHERE `ReqCreatureOrGOId1`= trigger_entry)
    + (SELECT COUNT(ReqCreatureOrGOId2) FROM `quest_template` WHERE `ReqCreatureOrGOId2`= trigger_entry)
    + (SELECT COUNT(ReqCreatureOrGOId3) FROM `quest_template` WHERE `ReqCreatureOrGOId3`= trigger_entry)
    + (SELECT COUNT(ReqCreatureOrGOId4) FROM `quest_template` WHERE `ReqCreatureOrGOId4`= trigger_entry);
    IF Check_trigger = 0 THEN
        CALL NO_QUEST_WITH_REQUIREMENT();
    END IF;
    END//
        
-- sp_error_guid
CREATE PROCEDURE `sp_error_guid`(IN guid_type VARCHAR(10),IN npc_or_go_guid INT(10))
BEGIN
/**
 * DEGREE: ERROR-HANDLING
 * TABLES AFFECTED: creature, gameobject
 * PROCS USED: none
 * 
 * Validate whether or not a guid for an npc/gameobject exists in its respective spawn table. Will error out if does not exist.
 *
 * npc_or_go_guid - Guid of the npc or gameobject spawn you are validating
 * guid_type - 'NPC' or 'GO' are the only values accepted (for npc or gameobject)
 *
 * ex: CALL `sp_error_guid`('NPC',98753); -- make sure an npc spawn of guid 98753 exists in the db before performing actions using that guid
*/
        DECLARE check_guid INT;

        CASE UPPER(guid_type)
                WHEN 'NPC' THEN
                        SET check_guid = (SELECT COUNT(`guid`) FROM `creature` WHERE `guid`=npc_or_go_guid);
                WHEN 'GO' THEN
                        SET check_guid = (SELECT COUNT(`guid`) FROM `gameobject` WHERE `entry`=npc_or_go_entry);
                ELSE
                        CALL INCORRECT_GUID_TYPE;
        END CASE;
        
        IF check_guid=0 THEN
                CALL INCORRECT_CREATURE_OR_GO_GUID;
        END IF;
END//

-- ------------------ --
--     UTILITIES      --
-- ------------------ --

-- sp_get_ref_id
CREATE PROCEDURE `sp_get_ref_id` (IN refType VARCHAR(10),OUT reference MEDIUMINT(5))
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: reference_loot_template
 * PROCS USED: none
 *
 * Get a generated loot reference id based on the type of loot its to be used for
 *
 * refType - [SKIN,ITEM,FISH,MILL,RAID_GOBJ,MINE,PROSPECT,WORLD,RAID_CRE,DUNGEON]
 * reference - OUT. Variable that is filled with the desired reference id.
 *
 * ex: CALL `sp_get_util_refid`('RAID_CRE',@Test);
 *     SELECT @Test
 */
    CASE UCASE(refType)
        WHEN 'SKIN' THEN BEGIN
            SET @Low :=00000;
            SET @High :=1000;
        END;
        WHEN 'ITEM' THEN BEGIN
            SET @Low :=10000;
            SET @High :=10999;
        END;
        WHEN 'FISH' THEN BEGIN
            SET @Low :=11000;
            SET @High :=11799;
        END;
        WHEN 'MILL' THEN BEGIN
            SET @Low :=11800;
            SET @High :=11999;
        END;
        WHEN 'RAID_GOBJ' THEN BEGIN
            SET @Low :=12000;
            SET @High :=12899;
        END;
        WHEN 'MINE' THEN BEGIN
            SET @Low :=12900;
            SET @High :=12999;
        END;
        WHEN 'PROSPECT' THEN BEGIN
            SET @Low :=13000;
            SET @High :=13999;
        END;
        WHEN 'WORLD' THEN BEGIN
            SET @Low :=14000;
            SET @High :=29000;
        END;
        WHEN 'RAID_CRE' THEN BEGIN
            SET @Low :=34000;
            SET @High :=34999;
        END;
        WHEN 'DUNGEON' THEN BEGIN
            SET @Low :=35000;
            SET @High :=35999;
        END;
        ELSE CALL INVALID_REFERENCE_TYPE;
    END CASE;
    SET reference :=1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN @Low AND @High ORDER BY `entry` DESC LIMIT 1);
END//

-- ------------------ --
-- BASIC PROCEDURES   --
-- ------------------ --


-- sp_set_npc_path
CREATE PROCEDURE `sp_set_npc_path`(IN npc_guid INT(10),OUT path INT(10))
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature, creature_addon
 * PROCS USED: sp_error_guid
 *
 * Set appropriate flags to enable a spawned creature to move along waypoints
 *
 * guid - Guid of the creature spawn you wish
 * path - OUT. Variable whose value represents the path_id assigned to the supplied guid
 * 
 * ex: CALL `sp_set_npc_path`(98753,@PATH); -- makes spawn 98753 (creature.guid=98753) able to move along waypoints
 *     SELECT @PATH; -- use the path_id in later queries
 */
        CALL `sp_error_guid`('NPC',npc_guid);
        
        SELECT npc_guid*10 INTO path;

        UPDATE `creature` SET `MovementType`=2,`spawndist`=0 WHERE `guid`=npc_guid;

        IF (SELECT COUNT(*) FROM `creature_addon` WHERE `guid`=npc_guid) > 0 THEN
                UPDATE `creature_addon` SET `path_id`=path WHERE `guid`=npc_guid;
        ELSE
                INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (npc_guid,path);
        END IF;
        
        DELETE FROM `waypoint_data` WHERE `id`=path;
END//

CREATE PROCEDURE `sp_set_quest_level`(IN quest_entry INT(10), IN quest_level INT(10))
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: quest_template
 * PROCS USED: sp_error_entry
 *
 * Update quest to provided level
 * ONLY FOR SEASONAL QUESTS WHERE LEVELS ARE NOT CORRECT FROM WDB!
 *
 * quest_entry - ID of a quest from quest_template
 * quest_level - new MinLevel value
 * 
 * ex: CALL `quest_Level` (11335,30) - sets MinLevel of quest ID 11335 (Call to Arms: Arathi Basin) to 30
 */
CALL `sp_error_entry`('QUEST',quest_entry);
UPDATE `quest_template` SET `MinLevel`= quest_level WHERE `entry`= quest_entry;
END //


CREATE PROCEDURE `sp_set_quest_next`(IN quest_entry INT(10), IN next_quest INT(10))
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: quest_template
 * PROCS USED: sp_error_entry
 *
 * Update next quest value
 *
 * quest_entry - ID of a quest from quest_template
 * next_quest - new NextQuestId
 * 
 * ex: CALL `quest_Level` (11335,11230) - sets NextQuestId after quest ID 11335 (Call to Arms: Arathi Basin) to 11230
 */
CALL `sp_error_entry`('QUEST',quest_entry);
UPDATE `quest_template` SET `NextQuestId`= next_quest WHERE `entry`= quest_entry;
END //


CREATE PROCEDURE `sp_set_quest_previous`(IN quest_entry INT(10), IN prev_quest INT(10))
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: quest_template
 * PROCS USED: sp_error_entry
 *
 * Update prev quest value
 *
 * quest_entry - ID of a quest from quest_template
 * next_quest - new PrevQuestId
 * 
 * ex: CALL `quest_Level` (11335,11230) - sets PrevQuestId for quest ID 11335 (Call to Arms: Arathi Basin) to 11230
 */
CALL `sp_error_entry`('QUEST',quest_entry);
UPDATE `quest_template` SET `PrevQuestId`= prev_quest WHERE `entry`= quest_entry;
END //


-- sp_set_entry_list
CREATE PROCEDURE `sp_set_entry_list` (IN input LONGTEXT,IN appendExisting BIT) 
BEGIN
/**
 * DEGREE: UTILITY
 * TABLES AFFECTED: tdb_entry_list (temp)
 * PROCS USED: none
 *
 * Utility procedure to split a comma-delimited list into a temporary table to be used outside of the procedure.
 * ***USE WITH CARE! Drop up the temporary table after using it!***
 *
 * input - comma-delimited list of entries to be split and inserted individually into a temporary table
 * appendExisting - NULLABLE. If present and true, does not drop existing temp table, rather, appends the existing table
 *
 * ex: CALL sp_set_entry_list ('1,2,3,4,5,6',null);
 *     SELECT * FROM `tdb_entry_list`;
 *     DROP TABLE `tdb_entry_list`;
 */
    DECLARE cur_position INT DEFAULT 1;
    DECLARE remainder TEXT;
    DECLARE cur_string VARCHAR(10);
    DECLARE entry_count MEDIUMINT;

    IF appendExisting IS NULL OR appendExisting IS FALSE THEN
        CREATE TABLE `tdb_entry_list` (`value` INT NOT NULL PRIMARY KEY) ENGINE=MYISAM;
    END IF;

    SET remainder = input;
    WHILE CHAR_LENGTH(remainder) > 0 AND cur_position > 0 DO
        SET cur_position = INSTR(remainder, ',');
        IF cur_position = 0 THEN
            SET cur_string = remainder;
        ELSE
            SET cur_string = LEFT(remainder, cur_position-1);
        END IF;

        IF TRIM(cur_string) != '' AND(SELECT COUNT(*) FROM `tdb_entry_list` WHERE `value`=cur_string)=0 THEN
            INSERT INTO `tdb_entry_list` VALUES (cur_string);
        END IF;

        SET remainder = SUBSTRING(remainder, cur_position+1);
    END WHILE;
END//

-- sp_set_npc_aggro
CREATE PROCEDURE `sp_set_npc_aggro`(IN creature_entry INT(10),IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED: sp_CheckNpcEntry
 *
 * Update creature to ignore aggro
 *
 * creature_entry - ID of NPC from `creature_template`.`entry`
 * on_off - whether to turn aggro on or off
 * 
 * ex: CALL `sp_set_npc_aggro`(257,false); -- makes NPC with ID 257 ignore aggro
 */
        CALL `sp_error_entry`('NPC',creature_entry);
        IF on_off = 1 THEN
                UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~2 WHERE `entry`= creature_entry;
        ELSE 
                UPDATE `creature_template` SET `flags_extra`=`flags_extra`|2 WHERE `entry`= creature_entry;
        END IF;
END //

-- sp_set_npc_aggro_bylist
CREATE PROCEDURE `sp_set_npc_aggro_bylist`(IN entry_list LONGTEXT,IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED: sp_CheckNpcEntry
 *
 * Update creature to ignore aggro
 *
 * entry_list - Comma-delimited list of NPC IDs from `creature_template`.`entry`
 * on_off - whether to turn aggro on or off
 * 
 * ex: CALL `sp_set_npc_aggro`(257,false); -- makes NPC with ID 257 ignore aggro
 */
        CALL `sp_set_entry_list` (entry_list,null);

        IF on_off = 1 THEN
                UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~2 WHERE `entry` IN (SELECT * FROM `tdb_entry_list`);
        ELSE 
                UPDATE `creature_template` SET `flags_extra`=`flags_extra`|2 WHERE `entry` IN (SELECT * FROM `tdb_entry_list`);
        END IF;

        DROP TABLE `tdb_entry_list`; -- dont forget the cleanup!
END //

-- sp_set_npc_faction
CREATE PROCEDURE `sp_set_npc_faction`(IN npc_entry INT(10), factionA INT(10), factionH INT(10))
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED: sp_CheckNpcEntry
 *
 * Update creature's faction
 *
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * factionA - NULLABLE. Alliance faction to assign to the specified npc (if null, uses current value).
 * factionH - NULLABLE. Horde faction to assign to the specified npc (if null, uses current value).
 * 
 * ex: CALL `sp_set_npc_faction`(257,7,7); -- sets faction to 7 for NPC with ID 257 (Kobold Worker)
 */
        CALL `sp_error_entry`('NPC',npc_entry);
        UPDATE `creature_template` SET `faction_A`=IFNULL(factionA,`faction_A`),`faction_H`=IFNULL(factionH,`faction_A`) WHERE `entry`=npc_entry;
END //

-- sp_set_npc_faction_bylist
CREATE PROCEDURE `sp_set_npc_faction_bylist`(IN entry_list LONGTEXT, factionA INT(10), factionH INT(10))
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED: sp_CheckNpcEntry
 *
 * Update creature's faction
 *
 * entry_list - Comma-delimited list of NPC IDs from `creature_template`.`entry`
 * factionA - NULLABLE. Alliance faction to assign to the specified npc (if null, uses current value).
 * factionH - NULLABLE. Horde faction to assign to the specified npc (if null, uses current value).
 * 
 * ex: CALL `sp_set_npc_faction`(257,7,7); -- sets faction to 7 for NPC with ID 257 (Kobold Worker)
 */
        CALL `sp_set_entry_list` (entry_list,null);

        UPDATE `creature_template` SET `faction_A`=IFNULL(factionA,`faction_A`),`faction_H`=IFNULL(factionH,`faction_A`) WHERE `entry` IN (SELECT * FROM `tdb_entry_list`);

        DROP TABLE `tdb_entry_list`; -- dont forget the cleanup!
END //

-- sp_set_npc_selectable
CREATE PROCEDURE `sp_set_npc_selectable`(IN npc_entry INT(10),IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED: sp_CheckNpcEntry
 *
 * Update creature to make it selectable
 *
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * on_off - whether or not the specified NPC should be selectable
 * 
 * ex: CALL `sp_set_npc_selectable`(257,true) - makes creature with ID 257 (Kobold Worker) selectable 
 */
        CALL `sp_error_entry`('NPC',npc_entry);
        IF on_off=1 THEN
                UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~33554432 WHERE `entry`=npc_entry;
        ELSE
                UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE `entry`=npc_entry;
        END IF;
END //

-- sp_set_npc_selectable_bylist
CREATE PROCEDURE `sp_set_npc_selectable_bylist`(IN entry_list LONGTEXT,IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED: sp_CheckNpcEntry
 *
 * Update creature to make it selectable
 *
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * on_off - whether or not the specified NPC should be selectable
 * 
 * ex: CALL `sp_set_npc_selectable_bylist`('257,3,6',true) - makes creature with IDs of 257,3, and 6 to be selectable 
 */
        CALL `sp_set_entry_list` (entry_list,null);

        IF on_off=1 THEN
                UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~33554432 WHERE `entry` IN (SELECT * FROM `tdb_entry_list`);
        ELSE
                UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE `entry` IN (SELECT * FROM `tdb_entry_list`);
        END IF;

        DROP TABLE `tdb_entry_list`; -- dont forget the cleanup!
END //

-- sp_set_npc_deadquest
CREATE PROCEDURE `sp_set_npc_deadquest`(IN npc_entry INT(10))
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template_addon, creature
 * PROCS USED: sp_error_entry
 *
 * Update creature to appear death but still react to eAI / give or take quests
 *
 * creature_entry - ID of NPC from `creature_template`.`entry`
 * 
 * ex: CALL `sp_set_npc_deadquest` (257); -- Makes creature with entry 257 appear dead but still albe to give / take quests or react to spellhits
 */
        DECLARE check_addon_exists INT;
        CALL `sp_error_entry`('NPC',npc_entry);

        UPDATE `creature` SET `MovementType`=0,`spawndist`=0,`Deathstate`=0 WHERE `id`=npc_entry;
        UPDATE `creature_template` SET `flags_extra`=`flags_extra`|2 WHERE `entry`=npc_entry;
    
        -- if has creature_template_addon entry, update, else insert new row    
        SET check_addon_exists = (SELECT COUNT(`entry`) FROM `creature_template_addon` WHERE `entry`=npc_entry);
        IF check_addon_exists > 0 THEN 
                UPDATE `creature_template_addon` SET `bytes1`=7 WHERE `entry`=npc_entry;
        ELSE 
                INSERT INTO `creature_template_addon` VALUES (npc_entry,0,0,7,0,0, '');
        END IF;
END //

-- sp_set_npc_trigger
CREATE PROCEDURE `sp_set_npc_trigger` (IN npc_entry INT(10),IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature, creature_template
 * PROCS USED: sp_error_entry
 *
 * Sets NPC as a trigger (disable movements, ignore aggro, and disable targetting)
 *
 * npc_entry - Entry of the npc for whom template is updated
 * on_off - If true, sets all spawns to respond accordingly and updates the template, if false, removes flags
 *
 * ex: CALL `sp_tdb_TriggerSettings` (257,true); -- sets creature having `creature_template`.`entry` = 257 to act as trigger
 */
        CALL `sp_error_entry`('NPC',npc_entry);

        IF on_off=1 THEN
                UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `id`=npc_entry;
                UPDATE `creature_template` SET `flags_extra`=`flags_extra`|2,`unit_flags`=`unit_flags`|33554432  WHERE `entry`=npc_entry;        
        ELSE
                UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~2,`unit_flags`=`unit_flags`&~33554432  WHERE `entry`=npc_entry; 
        END IF;
END //

-- sp_set_npc_trigger_bylist
CREATE PROCEDURE `sp_set_npc_trigger_bylist` (IN entry_list LONGTEXT,IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature, creature_template
 * PROCS USED: sp_error_entry
 *
 * Sets NPC as a trigger (disable movements, ignore aggro, and disable targetting)
 *
 * npc_entry - Entry of the npc for whom template is updated
 * on_off - If true, sets all spawns to respond accordingly and updates the template, if false, removes flags
 *
 * ex: CALL `sp_tdb_TriggerSettings` (257,true); -- sets creature having `creature_template`.`entry` = 257 to act as trigger
 */
        CALL `sp_set_entry_list` (entry_list,null);

        IF on_off=1 THEN
                UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `id` IN (SELECT * FROM `tdb_entry_list`);
                UPDATE `creature_template` SET `flags_extra`=`flags_extra`|2,`unit_flags`=`unit_flags`|33554432  WHERE `entry` IN (SELECT * FROM `tdb_entry_list`);        
        ELSE
                UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~2,`unit_flags`=`unit_flags`&~33554432  WHERE `entry` IN (SELECT * FROM `tdb_entry_list`); 
        END IF;

        DROP TABLE `tdb_entry_list`; -- dont forget the cleanup!
END //

-- sp_set_npc_lootid
CREATE PROCEDURE `sp_set_npc_lootid` (IN npcEntry MEDIUMINT(5),IN lootID MEDIUMINT(5))
BEGIN    
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED: sp_error_entry
 *
 * Sets the loot id of a specified NPC
 *
 * npcEntry - Entry of the npc whose lootid you would like to set
 * loot - OPTIONAL. If provided, set the specified NPC's lootid to this value. If NULL, NPC uses its own entry.
 * 
 * ex: CALL `sp_set_npc_lootid` (99999,NULL); -- sets the lootid to its own entry number
 */
    CALL `sp_error_entry`('NPC',npcEntry);
    UPDATE `creature_template` SET `lootid`=IFNULL(lootID,npcEntry) WHERE `entry`=npcEntry;
END//

-- `sp_set_npc_lootid_bylist`
CREATE PROCEDURE `sp_set_npc_lootid_bylist` (IN entryList LONGTEXT,IN lootID MEDIUMINT(5))
BEGIN    
/**
 * DEGREE: AVERAGE
 * TABLES AFFECTED: creature_template, tdb_entry_list (temp)
 * PROCS USED: sp_set_entry_list
 *
 * Sets the loot id of a specified NPC
 *
 * npcEntry - Entry of the npc whose lootid you would like to set
 * loot - NULLABLE. If provided, set the specified NPC's lootid to this value. If NULL, NPC uses its own entry.
 * 
 * ex: CALL `sp_get_npc_lootid_bylist`('1,2,3,4,5','99999'); -- sets the loot id of 5 specified npcs to 99999
 */
    CALL `sp_set_entry_list` (entryList,null);
    UPDATE `creature_template` SET `lootid`=IFNULL(lootID,`entry`) WHERE `entry` IN (SELECT DISTINCT * FROM `tdb_entry_list`);
    
    DROP TABLE `tdb_entry_list`; -- dont forget the cleanup!
END//

-- sp_set_npc_lootid_bytable
CREATE PROCEDURE `sp_set_npc_lootid_bytable` (IN lootID MEDIUMINT(5))
BEGIN    
/**
 * DEGREE: AVERAGE
 * TABLES AFFECTED: creature_template, tdb_entry_list
 * PROCS USED: sp_set_entry_list
 *
 * Sets the loot id of specified NPCs based on entries in tdb_entry_list
 *
 * loot - NULLABLE. If provided, set the specified NPC's lootid to this value. If NULL, NPC uses its own entry.
 * 
 * ex: CALL `sp_get_npc_lootid_bytable`('99999'); -- sets the loot id of all npcs in tdb_entry_list to 99999
 */
    UPDATE `creature_template` SET `lootid`=IFNULL(lootID,`entry`) WHERE `entry` IN (SELECT DISTINCT * FROM `tdb_entry_list`);
END//

-- sp_get_npc_diffentry
CREATE PROCEDURE `sp_get_npc_diffentry` (IN normalEntry MEDIUMINT(5),IN difficulty TINYINT(1),OUT output MEDIUMINT(8))
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED: sp_error_entry
 *
 * Retrieves the specified difficulty entry for a given NPC
 *
 * normalEntry - ID of the npc whose difficulty entry is to be 
 * difficulty - level of difficulty who entry should be retrieved
 * output - OUT. desired difficulty entry is placed in this variable for use by the caller
 *
 * ex: CALL `sp_get_npc_diffentry`(10184,1,@Test);
 *     SELECT @Test;
 */
    CALL `sp_error_entry`('NPC',normalEntry);

    CASE difficulty
        WHEN 1 THEN BEGIN 
            SELECT `difficulty_entry_1` FROM `creature_template` WHERE `entry`=normalEntry INTO output; 
        END;
        WHEN 2 THEN BEGIN 
            SELECT `difficulty_entry_2` FROM `creature_template` WHERE `entry`=normalEntry INTO output; 
        END;
        WHEN 3 THEN BEGIN 
            SELECT `difficulty_entry_3` FROM `creature_template` WHERE `entry`=normalEntry INTO output; 
        END;
        ELSE CALL INVALID_DIFFICULTY();
    END CASE;
END//

-- sp_set_spell_target
CREATE PROCEDURE `sp_set_spell_target`(IN target_type VARCHAR(10),IN target_entry INT(11),IN spell_id INT(11))
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template, spell_script_target
 * PROCS USED: sp_error_entry
 *
 * Sets target requirement for spellcast
 *
 * target_type - [GO|NPC|DEAD_NPC|MINION]
 * target_entry - ID of creature or gameobject (if zero, spell focus object if type='GO', target player for AOE if type='NPC')
 * spell_id - ID of spell we want to set target for
 * 
 * ex: CALL `sp_set_spell_target` ('NPC',257,4444); -- allows spell 4444 to be cast only on living creature with `creature_template`.`entry` = 257
 */
    CASE UCASE(target_type)
        WHEN 'GO' THEN BEGIN
            IF target_entry > 0 THEN 
                CALL `sp_error_entry`('GO',target_entry); 
            END IF;
            DELETE FROM `spell_script_target` WHERE `entry`=spell_id;
            INSERT INTO `spell_script_target`(`entry`,`type`,`targetEntry`) VALUES (spell_id,0,target_entry);
        END;
        WHEN 'NPC' THEN BEGIN
            IF target_entry > 0 THEN 
                CALL `sp_error_entry`('NPC',target_entry); 
            END IF;
            DELETE FROM `spell_script_target` WHERE `entry`=spell_id;
            INSERT INTO `spell_script_target`(`entry`,`type`,`targetEntry`) VALUES (spell_id,1,target_entry);
        END;
        WHEN 'DEAD_NPC' THEN BEGIN
            CALL `sp_error_entry`('NPC',target_entry);
            DELETE FROM `spell_script_target` WHERE `entry`=spell_id;
            INSERT INTO `spell_script_target`(`entry`,`type`,`targetEntry`) VALUES (spell_id,2,target_entry);
        END;
        WHEN 'MINION' THEN BEGIN
            CALL `sp_error_entry`('NPC',target_entry);
            DELETE FROM `spell_script_target` WHERE `entry`=spell_id;
            INSERT INTO `spell_script_target`(`entry`,`type`,`targetEntry`) VALUES (spell_id,3,target_entry);
        END;
        ELSE CALL INCORRECT_TARGET_TYPE;
    END CASE;
END //

-- sp_get_go_lootid
CREATE PROCEDURE `sp_get_go_lootid`(IN gobjID MEDIUMINT(6),OUT gobjLootID INT(10))
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: gameobject_template
 * PROCS USED: sp_error_entry
 *
 * Get the loot ID for a specified gameobject (data1 field). Must be a chest (type=3).
 *
 * gobjID - ID of the gameobject whose loot id is to be gathered
 * gobjLootID - variable to store the retrieved value in
 *
 * ex: CALL `sp_get_go_lootid`(195709,@Test);
 *     SELECT * FROM `gameobject_loot_template` WHERE `entry`=@Test;
 */
    CALL `sp_error_entry`('NPC',gobjID);
    SELECT `data1` FROM `gameobject_template` WHERE `entry`=gobjID AND `type`=3 INTO gobjLootID;
END//

CREATE PROCEDURE `sp_set_npc_lootable_bylist`(IN npc_entry TEXT, IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED:  sp_error_entry
 *
 * Disable /enable loot option on NPC from list
 *
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * 
 * ex: CALL `sp_set_npc_lootable` ("257,258,259",1); -- makes creature of ID 257,258,259 (Kobold Worker) lootable
 * ex: CALL `sp_set_npc_lootable` ("257,258,259",0); -- makes creature of ID 257,258,259 (Kobold Worker) lootable
 */  
DECLARE remaining INT;
DECLARE min_entry INT;

CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);
-- error check part
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
CALL sp_error_entry('NPC',min_entry);
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);

CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);

WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
CALL sp_error_entry('NPC',min_entry);
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;

CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);

IF on_off = 1 THEN
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`&~1 WHERE `entry`= min_entry;
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
END IF;
IF on_off = 0 THEN
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`|1 WHERE `entry`= min_entry;
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
END IF;

END //


CREATE PROCEDURE `sp_set_npc_lootable`(IN npc_entry INT(10), IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED:  sp_error_entry
 *
 * Disable /enable loot option on NPC
 *
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * 
 * ex: CALL `sp_set_npc_lootable` (257,1); -- makes creature of ID 257 (Kobold Worker) lootable
 * ex: CALL `sp_set_npc_lootable` (257,0); -- makes creature of ID 257 (Kobold Worker) not lootable
 */

CALL sp_error_entry('NPC',npc_entry);
IF on_off = 1 THEN
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`&~1 WHERE `entry`= npc_entry;
ELSEIF on_off = 0 THEN
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`|1 WHERE `entry`= npc_entry;
END IF;
END //


CREATE PROCEDURE `sp_set_npc_civilian_bylist`(IN npc_entry TEXT, IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED: sp_error_entry
 *
 * Update creature to ignore aggro
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * 
 * ex: CALL `sp_set_npc_civilian_bylist` ("257,258,259",1); -- makes NPC with ID 257,258,259 ignore aggro
 * ex: CALL `sp_set_npc_civilian_bylist` ("257,258,259",1); -- makes NPC with ID 257,258,259 not ignore aggro
 */
  
DECLARE remaining INT;
DECLARE min_entry INT;

CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);
-- error check part
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
CALL sp_error_entry('NPC',min_entry);
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);

CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);

WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
CALL sp_error_entry('NPC',min_entry);
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;

CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);

IF on_off = 1 THEN
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|2 WHERE `entry`= min_entry;
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
END IF;
IF on_off = 0 THEN
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~2 WHERE `entry`= min_entry;
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
END IF;

END //


CREATE PROCEDURE `sp_set_npc_civilian`(IN npc_entry INT(10), IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED: sp_error_entry
 *
 * Update creature to ignore aggro
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * 
 * ex: CALL `sp_set_npc_civilian` (257,1); -- makes NPC with ID 257 ignore aggro
 * ex: CALL `sp_set_npc_civilian` (257,0); -- makes NPC with ID 257 not ignore aggro
 */
CALL sp_error_entry('NPC',npc_entry);
IF on_off = 1 THEN
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|2 WHERE `entry`= npc_entry;
ELSEIF on_off = 0 THEN
UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~2 WHERE `entry`= npc_entry;
END IF;
END //


CREATE PROCEDURE `sp_set_npc_attackable`(IN npc_entry INT, IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED: sp_error_entry
 *
 * Toggle on / off attack option for NPC
 *
 * creature_entry - ID of NPC from `creature_template`.`entry`
 * 
 * ex: CALL `sp_set_npc_attackable` (257,1); -- enables attacking of creature with ID 257 (creature_template.entry - Kobold Worker)
 */
CALL sp_error_entry('NPC',npc_entry);
IF on_off = 1 THEN
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|256 WHERE `entry`= npc_entry;
END IF;
IF on_off = 0 THEN
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256 WHERE `entry`= npc_entry;
END IF;
END //


CREATE PROCEDURE `sp_set_npc_attackable_bylist`(IN npc_entry TEXT, IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED: sp_error_entry
 *
 * Toggle on / off attack option for listed NPCs
 *
 * creature_entry - ID of NPC from `creature_template`.`entry`
 * 
 * ex: CALL `sp_set_npc_attackable` ("257,258,259",1); -- enables attacking of creature with ID 257, 258, 259 (creature_template.entry - Kobold Worker)
 * ex: CALL `sp_set_npc_attackable` ("257,258,259",0); -- disables attacking of creature with ID 257, 258, 259 (creature_template.entry - Kobold Worker)
 */
DECLARE remaining INT;
DECLARE min_entry INT;
CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);
-- error check part
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
CALL sp_error_entry('NPC',min_entry);
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);
IF on_off = 1 THEN
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|256 WHERE `entry`= min_entry;
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
END IF;
IF on_off = 0 THEN
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256 WHERE `entry`= min_entry;
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
END IF;
END //


CREATE PROCEDURE `sp_set_npc_targetable`(IN npc_entry INT(10), IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED:  none
 * FUNCTIONS USED: sp_error_entry
 *
 * Disable /enable targetting option on NPC
 *
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * 
 * ex: CALL `sp_set_npc_targetable` (257,1); -- makes creature of ID 257 (Kobold Worker) targetable
 * ex: CALL `sp_set_npc_targetable` (257,0); -- makes creature of ID 257 (Kobold Worker) not targetable
 */

CALL sp_error_entry('NPC',npc_entry);
IF on_off = 1 THEN
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~33554432 WHERE `entry`= npc_entry;
ELSEIF on_off = 0 THEN
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE `entry`= npc_entry;
END IF;
END //


CREATE PROCEDURE `sp_set_npc_targetable_bylist`(IN npc_entry TEXT, IN on_off BOOLEAN)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: creature_template
 * PROCS USED:  sp_error_entry
 *
 * Disable /enable targetting option on NPC from list
 *
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * 
 * ex: CALL `sp_set_npc_targetable_bylist` ("257,258,259",1); -- makes creature of ID 257,258,259 (Kobold Worker) targetable
 * ex: CALL `sp_set_npc_targetable_bylist` ("257,258,259",0); -- makes creature of ID 257,258,259 (Kobold Worker) not targetable
 */  
DECLARE remaining INT;
DECLARE min_entry INT;

CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);
-- error check part
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
CALL sp_error_entry('NPC',min_entry);
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);

CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);

IF on_off = 1 THEN
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~33554432 WHERE `entry`= min_entry;
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
END IF;
IF on_off = 0 THEN
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE `entry`=  min_entry;
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
END IF;
END //



CREATE PROCEDURE `sp_set_item_money` (IN item_entry INT, IN min_money INT, IN max_money INT)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: item_template
 * PROCS USED:  sp_error_entry
 *
 * set min / max money loot for item
 * 
 * ex: CALL `sp_set_item_money` (25,10,100); -- set max money loot to 100 and min money loot to 10 for item with entry = 25
 *
 */
CALL sp_error_entry('ITEM',item_entry);
UPDATE item_template SET minMoneyLoot=min_money, maxMoneyLoot=max_money WHERE entry = item_entry;
END //



CREATE PROCEDURE `sp_set_item_money_bylist`(IN item_entry TEXT, IN min_money INT, IN max_money INT)
BEGIN
/**
 * DEGREE: BASIC
 * TABLES AFFECTED: item_template
 * PROCS USED:  sp_error_entry
 *
 * set min / max money loot for item in list
 * 
 * ex: CALL `sp_set_item_money` ("25,26,27",10,100); -- set max money loot to 100 and min money loot to 10 for item with entry = 25 and 26 and 27
 *
 */

DECLARE remaining INT;
DECLARE min_entry INT;

CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);
-- error check part
WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
CALL sp_error_entry('ITEM',min_entry);
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;
CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);

CALL sp_set_entry_list(npc_entry);
SET remaining = (SELECT COUNT(`value`) FROM tdb_entry_list);

WHILE remaining > 0 DO
SET min_entry = (SELECT MIN(`value`) FROM tdb_entry_list);
UPDATE item_template SET minMoneyLoot=min_money, maxMoneyLoot=max_money WHERE entry = item_entry;
DELETE FROM tdb_entry_list WHERE `value`=min_entry;
SET remaining = remaining -1;
END WHILE;

END //



-- -------------------- --
--  AVERAGE PROCEDURES  --
-- -------------------- --

CREATE PROCEDURE `sp_eai_kill_ondeath`(IN npc_entry INT(10), trigger_id INT(10))
BEGIN
/**
 * DEGREE: AVERAGE
 * TABLES AFFECT: creature_template, creature_ai_scripts
 * PROCS USED: sp_error_entry, sp_eai_select_id
 *
 * Create eAI script for NPC to give credit on death
 *
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * trigger_id - ID of trigger NPC that needs to be killed for quest objective
 * 
 * ex: CALL `sp_eai_kill_ondeath`(46,257); -- NPC of ID 46 (Murloc Forager) when killed will give credit for killing NPC with ID 257 (Kobold Worker)
 */
    CALL `sp_error_entry`('NPC',npc_entry);
    UPDATE `creature_template` SET `AIName`= 'EventAI' WHERE `entry`=npc_entry; -- enable eAI

    -- EAI reacting on spellhit, gives credit for kill and despawns
    CALL `sp_eai_select_id`(npc_entry, @event_id);
    INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES 
        (@event_id,npc_entry,6,0,100,0,0,0,0,0,33,trigger_id,6,0,23,1,0,0,0,0,0,0, 'Stored procedures eAI: quest - kill trigger on NPC death');
END //

CREATE PROCEDURE `sp_eai_cast_onspawn` (IN npc_entry INT(10), spell_id MEDIUMINT(6))
BEGIN
/**
 * DEGREE: AVERAGE
 * TABLES AFFECT: creature_template, creature_ai_scripts
 * PROCS USED: sp_error_entry, sp_eai_select_id
 *
 * Create eAI script for NPC to cast spell on self upon spawn
 *
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * spell_ID - ID of spell we want to set target for
 * 
 * ex: CALL `sp_eai_cast_onspawn`(257,4444); -- Creature of ID 257 (Kobold Worker) will cast spell of ID 4444 on self when spawned
 */
    CALL `sp_error_entry`('NPC',npc_entry);

    UPDATE `creature_template` SET `AIName`= 'EventAI' WHERE `entry`=npc_entry; -- enable eAI
    
    CALL `sp_eai_select_id`(npc_entry,@event_id);
    
    INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES 
        (@event_id,npc_entry,11,0,100,0,0,0,0,0,11,spell_id,0,0,0,0,0,0,0,0,0,0, 'Stored procedures eAI: NPC cast spell on self');
END //

CREATE PROCEDURE `sp_eai_spawn_spellhit` (IN npc_entry INT(10),IN spell_id MEDIUMINT(6),IN spawn_id INT(10),IN despawn_time INT(10))
BEGIN
/**
 * DEGREE: AVERAGE
 * TABLES AFFECT: creature_template, creature_ai_scripts
 * PROCS USED: sp_error_entry, sp_eai_select_id
 *
 * Create eAI script for NPC to summon another NPC upon spellhit
 *
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * spawn_id - creature that will be spawned at current location of NPC
 * spell_ID - ID of spell which will run the event
 * despawn_time - time after which summoned mob despawns in miliseconds
 * 
 * ex: CALL `sp_eai_spawn_spellhit` (1234,4444,1235,100000); -- summon c1235 when c1234 is hit with s4444 (c1235 depsawns after 10s)
 */
    CALL `sp_error_entry`('NPC',npc_entry);
    CALL `sp_error_entry`('NPC',spawn_id);

    UPDATE `creature_template` SET `AIName`= 'EventAI' WHERE `entry`=npc_entry; -- enable eAI
    CALL `sp_eai_select_id`(npc_entry,@event_id); -- select event ID

    INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES 
        (@event_id,npc_entry,8,0,100,1,spell_id,-1,0,0,32,spawn_id,6,0,41,0,0,0,0,0,0,0, 'Stored procedures eAI: quest - summon mob on spellcast');
    INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES 
        (@event_id+1,spawn_id,1,1,100,0,despawn_time,despawn_time,despawn_time,despawn_time,41,0,0,0,0,0,0,0,0,0,0,0, 'Stored procedures eAI: despawn after defined time');
END //


CREATE PROCEDURE `sp_eai_quest_credit_on_spellhit` (IN npc_entry INT(10), spell_id MEDIUMINT(6), trigger_id INT(10), despawn_time INT(10))
BEGIN
/**
 * DEGREE: AVERAGE
 * TABLES AFFECT: creature_template, creature_ai_scripts
 * PROCS USED: sp_error_entry, sp_error_trigger, sp_eai_select_id
 *
 * Create eAI script for NPC to give credit on spellhit
 *
 * spell_id - ID of spell we want to set target for
 * npc_entry - ID of NPC from `creature_template`.`entry`
 * trigger_id - ID of trigger NPC that needs to be killed for quest objective
 * despawn_time - time before NPC despawns in miliseconds
 * 
 * ex: CALL `sp_eai_quest_credit_on_spellhit` (257,4444,1235,10000); -- Creature of ID 257 when hit with spell of ID 4444 will give credit for killing NPC of ID 1235 and will then despawn after 10 seconds
 */
    CALL `sp_error_entry`('NPC',npc_entry);
    CALL `sp_error_trigger` (trigger_id);
    UPDATE `creature_template` SET `AIName`= 'EventAI' WHERE `entry`=npc_entry; -- enable eAI
    -- EAI reacting on spellhit, gives credit for kill and despawns
        CALL `sp_eai_select_id` (npc_entry, @event_id);
    INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES 
        (@event_id,npc_entry,8,0,100,1,spell_ID,-1,0,0,33,trigger_ID,6,0,23,1,0,0,0,0,0,0, 'Stored procedures eAI: quest - kill trigger on spellcast');
    INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES 
        (@event_id+1,npc_entry,1,1,100,0,despawn_time,despawn_time,despawn_time,despawn_time,41,0,0,0,0,0,0,0,0,0,0,0, 'Stored procedures eAI: despawn after defined time');
END //
DELIMITER ;

-- == =================== ==
-- ==   UPDATEPACK 34     ==
-- == =================== ==

-- Fix a procedure
DROP PROCEDURE IF EXISTS `sp_get_go_lootid`;

-- Temporarily change the delimiter
DELIMITER ||
CREATE PROCEDURE `sp_get_go_lootid`(IN gobjID MEDIUMINT(6),OUT gobjLootID INT(10))
BEGIN
        CALL `sp_error_entry`('GO',gobjID);
        SELECT `data1` FROM `gameobject_template` WHERE `entry`=gobjID AND `type`=3 INTO gobjLootID;
END||

-- Restore delimiter
DELIMITER ;

-- =====================
-- ==  UPDATEPACK 36  ==
-- =====================

DELIMITER ||
DROP PROCEDURE IF EXISTS `sp_set_npc_trigger`||
CREATE PROCEDURE `sp_set_npc_trigger`(IN npc_entry INT(10), IN on_off BOOLEAN)
BEGIN
  CALL `sp_error_entry`('NPC',npc_entry);

  IF on_off=1 THEN
        UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `id`=npc_entry;
        UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry`=npc_entry;         
  ELSE
        UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~128 WHERE `entry`=npc_entry;
  END IF;
END||

DROP PROCEDURE IF EXISTS `sp_set_npc_trigger_bylist`||
CREATE PROCEDURE `sp_set_npc_trigger_bylist`(IN entry_list LONGTEXT,IN on_off BOOLEAN)
BEGIN

  CALL `sp_set_entry_list` (entry_list,null);

  IF on_off=1 THEN
        UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `id` IN (SELECT * FROM `tdb_entry_list`);
        UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry` IN (SELECT * FROM `tdb_entry_list`);       
  ELSE
        UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~128 WHERE `entry` IN (SELECT * FROM `tdb_entry_list`);
  END IF;

  DROP TABLE `tdb_entry_list`;
END||
DELIMITER ;  
 
-- -------------------------------------------------------- 
-- 2011_08_27_00_world_version.sql 
-- -------------------------------------------------------- 
UPDATE `version` SET `db_version`='TDB 335.11.42' LIMIT 1;
 
 
-- -------------------------------------------------------- 
-- 2011_08_27_01_world_spell_script_names.sql 
-- -------------------------------------------------------- 
UPDATE `spell_script_names` SET `ScriptName`='spell_marrowgar_coldflame_bonestorm' WHERE `spell_id`=72705 AND `ScriptName`='spell_marrowgar_coldflame';
 
 
-- -------------------------------------------------------- 
-- 2011_08_28_00_world_instance_misc.sql 
-- -------------------------------------------------------- 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (70346,72456,72868,72869);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,70346,0,18,1,37672,0,0, '', 'Slime Puddle - target Mutated Abomination'),
(13,0,72456,0,18,1,38285,0,0, '', 'Slime Puddle - target Mutated Abomination'),
(13,0,72868,0,18,1,37672,0,0, '', 'Slime Puddle - target Mutated Abomination'),
(13,0,72869,0,18,1,38285,0,0, '', 'Slime Puddle - target Mutated Abomination');

UPDATE `creature_template` SET `exp`=2,`spell1`=70360,`spell2`=70539 WHERE `entry`=37672;
UPDATE `creature_template` SET `exp`=2,`spell1`=72527,`spell2`=72457 WHERE `entry`=38605;
UPDATE `creature_template` SET `exp`=2,`spell1`=70360,`spell2`=72875 WHERE `entry`=38786;
UPDATE `creature_template` SET `exp`=2,`spell1`=72527,`spell2`=72876 WHERE `entry`=38787;

UPDATE `creature_template` SET `exp`=2,`spell1`=70360,`spell2`=70539 WHERE `entry`=38285;
UPDATE `creature_template` SET `exp`=2,`spell1`=72527,`spell2`=72457 WHERE `entry`=38788;
UPDATE `creature_template` SET `exp`=2,`spell1`=70360,`spell2`=72875 WHERE `entry`=38789;
UPDATE `creature_template` SET `exp`=2,`spell1`=72527,`spell2`=72876 WHERE `entry`=38790;
 
 
-- -------------------------------------------------------- 
-- 2011_08_29_00_world_instance_misc.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_putricide_expunged_gas';
DELETE FROM `spell_proc_event` WHERE `entry` IN (70215,72858,72859,72860,70672,72455,72832,72833);
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(70672,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,0),
(72455,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,0),
(72832,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,0),
(72833,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,0);
 
 
-- -------------------------------------------------------- 
-- 2011_08_30_00_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `spell_id`=13161;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(13161, 'spell_hun_aspect_of_the_beast');
 
 
-- -------------------------------------------------------- 
-- 2011_09_01_00_world_disables.sql 
-- -------------------------------------------------------- 
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=23789;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES
(0, 23789, 8, 'Stoneclaw Totem TEST - can crash client by spawning too many totems');
 
 
-- -------------------------------------------------------- 
-- 2011_09_02_00_world_misc.sql 
-- -------------------------------------------------------- 
-- Add spell Magma Totem TEST to disables table
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=61904;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES
(0, 61904, 8, 'Magma Totem TEST - can crash client by spawning too many totems');

-- Move a high guid to a lower one (Vyragosa)
SET @oldguid = 250006;
SET @newguid = 202602;
UPDATE `creature` SET `guid`=@newguid WHERE `guid`=@oldguid;
UPDATE `creature_addon` SET `guid`=@newguid, `path_id`=@newguid*100 WHERE `guid`=@oldguid;
UPDATE `waypoint_data` SET `id`=@newguid*100 WHERE `id`=@oldguid*100;

-- By Aokromes:
-- Orientation fix for portal from ghostlands to eastern plagelands.
UPDATE `areatrigger_teleport` SET `target_orientation`=2.255664 WHERE `id`=4386;
-- Spawn Arcane Container also on heroic mode SLab
UPDATE `gameobject` SET `spawnMask`=3 WHERE `guid`=22674;
 
 
-- -------------------------------------------------------- 
-- 2011_09_02_02_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_rotface_mutated_infection';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(69674,'spell_rotface_mutated_infection'),
(71224,'spell_rotface_mutated_infection'),
(73022,'spell_rotface_mutated_infection'),
(73023,'spell_rotface_mutated_infection');
 
 
-- -------------------------------------------------------- 
-- 2011_09_03_00_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `spell_id` IN (67590,67602,67603,67604,65684,67176,67177,67178,65686,67222,67223,67224);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`)
VALUES
(67590, 'spell_powering_up'),
(67602, 'spell_powering_up'),
(67603, 'spell_powering_up'),
(67604, 'spell_powering_up'),
(65684, 'spell_valkyr_essences'),
(67176, 'spell_valkyr_essences'),
(67177, 'spell_valkyr_essences'),
(67178, 'spell_valkyr_essences'),
(67222, 'spell_valkyr_essences'),
(65686, 'spell_valkyr_essences'),
(67223, 'spell_valkyr_essences'),
(67224, 'spell_valkyr_essences'); 
 
-- -------------------------------------------------------- 
-- 2011_09_03_01_world_conditions.sql 
-- -------------------------------------------------------- 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `ConditionTypeOrReference` = 18 AND `SourceEntry` IN (65875,67303,67304,67305,65876,67306,67307,67308) ;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 0, 65875, 0, 18, 1, 34497, 2, 0, '', 'Twins Pact - Dark'),
(13, 0, 67303, 0, 18, 1, 34497, 2, 0, '', 'Twins Pact - Dark'),
(13, 0, 67304, 0, 18, 1, 34497, 2, 0, '', 'Twins Pact - Dark'),
(13, 0, 67305, 0, 18, 1, 34497, 2, 0, '', 'Twins Pact - Dark'),
(13, 0, 65876, 0, 18, 1, 34496, 2, 0, '', 'Twins Pact - Light'),
(13, 0, 67306, 0, 18, 1, 34496, 2, 0, '', 'Twins Pact - Light'),
(13, 0, 67307, 0, 18, 1, 34496, 2, 0, '', 'Twins Pact - Light'),
(13, 0, 67308, 0, 18, 1, 34496, 2, 0, '', 'Twins Pact - Light');
 
 
-- -------------------------------------------------------- 
-- 2011_09_03_02_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `spell_id` IN (65879,65916,67244,67245,67246,67248,67249,67250);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(65879, 'spell_power_of_the_twins'),
(65916, 'spell_power_of_the_twins'),
(67244, 'spell_power_of_the_twins'),
(67245, 'spell_power_of_the_twins'),
(67246, 'spell_power_of_the_twins'),
(67248, 'spell_power_of_the_twins'),
(67249, 'spell_power_of_the_twins'),
(67250, 'spell_power_of_the_twins');
 
 
-- -------------------------------------------------------- 
-- 2011_09_03_03_world_creature_template.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `ScriptName`='npc_vereth_the_cunning' WHERE `entry`=30944; 
 
-- -------------------------------------------------------- 
-- 2011_09_03_04_world_misc.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `npcflag`=`npcflag`|0x1000000 WHERE `entry` in(31770,31736);
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`npcflag`=`npcflag`|0x1000000,`VehicleId`=282,`spell1`=59643,`spell2`=4342,`spell3`=4336 WHERE `entry`=31785;
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`npcflag`=`npcflag`|0x1000000,`VehicleId`=282,`spell1`=4338,`spell2`=4342,`spell3`=4336 WHERE `entry`=31784;
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` in (31785,31770,31736,31784);
INSERT INTO `npc_spellclick_spells` VALUES
(31785,59656,13283,1,13283,1,0,0,0),
(31770,59654,0,0,0,1,0,0,0),
(31736,59592,13280,1,13280,1,0,0,0),
(31784,59593,0,0,0,1,0,0,0);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (59643,4338);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(59643, 'spell_q13280_13283_plant_battle_standard'),
(4338, 'spell_q13280_13283_plant_battle_standard'); 
 
-- -------------------------------------------------------- 
-- 2011_09_03_05_world_gossip_menu_option.sql 
-- -------------------------------------------------------- 
DELETE FROM `gossip_menu_option` WHERE `menu_id`=1293 AND `id`=1; 
DELETE FROM `gossip_menu_option` WHERE `menu_id`=1293 AND `id`=2;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES
(1293,1,0, 'Make this inn my home!',8,66179,0,0,0,0,NULL),
(1293,2,1, 'I want to browse your goods!',3,66179,0,0,0,0,NULL); 
 
-- -------------------------------------------------------- 
-- 2011_09_03_06_world_spell_threat.sql 
-- -------------------------------------------------------- 
-- ----------
-- Tank Class Passive Threat
-- ----------
DELETE FROM spell_linked_spell WHERE spell_effect IN (57340, 57339);
INSERT INTO spell_linked_spell VALUES
    (7376,  57339, 2, 'Defensive Stance Passive - Tank Class Passive Threat'),
    (21178, 57339, 2, 'Bear Form (Passive2) - Tank Class Passive Threat'),
    (25780, 57340, 2, 'Righteous Fury - Tank Class Passive Threat'),
    (48263, 57340, 2, 'Frost Presence - Tank Class Passive Threat');

-- ----------
-- restructure spell_threat
-- ----------
TRUNCATE TABLE `spell_threat`;
ALTER    TABLE `spell_threat` CHANGE `Threat` `flatMod` int(6);
ALTER    TABLE `spell_threat` ADD COLUMN `pctMod`   FLOAT NOT NULL DEFAULT 1.0 COMMENT 'threat multiplier for damage/healing' AFTER `flatMod`;
ALTER    TABLE `spell_threat` ADD COLUMN `apPctMod` FLOAT NOT NULL DEFAULT 0.0 COMMENT 'additional threat bonus from attack power' AFTER `pctMod`;
INSERT INTO `spell_threat` VALUES
-- Other
-- Src: SELECT id, SpellNameEN, RankEN FROM `Spell` WHERE `DescriptionEN` LIKE '%threat%' AND `SpellFamilyName` <> '0' AND NOT (Attributes & 0x40) GROUP BY SpellNameEN ORDER BY RankEN DESC;
    (5676,  0,   2.00, 0.0),  -- Searing Pain (Rank 1) (Warlock)
    (28176, 0,   0.00, 0.0),  -- Fel Armor - Heal (Rank 1) (Warlock) [Assumption]
    (8056,  0,   2.00, 0.0),  -- Frost Shock (Rank 1) (Shaman) [Assumption]
    (26688, 0,   0.00, 0.0),  -- Anesthetic Poison - Proc (Rank 1) (Rogue)
    (15237, 0,   0.00, 0.0),  -- Holy Nova - Heal (Rank 1) (Priest)
    (23455, 0,   0.00, 0.0),  -- Holy Nova - Damage (Rank 1) (Priest)
    (32546, 0,   0.50, 0.0),  -- Binding Heal (Rank 1) (Priest) [Assumption]
    (33619, 0,   0.00, 0.0),  -- Reflective Shield - Proc (Priest)
    (2139,  180, 1.00, 0.0),  -- Counterspell (Mage) [Assumption]
-- Death Knight
-- Src: http://www.tankspot.com/showthread.php?40485-Death-Knight-threat-values&p=113584#post113584
    (63611, 0,   0.00, 0.0),  -- Blood Presence - Heal
    (45524, 240, 1.00, 0.0),  -- Chains of Ice
    (43265, 0,   1.90, 0.0),  -- Death and Decay
    (49576, 110, 1.00, 0.0),  -- Death Grip
    (48743, 0,   0.00, 0.0),  -- Death Pact
    (65142, 0,   0.00, 0.0),  -- Ebon Plague
    (47568, 0,   0.00, 0.0),  -- Empower Rune Weapon
    (51209, 112, 1.00, 0.0),  -- Hungering Cold
    (49039, 110, 1.00, 0.0),  -- Lichborn
    (56815, 0,   1.75, 0.0),  -- Rune Strike
    (50422, 0,   0.00, 0.0),  -- Scent of Blood - Proc
    (55090, 51,  1.00, 0.0),  -- Scourge Strike (Rank 1)
    (55265, 63,  1.00, 0.0),  -- Scourge Strike (Rank 2)
    (55270, 98,  1.00, 0.0),  -- Scourge Strike (Rank 3)
    (55271, 120, 1.00, 0.0),  -- Scourge Strike (Rank 4)
    (49916, 138, 1.00, 0.0),  -- Strangulate
    (50181, 0,   0.00, 0.0),  -- Vendetta - Proc
-- Druid
-- Src: http://www.tankspot.com/showthread.php?47813-WOTLK-Bear-Threat-Values&p=200948#post200948
    (17057, 0,   0.00, 0.0),  -- Furor - Proc 
    (5211,  53,  1.00, 0.0),  -- Bash (Rank 3)
    (6798,  105, 1.00, 0.0),  -- Bash (Rank 2)
    (8983,  158, 1.00, 0.0),  -- Bash (Rank 1)
    (45334, 40,  1.00, 0.0),  -- Feral Charge (Bear) - Root
    (19675, 80,  1.00, 0.0),  -- Feral Charge (Bear) - Interrupt
    (34299, 0,   0.00, 0.0),  -- Improved Leader of the Pack - Heal
    (6807,  13,  1.00, 0.0),  -- Maul (Rank 1)
    (6808,  20,  1.00, 0.0),  -- Maul (Rank 2)
    (6809,  27,  1.00, 0.0),  -- Maul (Rank 3)
    (8972,  47,  1.00, 0.0),  -- Maul (Rank 4)
    (9745,  75,  1.00, 0.0),  -- Maul (Rank 5)
    (9880,  106, 1.00, 0.0),  -- Maul (Rank 6)
    (9881,  140, 1.00, 0.0),  -- Maul (Rank 7)
    (26996, 212, 1.00, 0.0),  -- Maul (Rank 8)
    (48479, 345, 1.00, 0.0),  -- Maul (Rank 9)
    (48480, 422, 1.00, 0.0),  -- Maul (Rank 10)
    (60089, 638, 1.00, 0.0),  -- Faerie Fire (Feral) - Proc
    (33745, 182, 0.50, 0.0),  -- Lacerate (Rank 1)
    (48567, 409, 0.50, 0.0),  -- Lacerate (Rank 2)
    (48568, 515, 0.50, 0.0),  -- Lacerate (Rank 3)
    (779,   0,   1.50, 0.0),  -- Swipe (Bear) (Rank 1)
    (5209,  98,  1.00, 0.0),  -- Challenging Roar
    (29166, 0,   10.0, 0.0),  -- Innervate [base is 5 per 1 mana]
-- Paladin
-- Src: http://www.tankspot.com/showthread.php?39761-Paladin-Threat-Values-(Updated-for-3.2.2)&p=103813#post103813
    (7294,  0,   2.00, 0.0),  -- Retribution Aura
    (20185, 0,   0.00, 0.0),  -- Judgement of Light
    (19742, 0,   0.00, 0.0),  -- Blessing of Wisdom (Rank 1)
    (25894, 0,   0.00, 0.0),  -- Greater Blessing of Wisdom (Rank 1)
    (20470, 0,   0.00, 0.0),  -- Righteous Fury
    (498,   0,   0.00, 0.0),  -- Divine Protection
-- Warrior
-- Src: http://www.tankspot.com/showthread.php?39775-WoW-3.0-Threat-Values-(Warrior)&p=103972#post103972
    (845,   8,   1.00, 0.0),  -- Cleave (Rank 1)
    (7369,  15,  1.00, 0.0),  -- Cleave (Rank 2)
    (11608, 25,  1.00, 0.0),  -- Cleave (Rank 3)
    (11609, 35,  1.00, 0.0),  -- Cleave (Rank 4)
    (20569, 48,  1.00, 0.0),  -- Cleave (Rank 5)
    (25231, 68,  1.00, 0.0),  -- Cleave (Rank 6)
    (47519, 95,  1.00, 0.0),  -- Cleave (Rank 7)
    (47520, 112, 1.00, 0.0),  -- Cleave (Rank 8)
    (78,    5,   1.00, 0.0),  -- Heroic Strike (Rank 1)
    (284,   10,  1.00, 0.0),  -- Heroic Strike (Rank 2)
    (285,   16,  1.00, 0.0),  -- Heroic Strike (Rank 3)
    (1608,  22,  1.00, 0.0),  -- Heroic Strike (Rank 4)
    (11564, 31,  1.00, 0.0),  -- Heroic Strike (Rank 5)
    (11565, 48,  1.00, 0.0),  -- Heroic Strike (Rank 6)
    (11566, 70,  1.00, 0.0),  -- Heroic Strike (Rank 7)
    (11567, 92,  1.00, 0.0),  -- Heroic Strike (Rank 8)
    (25286, 104, 1.00, 0.0),  -- Heroic Strike (Rank 9)
    (29707, 121, 1.00, 0.0),  -- Heroic Strike (Rank 10)
    (30324, 164, 1.00, 0.0),  -- Heroic Strike (Rank 11)
    (47449, 224, 1.00, 0.0),  -- Heroic Strike (Rank 12)
    (47450, 259, 1.00, 0.0),  -- Heroic Strike (Rank 13)
    (57755, 0,   1.50, 0.0),  -- Heroic Throw
    (6572,  7,   1.00, 0.0),  -- Revenge (Rank 1)
    (6574,  11,  1.00, 0.0),  -- Revenge (Rank 2)
    (7379,  15,  1.00, 0.0),  -- Revenge (Rank 3)
    (11600, 27,  1.00, 0.0),  -- Revenge (Rank 4)
    (11601, 41,  1.00, 0.0),  -- Revenge (Rank 5)
    (25288, 53,  1.00, 0.0),  -- Revenge (Rank 6)
    (25269, 58,  1.00, 0.0),  -- Revenge (Rank 7)
    (30357, 71,  1.00, 0.0),  -- Revenge (Rank 8)
    (57823, 121, 1.00, 0.0),  -- Revenge (Rank 9)
    (23922, 228, 1.00, 0.0),  -- Shield Slam (Rank 1)
    (23923, 268, 1.00, 0.0),  -- Shield Slam (Rank 2)
    (23924, 307, 1.00, 0.0),  -- Shield Slam (Rank 3)
    (23925, 347, 1.00, 0.0),  -- Shield Slam (Rank 4)
    (25258, 387, 1.00, 0.0),  -- Shield Slam (Rank 5)
    (30356, 426, 1.00, 0.0),  -- Shield Slam (Rank 6)
    (47487, 650, 1.00, 0.0),  -- Shield Slam (Rank 7)
    (47488, 770, 1.00, 0.0),  -- Shield Slam (Rank 8)
    (1464,  18,  1.00, 0.0),  -- Slam (Rank 1)
    (8820,  24,  1.00, 0.0),  -- Slam (Rank 2)
    (11604, 38,  1.00, 0.0),  -- Slam (Rank 3)
    (11605, 49,  1.00, 0.0),  -- Slam (Rank 4)
    (25241, 59,  1.00, 0.0),  -- Slam (Rank 5)
    (25242, 78,  1.00, 0.0),  -- Slam (Rank 6)
    (47474, 123, 1.00, 0.0),  -- Slam (Rank 7)
    (47475, 140, 1.00, 0.0),  -- Slam (Rank 8)
    (7386,  345, 1.00, 0.05), -- Sunder Armor
    (20243, 0,   1.00, 0.05), -- Devastate (Rank 1)
    (6343,  0,   1.85, 0.0);  -- Thunder Clap (Rank 1)
 
 
-- -------------------------------------------------------- 
-- 2011_09_03_07_world_achievement_criteria_data.sql 
-- -------------------------------------------------------- 
DELETE FROM `disables` WHERE `entry` IN (1242, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810, 1825, 1811, 1812, 1813, 1814, 1815, 1816, 1817, 1818, 1819, 1826, 3386, 3387, 3388, 3389) AND `sourceType` = 4;

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (1242, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810, 1825, 1811, 1812, 1813, 1814, 1815, 1816, 1817, 1818, 1819, 1826, 3386, 3387, 3388, 3389);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(1242, 11, 0, 0, 'achievement_bg_av_perfection'),
(1803, 11, 0, 0, 'achievement_bg_av_perfection'),
(1804, 11, 0, 0, 'achievement_bg_av_perfection'),
(1805, 11, 0, 0, 'achievement_bg_av_perfection'),
(1806, 11, 0, 0, 'achievement_bg_av_perfection'),
(1807, 11, 0, 0, 'achievement_bg_av_perfection'),
(1808, 11, 0, 0, 'achievement_bg_av_perfection'),
(1809, 11, 0, 0, 'achievement_bg_av_perfection'),
(1810, 11, 0, 0, 'achievement_bg_av_perfection'),
(1825, 11, 0, 0, 'achievement_bg_av_perfection'),
(1811, 11, 0, 0, 'achievement_bg_av_perfection'),
(1812, 11, 0, 0, 'achievement_bg_av_perfection'),
(1813, 11, 0, 0, 'achievement_bg_av_perfection'),
(1814, 11, 0, 0, 'achievement_bg_av_perfection'),
(1815, 11, 0, 0, 'achievement_bg_av_perfection'),
(1816, 11, 0, 0, 'achievement_bg_av_perfection'),
(1817, 11, 0, 0, 'achievement_bg_av_perfection'),
(1818, 11, 0, 0, 'achievement_bg_av_perfection'),
(1819, 11, 0, 0, 'achievement_bg_av_perfection'),
(1826, 11, 0, 0, 'achievement_bg_av_perfection'),
(3386, 11, 0, 0, 'achievement_everything_counts'),
(3387, 11, 0, 0, 'achievement_everything_counts'),
(3388, 11, 0, 0, 'achievement_everything_counts'),
(3389, 11, 0, 0, 'achievement_everything_counts'); 
 
-- -------------------------------------------------------- 
-- 2011_09_03_08_world_spell_dbc.sql 
-- -------------------------------------------------------- 
ALTER TABLE `spell_dbc` ADD COLUMN `AttributesEx6` INT UNSIGNED NOT NULL DEFAULT '0' AFTER `AttributesEx5`;
ALTER TABLE `spell_dbc` ADD COLUMN `AttributesEx7` INT UNSIGNED NOT NULL DEFAULT '0' AFTER `AttributesEx6`;
 
 
-- -------------------------------------------------------- 
-- 2011_09_03_09_world_spell_dbc.sql 
-- -------------------------------------------------------- 
-- Dummy effect with caster as target
DELETE FROM `spell_dbc` WHERE `id` IN (68308);
INSERT INTO `spell_dbc` (`Id`, `Attributes`, `AttributesEx`, `AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`Effect1`,`EffectImplicitTargetA1`,`EffectImplicitTargetB1`,`comment`)
VALUES
(68308, 0x09800100, 0x00000420, 0x00004005, 0x10040000, 0x00000080, 0x00000008, 0x00001000, 3, 1, 0, 'Vault of Archavon - Earth, Wind & Fire - Achievement Check');
 
 
-- -------------------------------------------------------- 
-- 2011_09_03_10_world_spell_dbc.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_dbc` WHERE `Id`=63975;
INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
(63975,0,0,384,0,0,262144,128,0,0,0,0,1,0,0,0,0,0,0,0,0,13,0,-1,0,0,77,0,0,0,1,1,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,'Glyph of Blackstab - 3.2.2');
 
 
-- -------------------------------------------------------- 
-- 2011_09_04_00_world_quest_template.sql 
-- -------------------------------------------------------- 
UPDATE `quest_template` SET `RequiredRaces`=1101 WHERE `entry` IN (4362,4363); -- The Fate of the Kingdom & The Princess's Surprise
UPDATE `quest_template` SET `NextQuestId`=4342 WHERE `entry`=4341; -- Kharan Mighthammer
UPDATE `quest_template` SET `PrevQuestId`=4341 WHERE `entry`=4342; -- Kharan's Tale
UPDATE `quest_template` SET `PrevQuestId`=4342 WHERE `entry`=4361; -- The Bearer of Bad News
UPDATE `quest_template` SET `PrevQuestId`=4361 WHERE `entry`=4362; -- The Fate of the Kingdom
UPDATE `quest_template` SET `PrevQuestId`=4362 WHERE `entry`=4363; -- The Princess's Surprise
 
 
-- -------------------------------------------------------- 
-- 2011_09_04_01_world_trinity_string.sql 
-- -------------------------------------------------------- 
DELETE FROM `trinity_string` WHERE `entry`=5030;
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(5030, '%s attempts to run away in fear!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
 
 
-- -------------------------------------------------------- 
-- 2011_09_04_02_world_trinity_string.sql 
-- -------------------------------------------------------- 
UPDATE `trinity_string` SET `content_default`='Faction %s (%u) can''t have reputation.' WHERE `entry`=326; -- can'nt -> can't
 
 
-- -------------------------------------------------------- 
-- 2011_09_05_00_world_spell_target_position.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_target_position` WHERE `id` IN (17278,49097,55431);
INSERT INTO `spell_target_position` (`id` ,`target_map` ,`target_position_x` ,`target_position_y` ,`target_position_z` ,`target_orientation`) VALUES
(17278, 329, 3534.3, -2966.74, 125.001, 0.279253), -- Cannon Fire cast by a trap GO Cannonball
(49097, 0, -466.4, 1496.36, 17.43, 2.1), -- Out of Body Experience, quest with the same name (Grizzly Hills -> Silverpine)
(55431, 571, 5787.781250, -1582.446045, 234.830414, 2.14); -- Summon Gymer
-- 53821 Teach:Death Gate - couldn't find enough info
 
 
-- -------------------------------------------------------- 
-- 2011_09_05_01_world_gossip.sql 
-- -------------------------------------------------------- 
-- Fixing Lord Thorval, Lady Alistra and Amal'thazad in map 609
UPDATE `creature_template` SET `gossip_menu_id`=9691 WHERE `entry`=28471; -- Lady Alistra
UPDATE `creature_template` SET `gossip_menu_id`=9692 WHERE `entry`=28472; -- Lord Thorval
UPDATE `creature_template` SET `gossip_menu_id`=9693 WHERE `entry`=28474; -- Amal'thazad

DELETE FROM `gossip_menu` WHERE `entry`=9791 AND `text_id`=13475;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9791,13475);

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (9691,9692,9693,9791,10371);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9691,0,3,'I seek training, Lady Alistra.',5,16,0,0,0,0,''),
(9691,1,0,'I wish to unlearn my talents.',1,1,9791,0,0,0,''),
(9691,2,0,'Learn about Dual Talent Specialization.',1,1,10371,0,0,0,''),
(9692,0,3,'I seek training, Lord Thorval.',5,16,0,0,0,0,''),
(9692,1,0,'I wish to unlearn my talents.',1,1,9791,0,0,0,''),
(9692,2,0,'Learn about Dual Talent Specialization.',1,1,10371,0,0,0,''),
(9693,0,3,'I seek training, Amal''thazad.',5,16,0,0,0,0,''),
(9693,1,0,'I wish to unlearn my talents.',1,1,9791,0,0,0,''),
(9693,2,0,'Learn about Dual Talent Specialization.',1,1,10371,0,0,0,''),
(9791,0,0,'Yes. I do.',16,16,0,0,0,0,''),
(10371,0,0,'Purchase a Dual Talent Specialization.',18,16,0,0,0,10000000,'Are you sure you wish to purchase a Dual Talent Specialization?'); -- Fixing this entry because Dual Talent Specialization needs confirmation by players.

-- Darion Mograine DK trainer (Since the quest 'Taking back Acherus' until go to Stormwind/Orgrimmar)
-- The gossip_menu (`entry` and `text_id`) are already in TDB UP41. Only needs this changes:
UPDATE `creature_template` SET `gossip_menu_id`=10027, `trainer_class`=6 WHERE `entry`=31084;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=10027;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(10027,0,3,'I require training, Highlord.',5,16,0,0,0,0,'');
 
 
-- -------------------------------------------------------- 
-- 2011_09_06_00_world_sai.sql 
-- -------------------------------------------------------- 
UPDATE `smart_scripts` SET `action_param1`=1,`event_flags`=1 WHERE `action_type`=25;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND ((`entryorguid`=11360 AND `id`=1) OR (`entryorguid`=27225 AND `id`=20) OR (`entryorguid`=27615 AND `id`=15));
UPDATE `smart_scripts` SET `id`=20 WHERE `entryorguid`=27225 AND `id`=21;
UPDATE `smart_scripts` SET `id`=21 WHERE `entryorguid`=27225 AND `id`=22;
DELETE FROM `creature_text` WHERE `text`='%s attempts to run away in fear!';
 
 
-- -------------------------------------------------------- 
-- 2011_09_06_01_world_misc.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_dbc` WHERE `Id`=24677;
INSERT INTO `spell_dbc` (`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`AttributesEx7`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`) VALUES
(24677,0,0,256,0,4,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,6,0,-1,0,0,77,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,'GY Mid Trigger - 2.0.12 spell - AV Snowfall Graveyard');

UPDATE `gameobject_template` SET `data16`=1 WHERE `entry`=180418 AND `WDBVerified`=11723;
 
 
-- -------------------------------------------------------- 
-- 2011_09_07_00_world_spell_linked_spell.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=44572;
INSERT INTO `spell_linked_spell` VALUES
(44572,71757,0, 'Deep Freeze - Damage Proc');

DELETE FROM `spell_bonus_data` WHERE `entry`=71757;
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(71757,2.143,0,0,0, 'Mage - Deep Freeze');
 
 
-- -------------------------------------------------------- 
-- 2011_09_07_01_world_sai.sql 
-- -------------------------------------------------------- 
DELETE FROM `gossip_menu` WHERE `entry`=2211 AND `text_id`=2850;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(2211, 2850);

UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=160445;

DELETE FROM `smart_scripts` WHERE `entryorguid`=160445 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(160445, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 12, 9136, 1, 60*1000, 0, 0, 0, 8, 0, 0, 0, -7917.378906, -2610.533936, 221.123123, 5.040257, 'Sha''ni Proudtusk''s Remains - On gossip hello summon Sha''ni Proudtusk');
-- Need a way to prevent spamming this action.
 
 
-- -------------------------------------------------------- 
-- 2011_09_08_00_world_conditions.sql 
-- -------------------------------------------------------- 
DELETE FROM `conditions` WHERE `sourceEntry` IN (62584,64185);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`)
VALUES
(13,0,62584,0,18,1,33202,0,0,'','target for Lifebinder\'s Gift'),
(13,0,62584,0,18,1,32919,0,0,'','target for Lifebinder\'s Gift'),
(13,0,62584,0,18,1,32916,0,0,'','target for Lifebinder\'s Gift'),
(13,0,62584,0,18,1,32906,0,0,'','target for Lifebinder\'s Gift'),
(13,0,62584,0,18,1,33203,0,0,'','target for Lifebinder\'s Gift'),
(13,0,62584,0,18,1,32918,0,0,'','target for Lifebinder\'s Gift'),
(13,0,62584,0,18,1,33215,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,33202,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,32919,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,32916,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,32906,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,33203,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,32918,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,33215,0,0,'','target for Lifebinder\'s Gift');
 
 
-- -------------------------------------------------------- 
-- 2011_09_08_01_world_spell_target_position.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_target_position` WHERE `id` IN (46233,52462,54963);
INSERT INTO `spell_target_position` (`id` ,`target_map` ,`target_position_x` ,`target_position_y` ,`target_position_z` ,`target_orientation`) VALUES
(46233,571,3202.959961,5274.073730,46.887897,0.015704), -- Call Mammoth Orphan
(52462,609,2387.738525,-5898.617676,108.353539,4.354776), -- Hide In Mine Car
(54963,571,6153.721191,-1075.270142,403.517365,2.232988); -- Teleporter Power Cell
 
 
-- -------------------------------------------------------- 
-- 2011_09_08_02_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_baltharus_enervating_brand';
 
 
-- -------------------------------------------------------- 
-- 2011_09_08_03_world_item_template.sql 
-- -------------------------------------------------------- 
UPDATE `item_template` SET `BuyPrice` = 40000, `delay` = 0, `spellcharges_1` = -1, `spellcooldown_1` = 0, `spellcooldown_2` = 0, `spellcooldown_3` = 0, `spellcooldown_4` = 0, `spellcooldown_5` = 0, `spellcategory_1` = 79, `spellcategorycooldown_1` = 3000, `spellcategorycooldown_2` = 0, `spellcategorycooldown_3` = 0, `spellcategorycooldown_4` = 0, `spellcategorycooldown_5` = 0, `WDBVerified`=12340 WHERE `entry` = 45006; -- Jillian's Tonic of Endless Rage
UPDATE `item_template` SET `BuyPrice` = 40000, `delay` = 0, `spellcharges_1` = -1, `spellcooldown_1` = 0, `spellcooldown_2` = 0, `spellcooldown_3` = 0, `spellcooldown_4` = 0, `spellcooldown_5` = 0, `spellcategory_1` = 79, `spellcategorycooldown_1` = 3000, `spellcategorycooldown_2` = 0, `spellcategorycooldown_3` = 0, `spellcategorycooldown_4` = 0, `spellcategorycooldown_5` = 0, `WDBVerified`=12340 WHERE `entry` = 45007; -- Jillian's Tonic of Pure Mojo
UPDATE `item_template` SET `delay` = 0, `spellcooldown_1` = 0, `spellcooldown_2` = 0, `spellcooldown_3` = 0, `spellcooldown_4` = 0, `spellcooldown_5` = 0, `spellcategorycooldown_2` = 0, `spellcategorycooldown_3` = 0, `spellcategorycooldown_4` = 0, `spellcategorycooldown_5` = 0, `WDBVerified`=12340 WHERE `entry` = 45008; -- Jillian's Tonic of Stoneblood
UPDATE `item_template` SET `BuyPrice` = 40000, `delay` = 0, `spellcharges_1` = -1, `spellcooldown_1` = 0, `spellcooldown_2` = 0, `spellcooldown_3` = 0, `spellcooldown_4` = 0, `spellcooldown_5` = 0, `spellcategory_1` = 79, `spellcategorycooldown_1` = 3000, `spellcategorycooldown_2` = 0, `spellcategorycooldown_3` = 0, `spellcategorycooldown_4` = 0, `spellcategorycooldown_5` = 0, `WDBVerified`=12340 WHERE `entry` = 45009; -- Jillian's Tonic of the Frost Wyrm
UPDATE `item_template` SET `BuyPrice` = 200, `stackable` = 20, `delay` = 0, `spellcharges_1` = -1, `spellcooldown_1` = 0, `spellcooldown_2` = 0, `spellcooldown_3` = 0, `spellcooldown_4` = 0, `spellcooldown_5` = 0, `spellcategory_1` = 4, `spellcategorycooldown_1` = 60000, `spellcategorycooldown_2` = 0, `spellcategorycooldown_3` = 0, `spellcategorycooldown_4` = 0, `spellcategorycooldown_5` = 0, `WDBVerified`=12340 WHERE `entry` = 45276; -- Jillian's Genius Juice
UPDATE `item_template` SET `BuyPrice` = 200, `stackable` = 20, `delay` = 0, `spellcharges_1` = -1, `spellcooldown_1` = 0, `spellcooldown_2` = 0, `spellcooldown_3` = 0, `spellcooldown_4` = 0, `spellcooldown_5` = 0, `spellcategory_1` = 4, `spellcategorycooldown_1` = 60000, `spellcategorycooldown_2` = 0, `spellcategorycooldown_3` = 0, `spellcategorycooldown_4` = 0, `spellcategorycooldown_5` = 0, `WDBVerified`=12340 WHERE `entry` = 45277; -- Jillian's Savior Sauce
UPDATE `item_template` SET `BuyPrice` = 6, `delay` = 0, `spellcharges_1` = -1, `spellcooldown_1` = 0, `spellcategory_1` = 11, `spellcategorycooldown_1` = 1000, `WDBVerified`=12340 WHERE `entry` = 45279; -- Jillian's Gourmet Fish Feast
UPDATE `item_template` SET `WDBVerified`=12340 WHERE `entry` =46766; -- Red War Fuel
UPDATE `item_template` SET `Quality`=0,`Flags`=65538,`WDBVerified`=12340 WHERE `entry`=10791; -- Goblin Engineer Membership Card
 
 
-- -------------------------------------------------------- 
-- 2011_09_10_00_world_spell_linked_spell.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (57294,57399);
INSERT INTO `spell_linked_spell` VALUES
(57294,59690,2,'Well Fed - Well Fed (DND)'),
(57399,59699,2,'Well Fed - Well Fed (DND)');

DELETE FROM `spell_group` WHERE `spell_id` IN (59690,59699);
 
 
-- -------------------------------------------------------- 
-- 2011_09_11_00_world_creature_template.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~1 WHERE `unit_flags` & 1; 
 
-- -------------------------------------------------------- 
-- 2011_09_11_01_world_sai.sql 
-- -------------------------------------------------------- 
-- Sets SmartAI for Mechagnomes
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25814;

-- Says for Mechagnomes
DELETE FROM `creature_text` WHERE `entry`=25814;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(25814,1,1, 'We are Mechagnome...resistance is futile.',12,0,0,0,0,0, ''),
(25814,1,2, 'The flesh is weak. We will make you better, stronger...faster.',12,0,0,0,0,0, ''),
(25814,1,3, 'We can decurse you, we have the technology.',12,0,0,0,0,0, '');

-- Mechagnome SAI
-- NOTE: Mechagnome SAI required for Horde quest Souls of the Decursed 
DELETE FROM `smart_scripts` WHERE `entryorguid`=25814 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25814,0,0,0,4,0,100,0,0,0,0,0,1,1,10000,0,0,0,0,0,0,0,0,0,0,0,0, 'Fizzcrank Mechagnome - Chance Say on Aggro'),
(25814,0,1,0,8,0,100,0,45980,0,0,0,33,25773,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Fizzcrank Mechagnome - Killcredit on spellhit - Recursive'),
(25814,0,2,0,8,0,100,0,46485,0,0,0,33,26096,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Fizzcrank Mechagnome - Killcredit on spellhit - Souls of the Decursed');
-- (25814,0,2,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Fizzcrank Mechagnome - On Re-Cursive Transmatter Injection spellhit despawn self'),

-- Links item spell to spawn spell
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=45980;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (45980,46022,0, 'Re-Cursive quest');

-- Despawn Mechagnome after spellcast (Mechagnome would not despawn using SAI resulting in possibility of multiple uses of item for credit)
DELETE FROM `spell_scripts` WHERE `id`=45980;
INSERT INTO `spell_scripts` (`id`, `effIndex`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(45980,0,1,18,0,0,0,0,0,0,0);

-- FOR SURVIVOR

-- Sets smartAI for Fizzcrank Survivor
UPDATE `creature_template` SET `AIName` ='SmartAI' WHERE `entry`=25773;

-- Says for Fizzcrank Survivor
DELETE FROM `creature_text` WHERE `entry`=25773;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(25773,0,1, 'I survived and I''m flesh again!',12,0,0,0,0,0, ''),
(25773,0,2, 'But... but... I was perfect!',12,0,0,0,0,0, ''),
(25773,0,3, 'Where am I? Who are you? What''s that strange feeling?',12,0,0,0,0,0, ''),
(25773,0,4, 'I''m flesh and blood again! Thank you!',12,0,0,0,0,0, '');

-- Random says, Teleport spell effect & despawn
DELETE FROM `smart_scripts` WHERE `entryorguid`=25773 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25773,0,0,0,1,0,100,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 'Fizzcrank Survivor - On spawn talk'),
(25773,0,1,0,1,0,100,1,5000,5000,5000,5000,11,41232,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Fizzcrank Survivor - OOC Cast spell'),
(25773,0,2,0,1,0,100,0,5000,5000,5000,5000,41,2000,0,0,0,0,0,0,0,0,0,0,0,0,0, 'Fizzcrank Survivor - OOC Force despawn');

-- Remove Eventai and Eventai says
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (25814,25773);
DELETE FROM `creature_ai_texts` WHERE `entry` IN (-533,-534,-535);
 
 
-- -------------------------------------------------------- 
-- 2011_09_11_02_world_creature_template.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `exp`=0,`speed_run`=0.78571 WHERE `entry`=28239; -- Arcane Beam
DELETE FROM `creature_template_addon` WHERE `entry`=28239;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(28239,0,0,1,0, '51019'); -- Arcane Beam
 
 
-- -------------------------------------------------------- 
-- 2011_09_11_03_world_gameobject.sql 
-- -------------------------------------------------------- 
UPDATE `gameobject_template` SET `WDBVerified`=12340 WHERE `entry`=179545;
DELETE FROM `gameobject` WHERE `id` IN (179545,179485);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(6,179545,429,1,1,116.135,638.836,-48.467,-0.785397,0,0,0,1,7200,255,1),
(159,179485,429,1,1,558.806,550.065,-25.4008,3.14159,0,0,0,1,180,255,1);
 
 
-- -------------------------------------------------------- 
-- 2011_09_11_04_world_spell_linked_spell.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`IN (65686, 65684, 67222, 67176, 67223, 67177, 67224, 67178);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES 
(65686, -65684, 2, 'Remove Dark Essence 10M'), 
(65684, -65686, 2, 'Remove Light Essence 10M'),
(67222, -67176, 2, 'Remove Dark essence 10M H'),
(67176, -67222, 2, 'Remove Light essence 10M H'),
(67223, -67177, 2, 'Remove Dark essence 25M'),
(67177, -67223, 2, 'Remove Light essence 25M'),
(67224, -67178, 2, 'Remove Dark essence 25M H'),
(67178, -67224, 2, 'Remove Light essence 25M H');
 
 
-- -------------------------------------------------------- 
-- 2011_09_11_05_world_misc.sql 
-- -------------------------------------------------------- 
-- Orgrimmar: Hidden Enemies (5727)
SET @Gossip=21272;

DELETE FROM `gossip_menu` WHERE `text_id` IN (4513,4533,4534,4535,4536);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(3701,4513), -- 1st
(@Gossip+0,4533), -- 2nd
(@Gossip+1,4534), -- 3rd
(@Gossip+2,4535), -- 4th
(@Gossip+3,4536); -- last
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (3701,@Gossip+0,@Gossip+1,@Gossip+2,@Gossip+3);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(3701,0,0, 'You may speak frankly, Neeru...' ,1,1,@Gossip+0,0,0,0,NULL),
(@Gossip+0,0,0, 'It is good to see the Burning Blade is taking over where the Shadow Council once failed.' ,1,1,@Gossip+1,0,0,0,NULL),
(@Gossip+1,0,0, 'So the Searing Blade is expendable?' ,1,1,@Gossip+2,0,0,0,NULL),
(@Gossip+2,0,0, 'If there is anything you would have of me...' ,1,1,@Gossip+3,0,0,0,NULL); -- Must Link to Final Action Menu as well

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=3216; -- Neeru Fireblade
DELETE FROM `smart_scripts` WHERE `entryorguid`=3216 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(3216, 0, 0, 0, 62, 0, 100, 0, @Gossip+2, 0, 0, 0, 15, 5727, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Neeru Fireblade - On gossip select give Hidden Enemies quest completed');

UPDATE `quest_template` SET `SpecialFlags`=`SpecialFlags`|2 WHERE `entry`=5727; -- Hidden Enemies (quest completable by external event)
-- Conditions so gossips don't show up if the player doesn't have the item
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=3701;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup` BETWEEN @Gossip+0 AND @Gossip+3;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,3701,0,0,2,14544,1,0,0,'', 'Neeru Fireblade: Quest Hidden Enemies gossip option - requires item Lieutenant''s Insignia'),
(14,@Gossip+0,4533,0,2,14544,1,0,0, '', 'Neeru Fireblade: Quest Hidden Enemies gossip 1 - requires item Lieutenant''s Insignia'),
(14,@Gossip+1,4534,0,2,14544,1,0,0, '', 'Neeru Fireblade: Quest Hidden Enemies gossip 2 - requires item Lieutenant''s Insignia'),
(14,@Gossip+2,4535,0,2,14544,1,0,0, '', 'Neeru Fireblade: Quest Hidden Enemies gossip 3 - requires item Lieutenant''s Insignia'),
(14,@Gossip+3,4536,0,2,14544,1,0,0, '', 'Neeru Fireblade: Quest Hidden Enemies gossip 4 - requires item Lieutenant''s Insignia');
 
 
-- -------------------------------------------------------- 
-- 2011_09_11_06_world_spell_conditions.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=66512;
INSERT INTO `spell_linked_spell` VALUES
(66512, 66510, 0, 'Summon Deep Jormungar on Pound Drum');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=0 AND `SourceEntry`=66512;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 0, 66512, 0, 18, 0, 195308, 0, 0, '', 'Pound Drum: Target Mysterious Snow Mound'),
(13, 0, 66512, 0, 18, 0, 195309, 0, 0, '', 'Pound Drum: Target Mysterious Snow Mound');
 
 
-- -------------------------------------------------------- 
-- 2011_09_11_07_world_sai.sql 
-- -------------------------------------------------------- 
-- Morbent Fel SAI
SET @ENTRY := 1200;
SET @SPELL_SACRED_CLEANSING := 8913;
SET @SPELL_TOUCH_OF_DEATH := 3108;
SET @SPELL_PRESENCE_OF_DEATH := 3109;
SET @SPELL_UNHOLY_SHIELD := 8909;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,1,0,0,0,0,11,@SPELL_UNHOLY_SHIELD,0,0,0,0,0,1,0,0,0,0,0,0,0,"Morbent Fel - Out Of Combat - Cast Unholy Shield"),
(@ENTRY,0,1,0,8,0,100,0,@SPELL_SACRED_CLEANSING,0,0,0,36,24782,0,0,0,0,0,1,0,0,0,0,0,0,0,"Morbent Fel - On Spellhit - Update Template"),
(@ENTRY,0,2,0,0,0,100,0,0,0,24000,24000,11,@SPELL_TOUCH_OF_DEATH,0,0,0,0,0,2,0,0,0,0,0,0,0,"Morbent Fel - In Combat - Cast Touch of Death"),
(@ENTRY,0,3,0,0,0,100,0,0,0,3700,13300,11,@SPELL_PRESENCE_OF_DEATH,0,0,0,0,0,2,0,0,0,0,0,0,0,"Morbent Fel - In Combat - Cast Presence of Death"),
(@ENTRY,0,4,0,2,0,100,1,0,15,0,0,28,@SPELL_UNHOLY_SHIELD,1,0,0,0,0,1,0,0,0,0,0,0,0,"Morbent Fel - At 15% HP - Remove Unholy Shield");
 
 
-- -------------------------------------------------------- 
-- 2011_09_11_08_world_creature.sql 
-- -------------------------------------------------------- 
DELETE FROM `creature` WHERE `id`=25589;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(2017,25589,571,1,1,0,0,4464.63,5378.07,-15.2737,6.05299,600,0,0,1,0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=25589;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(25589,0,1,1,0, ''); -- sitting
 
 
-- -------------------------------------------------------- 
-- 2011_09_11_09_world_script_texts.sql 
-- -------------------------------------------------------- 
DELETE FROM `script_texts` WHERE `npc_entry`=27654 AND `entry` BETWEEN -1578016 AND -1578005;
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `sound`, `type`, `comment`) VALUES
(27654, -1578005, 'The prisoners shall not go free! The word of Malygos is law!', 13594, 1, 'SAY_AGGRO'),
(27654, -1578006, 'A fitting punishment!', 13602, 1, 'SAY_KILL_1'),
(27654, -1578007, 'Sentence: executed!', 13603, 1, 'SAY_KILL_2'),
(27654, -1578008, 'Another casualty of war!', 13604, 1, 'SAY_KILL_3'),
(27654, -1578009, 'The war... goes on.', 13605, 1, 'SAY_DEATH'),
(27654, -1578010, 'It is too late to run!', 13598, 1, 'SAY_PULL_1'),
(27654, -1578011, 'Gather ''round....', 13599, 1, 'SAY_PULL_2'),
(27654, -1578012, 'None shall escape!', 13600, 1,  'SAY_PULL_3'),
(27654, -1578013, 'I condemn you to death!', 13601, 1, 'SAY_PULL_4'),
(27654, -1578014, 'Tremble, worms!', 13595, 1,  'SAY_STOMP_1'),
(27654, -1578015, 'I will crush you!', 13596, 1, 'SAY_STOMP_2'),
(27654, -1578016, 'Can you fly?', 13597, 1, 'SAY_STOMP_3');
 
 
-- -------------------------------------------------------- 
-- 2011_09_12_00_world_misc.sql 
-- -------------------------------------------------------- 
SET @Gossip=21276;
SET @Azuregos=15481; -- Spirit of Azuregos
SET @Item=20949; -- Magical Ledger
UPDATE `creature_template` SET `gossip_menu_id`=@Gossip, `AIName`='SmartAI' WHERE `entry`=@Azuregos;

DELETE FROM `gossip_menu` WHERE (`entry` BETWEEN @Gossip AND @Gossip+12) AND `text_id` IN (7881,7901,7885,7886,7887,7888,7889,7890,7891,7892,7893,7894,7895,7896,7897);
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(@Gossip+00, 7881), -- gossip if no quest nor item
(@Gossip+00, 7901), -- gossip if item
(@Gossip+00, 7885), -- 01
(@Gossip+01, 7886), -- 02
(@Gossip+02, 7887), -- 03
(@Gossip+03, 7888), -- 04
(@Gossip+04, 7889), -- 05
(@Gossip+05, 7890), -- 06
(@Gossip+06, 7891), -- 07
(@Gossip+07, 7892), -- 08
(@Gossip+08, 7893), -- 09
(@Gossip+09, 7894), -- 10
(@Gossip+10, 7895), -- 11
(@Gossip+11, 7896), -- 12
(@Gossip+12, 7897); -- 13

DELETE FROM `gossip_menu_option` WHERE `menu_id` BETWEEN @Gossip AND @Gossip + 14;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`) VALUES
(@Gossip+00,0,'How did you know? I mean, yes... Yes I am looking for that shard. Do you have it?',1,1,@Gossip+01),
(@Gossip+01,0,'Alright. Where?',1,1,@Gossip+02),
(@Gossip+02,0,'By Bronzebeard''s... um, beard! What are you talking about?',1,1,@Gossip+03),
(@Gossip+03,0,'Fish? You gave a piece of what could be the key to saving all life on Kalimdor to a fish?',1,1,@Gossip+04),
(@Gossip+04,0,'A minnow? The oceans are filled with minnows! There could be a hundred million million minnows out there!',1,1,@Gossip+05),
(@Gossip+05,0,'...',1,1,@Gossip+06),
(@Gossip+06,0,'You put the piece on a minnow and placed the minnow somewhere in the waters of the sea between here and the Eastern Kingdoms? And this minnow has special powers?',1,1,@Gossip+07),
(@Gossip+07,0,'You''re insane.',1,1,@Gossip+08),
(@Gossip+08,0,'I''m all ears.',1,1,@Gossip+09),
(@Gossip+09,0,'Come again.',1,1,@Gossip+10),
(@Gossip+10,0,'Ok, let me get this straight. You put the scepter entrusted to your Flight by Anachronos  on a minnow of your own making and now you expect me to build an... an arcanite buoy or something... to force your minnow out of hiding? AND potentially incur the wrath of an Elemental Lord? Did I miss anything? Perhaps I am to do this without any clothes on, during a solar eclipse, on a leap year?',1,1,@Gossip+11),
(@Gossip+11,0,'FINE! And how, dare I ask, am I supposed to acquire an arcanite buoy?',1,1,@Gossip+12),
(@Gossip+12,0,'But...',1,1,0);

DELETE FROM `creature_text` WHERE `entry`=@Azuregos;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(@Azuregos, 0, 0, 'I SAID GOOD BYE!', 12, 0, 100, 1, 0, 0, 'Spirit of Azuregos');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup` BETWEEN @Gossip+0 AND @Gossip+2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(14,@Gossip+0,7901,0,2,@Item,1, 'Spirit of Azuregos - show gossip 7901 if player has item Magical Ledger'),
(14,@Gossip+0,7885,0,14,8575,0, 'Spirit of Azuregos - show gossip 7885 if player does not have quest Azuregos''s Magical Ledger'),
(14,@Gossip+0,7885,0,8,8555,0, 'Spirit of Azuregos - show gossip 7885 if player has quest The Charge of the Dragonflights rewarded'),
(14,@Gossip+0,7881,0,14,8555,0, 'Spirit of Azuregos - show gossip 7881 if player does not have quest The Charge of the Dragonflights'),
(15,@Gossip+0,0,0,26,@Item,1, 'Spirit of Azuregos - show gossip option if player does not have item Magical Ledger'),
(15,@Gossip+0,0,0,14,8575,0, 'Spirit of Azuregos - show gossip option if player does not have quest Azuregos''s Magical Ledger'),
(15,@Gossip+0,0,0,8,8555,0, 'Spirit of Azuregos - show gossip option if player has quest The Charge of the Dragonflights rewarded');

DELETE FROM `smart_scripts` WHERE `entryorguid`=@Azuregos AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@Azuregos, 0, 0, 0, 62, 0, 100, 0, @Gossip+11, 0, 0, 0, 56, @Item, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Azuregos - On gossip select 11 give item'),
(@Azuregos, 0, 1, 2, 62, 0, 100, 0, @Gossip+12, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Azuregos - On gossip select 12 close gossip'),
(@Azuregos, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Azuregos - Link 2 say');

-- Not related
UPDATE `game_event` SET `start_time`='2011-12-04 00:01:00' WHERE `eventEntry`=4;
 
 
-- -------------------------------------------------------- 
-- 2011_09_12_01_world_misc.sql 
-- -------------------------------------------------------- 
SET @GUID = 209102;

-- add creatures
DELETE FROM `creature` WHERE `id` IN (28601, 28602) AND `map`=1;
INSERT INTO `creature` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@GUID+00,28601, 1, -6027.13, -1249.12, -146.765, 0.0407544),
(@GUID+01,28602, 1, -6165.74, -1250.34, -162.183, 3.16428),
(@GUID+02,28602, 1, -6118.16, -1258.77, -143.281, 3.17606),
(@GUID+03,28602, 1, -6118.18, -1241.33, -143.281, 3.12169),
(@GUID+04,28602, 1, -6104.87, -1256.41, -143.281, 3.04315),
(@GUID+05,28602, 1, -6104.56, -1243.58, -143.281, 3.07064),
(@GUID+06,28602, 1, -6067.35, -1243.76, -143.481, 3.17274),
(@GUID+07,28602, 1, -6067.17, -1255.45, -143.430, 3.15703),
(@GUID+08,28602, 1, -6038.16, -1243.56, -146.897, 3.15153),
(@GUID+09,28602, 1, -6036.82, -1255.32, -146.901, 3.19238),
(@GUID+10,28602, 1, -6042.26, -1249.25, -146.887, 3.19238);

-- add weapons to creatures
DELETE FROM `creature_equip_template` WHERE `entry`=2476;
INSERT INTO `creature_equip_template` VALUES 
(2476, 7714, 0, 0);

-- correct creature_template
UPDATE `creature_template` SET `faction_A` = 2080, `faction_H` = 2080, `lootid` = `entry` WHERE `entry` IN (28601, 28602);
UPDATE `creature_template` SET `equipment_id` = 1803 WHERE `entry`=28601;
UPDATE `creature_template` SET `equipment_id` = 2476 WHERE `entry`=28601;

-- create questloot
DELETE FROM `creature_loot_template` WHERE `entry`=28601;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(28601, 38708, -100, 1, 0, 1, 1);
 
 
-- -------------------------------------------------------- 
-- 2011_09_12_02_world_instance_template.sql 
-- -------------------------------------------------------- 
UPDATE `instance_template` SET `allowMount`=1 WHERE `map`=531; -- Allow mount in AQ40
UPDATE `instance_template` SET `allowMount`=1 WHERE `map`=631; -- Allow mount in ICC
 
 
-- -------------------------------------------------------- 
-- 2011_09_12_03_world_conditions.sql 
-- -------------------------------------------------------- 
-- Fix to Spell targets for Ignis adds
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=62343;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=62488;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,62343,0,18,1,33121,0,0, '', 'Heat to Iron Construct'),
(13,0,62488,0,18,1,33121,0,0, '', 'Activate Construct to iron Construct');
 
-- Burn Secondary Effect from Vehicles
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=65044;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,65044,1,18,1,34234,0,0, '', 'Flames to Runeforged Sentry'),
(13,0,65044,2,18,1,33236,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65044,3,18,1,33572,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65044,4,18,1,33237,0,0, '', 'Flames to Ulduar Colossus'),
(13,0,65044,5,18,1,33189,0,0, '', 'Flames to Liquid pyrite'),
(13,0,65044,6,18,1,33090,0,0, '', 'Flames to Pool of Tar'),
(13,0,65044,7,18,1,34161,0,0, '', 'Flames to Mechanostriker 54-A');
 
-- Burn Secondary Effect from Vehicles
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=65045;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,65045,1,18,1,34234,0,0, '', 'Flames to Runeforged Sentry'),
(13,0,65045,2,18,1,33236,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65045,3,18,1,33572,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65045,4,18,1,33237,0,0, '', 'Flames to Ulduar Colossus'),
(13,0,65045,5,18,1,33189,0,0, '', 'Flames to Liquid pyrite'),
(13,0,65045,6,18,1,33090,0,0, '', 'Flames to Pool of Tar'),
(13,0,65045,7,18,1,34161,0,0, '', 'Flames to Mechanostriker 54-A');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=62911;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,62911,0,18,1,33365,0,0, '', 'Thorim\'s Hammer to Thorim\'s Hammer');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=62906;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,62906,0,18,1,33367,0,0, '', 'Freya\'s Ward to Freya\'s Ward');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=62705;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,62705,1,18,1,33060,0,0, '', 'Auto-repair to Salvaged Siege Engine'),
(13,0,62705,2,18,1,33067,0,0, '', 'Auto-repair to Salvaged Siege Turret'),
(13,0,62705,3,18,1,33062,0,0, '', 'Auto-repair to Salvaged Chopper'),
(13,0,62705,4,18,1,33109,0,0, '', 'Auto-repair to Salvaged Demolisher'),
(13,0,62705,5,18,1,33167,0,0, '', 'Auto-repair to Salvaged Demolisher Mechanic Seat');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=63294;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,63294,0,18,1,33367,0,0, '', 'Freya Dummy Blue to Freya\'s Ward');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=63295;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,63295,0,18,1,33367,0,0, '', 'Freya Dummy Green to Freya\'s Ward');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=63292;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,63292,0,18,1,33367,0,0, '', 'Freya Dummy Yellow to Freya\'s Ward');
 
 
-- -------------------------------------------------------- 
-- 2011_09_12_04_world_creature_template.sql 
-- -------------------------------------------------------- 
-- Template updates
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`&~8 WHERE `entry`=33059; -- Wrecked Demolisher
UPDATE `creature_template` SET `exp`=0 WHERE `entry`=33666; -- Demolisher Engineer Blastwrench
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`&~8 WHERE `entry`=33063; -- Wrecked Siege Engine
UPDATE `creature_template` SET `npcflag`=`npcflag`|16777216 WHERE `entry`=33067; -- Salvaged Siege Turret
UPDATE `creature_template` SET `VehicleId`=387 WHERE `entry`=33113; -- Flame Leviathan
UPDATE `creature_template` SET `exp`=0 WHERE `entry`=33143; -- Overload Control Device
UPDATE `creature_template` SET `exp`=0,`npcflag`=`npcflag`|16777216,`unit_flags`=`unit_flags`|33571584 WHERE `entry`=33139; -- Flame Leviathan Turret
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`|12 WHERE `entry`=33216; -- Mechagnome Pilot
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`|12 WHERE `entry`=33572; -- Steelforged Defender
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33280 WHERE `entry`=33186; -- Razorscale
UPDATE `creature_template` SET `speed_run`=2.14286 WHERE `entry`=34120; -- Brann's Flying Machine
UPDATE `creature_template` SET `speed_walk`=1.6,`speed_run`=1.42857 WHERE `entry`=33118; -- Ignis the Furnace Master
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554688 WHERE `entry`=33121; -- Iron Construct
 
-- Model data
UPDATE `creature_model_info` SET `bounding_radius`=5,`combat_reach`=1,`gender`=2 WHERE `modelid`=25870; -- Salvaged Chopper
UPDATE `creature_model_info` SET `bounding_radius`=0.6,`combat_reach`=1,`gender`=1 WHERE `modelid`=28787; -- Razorscale
UPDATE `creature_model_info` SET `bounding_radius`=0.62,`combat_reach`=1,`gender`=0 WHERE `modelid`=29185; -- Ignis the Furnace Master
 
-- Addon data
DELETE FROM `creature_template_addon` WHERE `entry` IN (33114,33142,33143,33139,33189,33216,33572,33090,33186,33287,33259,34120,
23033,34086,33118,33210,33121,34085,33816);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(33114,0,0,257,0, NULL), -- Flame Leviathan Seat
(33142,0,0,1,0, NULL), -- Leviathan Defense Turret
(33143,0,0,1,0, NULL), -- Overload Control Device
(33139,0,0,1,0, NULL), -- Flame Leviathan Turret
(33189,0,0,1,0, NULL), -- Liquid Pyrite
(33216,0,0,1,0, NULL), -- Mechagnome Pilot
(33572,0,0,1,0, NULL), -- Steelforged Defender
(33090,0,0,1,0, NULL),-- Pool of Tar
(33186,0,50331648,1,0, NULL), -- Razorscale
(33816,0,0,1,375, NULL), -- Expedition Defender
(33287,0,0,1,0, NULL), -- Expedition Engineer
(33259,0,0,1,375, NULL), -- Expedition Trapper
(34120,0,50331648,1,0, NULL), -- Brann's Flying Machine
(23033,0,0,1,0, NULL), -- Invisible Stalker (Floating)
(34086,0,33554432,1,0, NULL), -- Magma Rager
(33118,0,0,1,0, NULL), -- Ignis the Furnace Master
(33210,0,0,1,0, NULL), -- Expedition Commander
(33121,0,0,1,0, NULL), -- Iron Construct
(34085,0,0,1,0, NULL); -- Forge Construct
 
 
-- -------------------------------------------------------- 
-- 2011_09_12_05_world_misc.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_dbc` WHERE `Id`=37794;
INSERT INTO `spell_dbc` (`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`AttributesEx7`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`)VALUES
(37794,0,0,384,0,0,1048576,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,21,1,0,-1,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,0,16963,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,'Transform Infernal');

-- Template updates
UPDATE `creature_template` SET `unit_flags`=0,`AIName`='SmartAI' WHERE `entry`=21419; -- Infernal Attacker
UPDATE `creature_model_info` SET `bounding_radius`=1.3545,`combat_reach`=3,`gender`=2 WHERE `modelid`=20577; -- Infernal Attacker
UPDATE `creature_template_addon` SET `bytes1`=0,`bytes2`=1,`mount`=0,`emote`=0,`auras`=NULL WHERE `entry`=21419; -- Infernal Attacker

DELETE FROM `smart_scripts` WHERE `entryorguid`=21419 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(21419, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 37794, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infernal Attacker - On spawn cast Transform Infernal on self');
 
 
-- -------------------------------------------------------- 
-- 2011_09_12_06_world_event_scripts.sql 
-- -------------------------------------------------------- 
DELETE FROM `event_scripts` WHERE `id` IN (16929,17084);
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
-- H
(16929, 3, 10, 25742, 360000, 0, 3533.64, 4535.52, -12.9953, 3.47514), -- Alluvion
(16929, 10, 8, 25742, 0, 0, 0, 0, 0, 0), -- KC
(16929, 3, 10, 25629, 360000, 0, 3511.96, 4527.18, -12.9949, 0.357893), -- Kryxix
-- A
(17084, 3, 10, 25794, 360000, 0, 3533.64, 4535.52, -12.9953, 3.47514), -- Shake-n-Quake 5000
(17084, 10, 8, 25794, 0, 0, 0, 0, 0, 0), -- KC
(17084, 3, 10, 25629, 360000, 0, 3511.96, 4527.18, -12.9949, 0.357893); -- Kryxix
 
 
-- -------------------------------------------------------- 
-- 2011_09_12_07_world_creature.sql 
-- -------------------------------------------------------- 
UPDATE `creature` SET `spawnMask`=1 WHERE `guid` IN (1102,85587) AND `id` IN (22237,17318);
DELETE FROM `game_event_creature` WHERE `eventEntry`=7 AND `guid`=1102;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(7,1102); -- Loirea Galerunner - Lunar Festival
 
 
-- -------------------------------------------------------- 
-- 2011_09_13_00_world_spells.sql 
-- -------------------------------------------------------- 
-- Fix Startup Errors
UPDATE `creature_template` SET `exp`=0,`npcflag`=`npcflag`|16777216,`unit_flags`=`unit_flags`|33571584 WHERE `entry`=34111;
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (33139,34111);
INSERT INTO `npc_spellclick_spells`(`npc_entry`,`spell_id`,`quest_start`,`quest_start_active`,`quest_end`,`cast_flags`,`aura_required`,`aura_forbidden`,`user_type`) VALUES
(34111,46598,0,0,0,1,0,0,0),
(33139,46598,0,0,0,1,0,0,0);
 
-- Added Burn to Vehicles for Hard mode Mechanics
-- Thanks to horn for the reminder
-- Burn Secondary Effect from Vehicles
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (65044,65045);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,65044,1,18,1,34234,0,0, '', 'Flames to Runeforged Sentry'),
(13,0,65044,2,18,1,33236,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65044,3,18,1,33572,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65044,4,18,1,33237,0,0, '', 'Flames to Ulduar Colossus'),
(13,0,65044,5,18,1,33189,0,0, '', 'Flames to Liquid pyrite'),
(13,0,65044,6,18,1,33090,0,0, '', 'Flames to Pool of Tar'),
(13,0,65044,7,18,1,34161,0,0, '', 'Flames to Mechanostriker 54-A'),
(13,0,65044,8,18,1,33062,0,0, '', 'Flames to Salvaged Chopper'),
(13,0,65044,9,18,1,34045,0,0, '', 'Flames to Salvaged Chopper'),
(13,0,65044,10,18,1,33109,0,0, '', 'Flames to Salvaged Demolisher'),
(13,0,65044,11,18,1,33060,0,0, '', 'Flames to Salvaged Salvaged Siege Engine'),
-- Burn Secondary Effect from Vehicles
(13,0,65045,1,18,1,34234,0,0, '', 'Flames to Runeforged Sentry'),
(13,0,65045,2,18,1,33236,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65045,3,18,1,33572,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65045,4,18,1,33237,0,0, '', 'Flames to Ulduar Colossus'),
(13,0,65045,5,18,1,33189,0,0, '', 'Flames to Liquid pyrite'),
(13,0,65045,6,18,1,33090,0,0, '', 'Flames to Pool of Tar'),
(13,0,65045,7,18,1,34161,0,0, '', 'Flames to Mechanostriker 54-A'),
(13,0,65045,8,18,1,33062,0,0, '', 'Flames to Salvaged Chopper'),
(13,0,65045,9,18,1,34045,0,0, '', 'Flames to Salvaged Chopper'),
(13,0,65045,10,18,1,33109,0,0, '', 'Flames to Salvaged Demolisher'),
(13,0,65045,11,18,1,33060,0,0, '', 'Flames to Salvaged Salvaged Siege Engine');
 
 
-- -------------------------------------------------------- 
-- 2011_09_14_00_world_spawns.sql 
-- -------------------------------------------------------- 
SET @GUID = 209113;
DELETE FROM `creature` WHERE `id` IN (30395,30446,30450,30454);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`) VALUES
(@GUID+00, 30395, 571, 1, 1, 8348.89, -2509.48, 1147.37, 3.7001, 120, 0),
(@GUID+01, 30446, 571, 1, 1, 8253.4, -2566.37, 1149.7, 0.0698132, 120, 0),
(@GUID+02, 30446, 571, 1, 1, 8281.26, -2612.78, 1150.66, 0.349066, 120, 0),
(@GUID+03, 30446, 571, 1, 1, 8283.91, -2585.09, 1149.51, 5.00909, 120, 0),
(@GUID+04, 30446, 571, 1, 1, 8300.43, -2564.86, 1153.59, 0.261799, 120, 0),
(@GUID+05, 30446, 571, 1, 1, 8310.22, -2550.68, 1153.69, 1.91986, 120, 0),
(@GUID+06, 30446, 571, 1, 1, 8331.42, -2502.39, 1140.05, 4.53786, 120, 0),
(@GUID+07, 30446, 571, 1, 1, 8354.63, -2549.88, 1148.54, 4.95674, 120, 0),
(@GUID+08, 30446, 571, 1, 1, 8361.87, -2526.85, 1141.39, 3.68264, 120, 0),
(@GUID+09, 30446, 571, 1, 1, 8382.5, -2549.35, 1145.97, 3.82227, 120, 0),
(@GUID+10, 30446, 571, 1, 1, 8393.97, -2540.06, 1131.91, 5.07891, 120, 0),
(@GUID+24, 30454, 571, 1, 1, 8289.31, -2602.48, 1151.42, 1.95477, 120, 0),
(@GUID+25, 30454, 571, 1, 1, 8294.61, -2589.08, 1150.63, 1.39626, 120, 0),
(@GUID+26, 30454, 571, 1, 1, 8300.51, -2596.84, 1151.87, 3.9619, 120, 0),
(@GUID+27, 30454, 571, 1, 1, 8303.38, -2521.44, 1154.39, 5.07891, 120, 0),
(@GUID+28, 30454, 571, 1, 1, 8312.52, -2561.31, 1152.03, 4.72984, 120, 0),
(@GUID+29, 30454, 571, 1, 1, 8314.11, -2500.82, 1143.3, 1.6057, 120, 0),
(@GUID+30, 30454, 571, 1, 1, 8317.65, -2573.94, 1151.43, 3.03687, 120, 0),
(@GUID+31, 30454, 571, 1, 1, 8336.79, -2502.89, 1133.36, 5.41052, 120, 0),
(@GUID+32, 30454, 571, 1, 1, 8342.26, -2505.45, 1134.28, 4.01426, 120, 0),
(@GUID+33, 30454, 571, 1, 1, 8351.38, -2508.96, 1135.07, 0.244346, 120, 0),
(@GUID+34, 30454, 571, 1, 1, 8381.3, -2529.69, 1133.36, 4.62512, 120, 0),
(@GUID+35, 30454, 571, 1, 1, 8387.79, -2527.25, 1135.03, 4.53786, 120, 0),
(@GUID+36, 30454, 571, 1, 1, 8393.11, -2548.1, 1143.71, 1.72788, 120, 0),
(@GUID+37, 30454, 571, 1, 1, 8398.62, -2526.46, 1134.62, 3.80482, 120, 0),
(@GUID+38, 30454, 571, 1, 1, 8401.63, -2539.44, 1132.53, 1.39626, 120, 0),
(@GUID+39, 30454, 571, 1, 1, 8406.36, -2532.98, 1131.75, 2.04204, 120, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(@GUID+11, 30450, 571, 1, 1, 8259.18, -2570.82, 1149.61, 1.56682, 120, 5, 1),
(@GUID+12, 30450, 571, 1, 1, 8264.03, -2566.79, 1149.61, 2.96147, 120, 5, 1),
(@GUID+13, 30450, 571, 1, 1, 8284.46, -2601.7, 1150.49, 5.66794, 120, 5, 1),
(@GUID+14, 30450, 571, 1, 1, 8292.88, -2572.04, 1146.46, 1.3252, 120, 5, 1),
(@GUID+15, 30450, 571, 1, 1, 8298.51, -2592.29, 1150.48, 0.513648, 120, 5, 1),
(@GUID+16, 30450, 571, 1, 1, 8306.36, -2524.83, 1152.22, 2.29176, 120, 5, 1),
(@GUID+17, 30450, 571, 1, 1, 8313.22, -2565.91, 1150.88, 0.739577, 120, 5, 1),
(@GUID+18, 30450, 571, 1, 1, 8334.5, -2519.78, 1138.3, 5.60389, 120, 5, 1),
(@GUID+19, 30450, 571, 1, 1, 8336.27, -2512.15, 1135.11, 3.55008, 120, 5, 1),
(@GUID+20, 30450, 571, 1, 1, 8350.84, -2544.52, 1147.52, 5.8518, 120, 5, 1),
(@GUID+21, 30450, 571, 1, 1, 8365.42, -2533.72, 1132.69, 5.61117, 120, 5, 1),
(@GUID+22, 30450, 571, 1, 1, 8377.27, -2545.82, 1140.66, 2.91336, 120, 5, 1),
(@GUID+23, 30450, 571, 1, 1, 8396.34, -2529.92, 1131.82, 1.30778, 120, 5, 1);

UPDATE `creature_template` SET `npcflag`=3,`gossip_menu_id`=9906 WHERE `entry`=30395; -- Chieftain Swiftspear
UPDATE `creature_template` SET `InhabitType`=7 WHERE `entry`=30446; -- Frostfloe Rift
UPDATE `creature_template` SET `MovementType`=1 WHERE `entry`=30450; -- Wailing Winds
UPDATE `creature_template` SET `InhabitType`=7,`flags_extra`=`flags_extra`|128 WHERE `entry`=30454; -- Frostfloe Deep Stalker

UPDATE `creature_model_info` SET `bounding_radius`=0.6076385,`combat_reach`=2.625,`gender`=0 WHERE `modelid`=27004; -- Chieftain Swiftspear
UPDATE `creature_model_info` SET `bounding_radius`=0.5,`combat_reach`=1,`gender`=2 WHERE `modelid`=27617; -- Wailing Winds

DELETE FROM `creature_template_addon` WHERE `entry` IN (30395,30446,30450,30454);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(30395,0,0,1,0, NULL), -- Chieftain Swiftspear
(30446,0,0x3000000,1,0, NULL), -- Frostfloe Rift
(30450,0,0,1,0, NULL), -- Wailing Winds
(30454,0,0x3000000,1,0, NULL); -- Frostfloe Deep Stalker

DELETE FROM `gossip_menu` WHERE `entry`=9906 AND `text_id`=13776;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(9906, 13776);
 
 
-- -------------------------------------------------------- 
-- 2011_09_14_01_world_quest.sql 
-- -------------------------------------------------------- 
-- Quest 12983 "Last of Her Kind"

-- Add Injured Icemaw Matriarch
DELETE FROM `creature` WHERE `id`=29563;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(152124,29563,571,1,1,0,0,7335.381,-2055.097,764.3585,3.368485,120,0,0,1,0,0,0,0,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|16777216 WHERE `entry`=29563; -- Injured Icemaw Matriarch
-- SAI for Harnessed Icemaw Matriarch
SET @ENTRY := 30468;
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=35, `faction_H`=35 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,27,0,100,0,0,0,0,0,53,1,@ENTRY,0,12983,0,0,1,0,0,0,0,0,0,0, 'Harnessed Icemaw Matriarch - On Passenger - Start WP movement'),
(@ENTRY,0,1,0,40,0,100,0,1,@ENTRY,0,0,18,130,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Harnessed Icemaw Matriarch - Reach Waypoint - Make Unatackable'),
(@ENTRY,0,2,0,40,0,100,0,50,@ENTRY,0,0,33,29563,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Harnessed Icemaw Matriarch - Reach Waypoint - Quest Credit'),
(@ENTRY,0,3,0,40,0,100,0,51,@ENTRY,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Harnessed Icemaw Matriarch - Reach Waypoint - Despawn');
-- Waypoints for Harnessed Icemaw Matriarch
DELETE FROM `waypoints` WHERE `entry`=30468;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(30468,1,7339.617,-2058.659,764.919,'Harnessed Icemaw Matriarch'),
(30468,2,7338.267,-2064.381,765.3577,'Harnessed Icemaw Matriarch'),
(30468,3,7335.772,-2073.805,767.4077,'Harnessed Icemaw Matriarch'),
(30468,4,7327.591,-2087.35,770.8978,'Harnessed Icemaw Matriarch'),
(30468,5,7319.448,-2095.41,773.6814,'Harnessed Icemaw Matriarch'),
(30468,6,7305.165,-2107.299,774.3261,'Harnessed Icemaw Matriarch'),
(30468,7,7275.178,-2114.627,775.6678,'Harnessed Icemaw Matriarch'),
(30468,8,7258.999,-2116.149,778.5131,'Harnessed Icemaw Matriarch'),
(30468,9,7241.648,-2119.356,777.7652,'Harnessed Icemaw Matriarch'),
(30468,10,7226.729,-2115.936,777.3341,'Harnessed Icemaw Matriarch'),
(30468,11,7208.441,-2115.223,770.9512,'Harnessed Icemaw Matriarch'),
(30468,12,7198.355,-2115.354,767.3314,'Harnessed Icemaw Matriarch'),
(30468,13,7193.219,-2115.251,765.6339,'Harnessed Icemaw Matriarch'),
(30468,14,7188.855,-2117.307,763.8766,'Harnessed Icemaw Matriarch'),
(30468,15,7177.065,-2123.511,762.9337,'Harnessed Icemaw Matriarch'),
(30468,16,7163.708,-2131.039,762.1168,'Harnessed Icemaw Matriarch'),
(30468,17,7146.599,-2130.739,762.0986,'Harnessed Icemaw Matriarch'),
(30468,18,7127.765,-2130.799,760.3064,'Harnessed Icemaw Matriarch'),
(30468,19,7130.188,-2108.955,761.6824,'Harnessed Icemaw Matriarch'),
(30468,20,7122.738,-2087.617,763.7275,'Harnessed Icemaw Matriarch'),
(30468,21,7114.396,-2070.318,765.9775,'Harnessed Icemaw Matriarch'),
(30468,22,7101.815,-2051.608,765.8251,'Harnessed Icemaw Matriarch'),
(30468,23,7091.483,-2031.099,765.8953,'Harnessed Icemaw Matriarch'),
(30468,24,7087.403,-2012.366,767.2703,'Harnessed Icemaw Matriarch'),
(30468,25,7081.406,-1985.07,767.9617,'Harnessed Icemaw Matriarch'),
(30468,26,7073.832,-1961.028,769.3597,'Harnessed Icemaw Matriarch'),
(30468,27,7068.839,-1934.135,775.7347,'Harnessed Icemaw Matriarch'),
(30468,28,7064.366,-1916.702,781.6978,'Harnessed Icemaw Matriarch'),
(30468,29,7070.385,-1906.559,785.4976,'Harnessed Icemaw Matriarch'),
(30468,30,7079.504,-1899.025,787.0339,'Harnessed Icemaw Matriarch'),
(30468,31,7085.339,-1887.627,788.9089,'Harnessed Icemaw Matriarch'),
(30468,32,7067.585,-1884.709,793.0339,'Harnessed Icemaw Matriarch'),
(30468,33,7041.699,-1884.614,797.4276,'Harnessed Icemaw Matriarch'),
(30468,34,7029.2,-1871.599,803.4189,'Harnessed Icemaw Matriarch'),
(30468,35,7025.071,-1858.876,811.2399,'Harnessed Icemaw Matriarch'),
(30468,36,7018.791,-1838.968,820.2399,'Harnessed Icemaw Matriarch'),
(30468,37,7011.697,-1814.383,820.7299,'Harnessed Icemaw Matriarch'),
(30468,38,7009.096,-1791.501,820.7303,'Harnessed Icemaw Matriarch'),
(30468,39,7017.041,-1758.968,819.6544,'Harnessed Icemaw Matriarch'),
(30468,40,7013.258,-1723.917,819.8597,'Harnessed Icemaw Matriarch'),
(30468,41,6995.103,-1720.753,820.1116,'Harnessed Icemaw Matriarch'),
(30468,42,6975.483,-1722.112,820.7366,'Harnessed Icemaw Matriarch'),
(30468,43,6959.883,-1724.389,820.5955,'Harnessed Icemaw Matriarch'),
(30468,44,6941.025,-1720.429,820.5955,'Harnessed Icemaw Matriarch'),
(30468,45,6920.026,-1709.558,820.7527,'Harnessed Icemaw Matriarch'),
(30468,46,6902.995,-1697.53,820.6683,'Harnessed Icemaw Matriarch'),
(30468,47,6886.746,-1682.953,820.2584,'Harnessed Icemaw Matriarch'),
(30468,48,6867.681,-1684.361,819.8834,'Harnessed Icemaw Matriarch'),
(30468,49,6847.065,-1695.642,819.9857,'Harnessed Icemaw Matriarch'),
(30468,50,6824.819,-1701.835,820.6398,'Harnessed Icemaw Matriarch'),
(30468,51,6824.819,-1701.835,820.5497,'Harnessed Icemaw Matriarch');

-- Phasing Spell
DELETE FROM `spell_area` WHERE `spell`=55857 AND `area`=4455;
INSERT INTO `spell_area`(`spell`,`area`,`quest_start`,`quest_start_active`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`) VALUES 
(55857,4455,12983,1,12983,0,0,2,1);

-- From Nay:
-- TODO: Respawn the whole cave, lots of shit wrong (phasemasks etc)
UPDATE `creature` SET `phaseMask`=2 WHERE `id`=29563;
DELETE FROM `creature_template_addon` WHERE `entry`=30468;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(30468,0,0,1,0, NULL); -- Harnessed Icemaw Matriarch
 
 
-- -------------------------------------------------------- 
-- 2011_09_14_02_world_gossip_menu_option.sql 
-- -------------------------------------------------------- 
UPDATE `gossip_menu_option` SET `option_text`='I seem to have misplaced my Zandalar Madcap''s Mantle. Can you help?' WHERE `menu_id`=21270 AND `id`=0; -- It said: "...Zandalar Madcap's Belt." (Wrong name, that item doesn't exist)
UPDATE `gossip_menu_option` SET `option_text`='I seem to have misplaced my Zandalar Predator''s Mantle. Can you help?' WHERE `menu_id`=21271 AND `id`=2; -- It said: "...Zandalar Predator's Tunic." (Wrong name, that item doesn't exist)
UPDATE `gossip_menu_option` SET `option_text`='I seem to have misplaced my Maelstrom''s Tendril. Can you help?' WHERE `menu_id`=21271 AND `id`=4; -- It said: "... Malestrom's Tendril." (Typo)
UPDATE `gossip_menu_option` SET `option_text`='I seem to have misplaced my Maelstrom''s Tendril. Can you help?' WHERE `menu_id`=21271 AND `id`=5; -- It said: "... Malestrom's Tendril." (Typo)
UPDATE `gossip_menu_option` SET `option_text`='I seem to have misplaced my Maelstrom''s Tendril. Can you help?' WHERE `menu_id`=21271 AND `id`=6; -- It said: "... Malestrom's Tendril." (Typo)
UPDATE `smart_scripts` SET `comment`='Falthir the Sightless - On gossip select 2 give item Zandalar Madcap''s Mantle' WHERE `entryorguid`=14905 AND `id`=2; -- It said: "...Zandalar Augur''s Belt" (Wrong name, that item doesn't correspond with rouge class)
 
 
-- -------------------------------------------------------- 
-- 2011_09_14_03_world_script_texts.sql 
-- -------------------------------------------------------- 
-- Quest: Tomb of the Lightbringer, make Anchorite Truuen speak Common not Draconic
UPDATE `script_texts` SET `language`=7 WHERE `comment` LIKE 'npc_anchorite_truuen%' AND `language`=11;
 
 
-- -------------------------------------------------------- 
-- 2011_09_14_04_world_creature.sql 
-- -------------------------------------------------------- 
SET @GUID=209153;
DELETE FROM `creature` WHERE `id`=29413;
INSERT INTO `creature` (`guid` ,`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES
(@GUID+0, 29413, 571, 1, 1, 0, 0, 6471.48, -1658.6, 432.644, 5.41462, 600, 0, 0, 1, 0, 0),
(@GUID+1, 29413, 571, 1, 1, 0, 0, 6477.3, -1651.6, 430.185, 5.4107, 600, 0, 0, 1, 0, 0),
(@GUID+2, 29413, 571, 1, 1, 0, 0, 6492.54, -1648.41, 429.39, 5.2222, 600, 0, 0, 1, 0, 0),
(@GUID+3, 29413, 571, 1, 1, 0, 0, 6512.8, -1621.17, 428.168, 6.19609, 600, 0, 0, 1, 0, 0),
(@GUID+4, 29413, 571, 1, 1, 0, 0, 6489.6, -1624.66, 428.328, 2.01384, 600, 0, 0, 1, 0, 0),
(@GUID+5, 29413, 571, 1, 1, 0, 0, 6426.13, -1605.26, 422.576, 1.22452, 600, 0, 0, 1, 0, 0),
(@GUID+6, 29413, 571, 1, 1, 0, 0, 6430.89, -1604.5, 423.222, 0.949627, 600, 0, 0, 1, 0, 0),
(@GUID+7, 29413, 571, 1, 1, 0, 0, 6386.45, -1599.39, 420.724, 2.33193, 600, 0, 0, 1, 0, 0),
(@GUID+8, 29413, 571, 1, 1, 0, 0, 6375.45, -1593.56, 425.553, 1.04387, 600, 0, 0, 1, 0, 0),
(@GUID+9, 29413, 571, 1, 1, 0, 0, 6696.47, -998.844, 415.433, 2.83458, 600, 0, 0, 1, 0, 0),
(@GUID+10, 29413, 571, 1, 1, 0, 0, 6630.7, -1004.17, 424.376, 2.72462, 600, 0, 0, 1, 0, 0),
(@GUID+11, 29413, 571, 1, 1, 0, 0, 6612.56, -1017.17, 427.344, 3.38043, 600, 0, 0, 1, 0, 0),
(@GUID+12, 29413, 571, 1, 1, 0, 0, 6594.54, -1017.6, 429.443, 2.02955, 600, 0, 0, 1, 0, 0),
(@GUID+13, 29413, 571, 1, 1, 0, 0, 6578.55, -982.887, 434.147, 5.99973, 600, 0, 0, 1, 0, 0),
(@GUID+14, 29413, 571, 1, 1, 0, 0, 6580.09, -997.177, 434.919, 5.56384, 600, 0, 0, 1, 0, 0),
(@GUID+15, 29413, 571, 1, 1, 0, 0, 6596.23, -1008.78, 429.445, 5.69736, 600, 0, 0, 1, 0, 0),
(@GUID+16, 29413, 571, 1, 1, 0, 0, 6594.65, -1049.05, 430.103, 2.46544, 600, 0, 0, 1, 0, 0),
(@GUID+17, 29413, 571, 1, 1, 0, 0, 6570.9, -1050.44, 432.848, 3.76527, 600, 0, 0, 1, 0, 0),
(@GUID+18, 29413, 571, 1, 1, 0, 0, 6533.12, -1075.28, 432.917, 1.53867, 600, 0, 0, 1, 0, 0),
(@GUID+19, 29413, 571, 1, 1, 0, 0, 6536.16, -1078.86, 433.175, 1.54652, 600, 0, 0, 1, 0, 0),
(@GUID+20, 29413, 571, 1, 1, 0, 0, 6536.22, -1076.53, 433.014, 1.54652, 600, 0, 0, 1, 0, 0),
(@GUID+21, 29413, 571, 1, 1, 0, 0, 6534.27, -1076.49, 432.958, 1.54652, 600, 0, 0, 1, 0, 0),
(@GUID+22, 29413, 571, 1, 1, 0, 0, 6534.71, -1073.77, 432.928, 1.54652, 600, 0, 0, 1, 0, 0),
(@GUID+23, 29413, 571, 1, 1, 0, 0, 6538.16, -1076.95, 433.1, 1.55438, 600, 0, 0, 1, 0, 0),
(@GUID+24, 29413, 571, 1, 1, 0, 0, 6536.77, -1073.94, 432.995, 1.46013, 600, 0, 0, 1, 0, 0),
(@GUID+25, 29413, 571, 1, 1, 0, 0, 6538.6, -1075.64, 433.11, 1.49155, 600, 0, 0, 1, 0, 0),
(@GUID+26, 29413, 571, 1, 1, 0, 0, 6621.56, -1078.08, 415.032, 1.05174, 600, 5, 0, 1, 0, 1),
(@GUID+27, 29413, 571, 1, 1, 0, 0, 6641.11, -1093.62, 402.801, 1.36196, 600, 0, 0, 1, 0, 0),
(@GUID+28, 29413, 571, 1, 1, 0, 0, 6610.29, -1279.72, 394.475, 3.31761, 600, 0, 0, 1, 0, 0),
(@GUID+29, 29413, 571, 1, 1, 0, 0, 6599.47, -1270.63, 394.829, 1.10278, 600, 0, 0, 1, 0, 0);

-- Nay:
UPDATE `creature_template_addon` SET `bytes1`=0,`bytes2`=1,`mount`=0,`emote`=233,`auras`=NULL WHERE `entry`=29413;
UPDATE `creature_model_info` SET `bounding_radius`=0.31,`combat_reach`=0,`gender`=0 WHERE `modelid`=27173;
-- Not sure if all  of them should have the emote, check this later.
 
 
-- -------------------------------------------------------- 
-- 2011_09_14_05_world_creature_text.sql 
-- -------------------------------------------------------- 
UPDATE `creature_text` SET `sound`=16825 WHERE `entry`=37129 AND `groupid`=5 AND `id`=0;
 
 
-- -------------------------------------------------------- 
-- 2011_09_14_06_world_creature_template.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`
|1 -- CHARM
|2 -- DISORIENTED
|4 -- DISARM
|8 -- DISTRACT
|16 -- FEAR
|32 -- GRIP
|64 -- ROOT
|128 -- PACIFY
|256 -- SILENCE
|512 -- SLEEP
|1024 -- SNARE
|2048 -- STUN
|4096 -- FREEZE
|8192 -- KNOCKOUT
|65536 -- POLYMORPH
|131072 -- BANISH
|524288 -- SHACKLE
|4194304 -- TURN
|8388608 -- HORROR
|67108864 -- DAZE
|536870912 -- SAPPED
WHERE `entry` IN
(36597,39166,39167,39168, -- The Lich King
36612,37957,37958,37959, -- Lord Marrowgar
36626,37504,37505,37506, -- Festergut
36627,38390,38549,38550, -- Rotface
36678,38431,38585,38586, -- Professor Putricide
36853,38265,38266,38267, -- Sindragosa
36855,38106,38296,38297, -- Lady Deathwhisper
37813,38402,38582,38583, -- Deathbringer Saurfang
37955,38434,38435,38436, -- Blood-Queen Lana'thel
37970,38401,38784,38785,  -- Prince Valanar
37972,38399,38769,38770, -- Prince Keseleth
37973,38400,38771,38772); -- Prince Taldaram

UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~2097152 /* INFECTED */ WHERE `entry` IN 
(36626,37504,37505,37506,-- Festergut
36627,38390,38549,38550, -- Rotface
36678,38431,38585,38586); -- Professor Putricide
 
 
-- -------------------------------------------------------- 
-- 2011_09_15_00_world_creature.sql 
-- -------------------------------------------------------- 
-- Remove spawns of Perimeter Bunny - they are spawned by spell 54355 used by GO 191502 (Land Mine) 
DELETE FROM `creature` WHERE `id`=29397; 
 
 
-- -------------------------------------------------------- 
-- 2011_09_15_01_world_creature_template.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `scale`=1 WHERE `entry`=22997;
 
 
-- -------------------------------------------------------- 
-- 2011_09_15_02_world_misc.sql 
-- -------------------------------------------------------- 
SET @Gossip = 21289;
SET @NElf = 31111;

DELETE FROM `gossip_menu` WHERE `entry`=@Gossip AND `text_id` IN (15037,15038);
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(@Gossip, 15037),
(@Gossip, 15038);

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@Gossip AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`) VALUES
(@Gossip, 0, 0, 'I believe in you.', 1, 1);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@Gossip;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, @Gossip, 15038, 0, 1, 58493, 0, 0, 0, '', 'Mohawk Grenade - aura'),
(14, @Gossip, 15037, 0, 11, 58493, 0, 0, 0, '', 'Mohawk Grenade - no aura'),
(15, @Gossip, 0, 0, 26, 43489, 1, 0, 0, '', 'Mohawk Grenade - no item');

UPDATE `creature_template` SET `gossip_menu_id`=@Gossip,`minlevel`=80,`maxlevel`=80,`npcflag`=`npcflag`|1,`AIName`='SmartAI' WHERE `entry`=@NElf;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@NElf AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@NElf, 0, 0, 1, 62, 0, 100, 0, @Gossip, 0, 0, 0, 11, 69243, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Mohawk - On gossip select cast Create Mohawk Grenade'),
(@NElf, 0, 1, 0, 61, 0, 100, 0, @Gossip, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Mohawk - Link - close gossip');

DELETE FROM `creature_template_addon` WHERE `entry`=36778;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(36778, 0, 0, 3, 1, 0, NULL); -- sleep
 
 
-- -------------------------------------------------------- 
-- 2011_09_15_03_world_creature_template.sql 
-- -------------------------------------------------------- 
-- Applied immunities to following mechanics:
--  MECHANIC_CHARM
--  MECHANIC_DISORIENTED
--  MECHANIC_DISARM
--  MECHANIC_DISTRACT
--  MECHANIC_FEAR
--  MECHANIC_GRIP
--  MECHANIC_ROOT
--  MECHANIC_SILENCE
--  MECHANIC_SLEEP
--  MECHANIC_SNARE
--  MECHANIC_STUN
--  MECHANIC_FREEZE
--  MECHANIC_KNOCKOUT
--  MECHANIC_POLYMORPH
--  MECHANIC_BANISH
--  MECHANIC_SHACKLE
--  MECHANIC_TURN
--  MECHANIC_HORROR
--  MECHANIC_DAZE
--  MECHANIC_SAPPED

UPDATE `creature_template` SET `mechanic_immune_mask`=617299839 WHERE `entry` IN (
36597,39166,39167,39168, -- The Lich King
36612,37957,37958,37959, -- Lord Marrowgar
36626,37504,37505,37506, -- Festergut
36627,38390,38549,38550, -- Rotface
36678,38431,38585,38586, -- Professor Putricide
36853,38265,38266,38267, -- Sindragosa
36855,38106,38296,38297, -- Lady Deathwhisper
37813,38402,38582,38583, -- Deathbringer Saurfang
37955,38434,38435,38436, -- Blood-Queen Lana'thel
37970,38401,38784,38785, -- Prince Valanar
37972,38399,38769,38770, -- Prince Keseleth
37973,38400,38771,38772); -- Prince Taldaram
 
 
-- -------------------------------------------------------- 
-- 2011_09_15_04_world_misc.sql 
-- -------------------------------------------------------- 
SET @GUID := 209102;
SET @NPC_HERENN := 28601;
SET @NPC_DEATHS_HAND_ACOLYTE := 28602;
SET @PATH := @NPC_DEATHS_HAND_ACOLYTE * 10;
SET @OMEGA_RUNE := 38708;

DELETE FROM `creature` WHERE `id` IN (@NPC_HERENN,@NPC_DEATHS_HAND_ACOLYTE);
-- add High Cultist Herenn (28601) 
INSERT INTO `creature` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(@GUID+10,@NPC_HERENN,1,-6028.08,-1249.02,-146.7644,3.054326);

-- add Death's Hand Acolyte (28602), genders are random (25342,25343)
INSERT INTO `creature`(`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(@GUID,  @NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6163.63,-1249.54,-159.7329,3.11264,120,0,0,1,0,2),   -- wandering
(@GUID+1,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6083.673,-1249.462,-143.4821,0.01435,120,0,0,1,0,2), -- wandering 
(@GUID+2,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6037.476,-1243.375,-146.8277,5.98647,120,0,0,1,0,0), -- kneeled 
(@GUID+3,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6036.1,-1255.38,-146.8277,1.15191,120,0,0,1,0,0),    -- kneeled 
(@GUID+4,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6065.16,-1256.21,-143.3607,3.10668,120,0,0,1,0,0),
(@GUID+5,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6118.18,-1241.33,-143.281,3.12169,120,0,0,1,0,0),
(@GUID+6,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6104.965,-1243.601,-143.1921,3.12413,120,0,0,1,0,0),
(@GUID+7,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6065.27,-1242.8,-143.3297,3.14159,120,0,0,1,0,0),
(@GUID+8,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6104.698,-1256.314,-143.1921,3.05432,120,0,0,1,0,0),
(@GUID+9,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6121.342,-1258.456,-143.1921,2.9147,120,0,0,1,0,0);

-- update creature_template Death's Hand Acolyte for equipment
UPDATE `creature_template` SET `equipment_id`=815 WHERE `entry`=@NPC_DEATHS_HAND_ACOLYTE;

-- set waypoint id's and visual effects
DELETE FROM `creature_addon` WHERE `guid` IN (@GUID,@GUID+1,@GUID+2,@GUID+3);
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@GUID  ,@PATH,0,1,0,''), 
(@GUID+1,@PATH+20,0,1,0,''), 
(@GUID+2,0,8,0,0,''),       -- kneeling
(@GUID+3,0,8,0,0,'');       -- kneeling

-- pathing Death's Hand Acolyte #1
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-6167.854,-1249.36,-162.6509,0,0,0,100,0),
(@PATH,2,-6154.54,-1249.757,-155.4785,0,0,0,100,0),
(@PATH,3,-6141.45,-1249.3,-147.7103,0,0,0,100,0),
(@PATH,4,-6140.292,-1249.466,-147.2287,0,0,0,100,0),
(@PATH,5,-6138.544,-1249.176,-145.9789,0,0,0,100,0),
(@PATH,6,-6136.085,-1249.64,-143.2982,0,0,0,100,0),
(@PATH,7,-6120.995,-1250.048,-143.2961,0,0,0,100,0),
(@PATH,8,-6133.946,-1250.144,-143.3480,0,0,0,100,0);

-- pathing Death's Hand Acolyte #2
DELETE FROM `waypoint_data` WHERE `id`=@PATH+20;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH+20,1,-6063.011,-1249.407,-143.4293,0,0,0,100,0),
(@PATH+20,2,-6067.342,-1249.435,-143.2057,0,0,0,100,0),
(@PATH+20,3,-6081.293,-1249.456,-143.4746,0,0,0,100,0),
(@PATH+20,4,-6083.673,-1249.462,-143.4821,0,0,0,100,0),
(@PATH+20,5,-6091.368,-1249.619,-143.6254,0,0,0,100,0),
(@PATH+20,6,-6100.618,-1249.619,-143.3754,0,0,0,100,0),
(@PATH+20,7,-6105.942,-1249.782,-143.2761,0,0,0,100,0);

-- SAI for High Cultist Herenn, also add loot and equipment
UPDATE `creature_template` SET `AIName`='SmartAI',`equipment_id`=1803 WHERE `entry`=@NPC_HERENN;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@NPC_HERENN;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@NPC_HERENN,0,0,0,0,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'High Cultist Herenn - in Combat - Say Text 0');

-- High Cultist Herenn talk text 
DELETE FROM `creature_text` WHERE `entry`=@NPC_HERENN;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@NPC_HERENN,0,0,'Fool! You led us to the only being that could stand up to our armies! You will never bring the Etymidian back to Northrend!',12,0,100,25,0,0,'High Cultist Herenn');
 
 
-- -------------------------------------------------------- 
-- 2011_09_15_05_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warl_ritual_of_doom_effect';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(18541, 'spell_warl_ritual_of_doom_effect');
 
 
-- -------------------------------------------------------- 
-- 2011_09_16_00_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dreamwalker_twisted_nightmares';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(71941, 'spell_dreamwalker_twisted_nightmares');
 
 
-- -------------------------------------------------------- 
-- 2011_09_19_00_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dreamwalker_summon_suppresser_effect';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(70936, 'spell_dreamwalker_summon_suppresser_effect');
 
 
-- -------------------------------------------------------- 
-- 2011_09_21_00_world_misc.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `scriptname`='mob_bullet_controller' WHERE `entry` = 34743;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `ConditionTypeOrReference` = 18 AND `SourceEntry` IN (66152,66153);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 0, 66152, 0, 18, 1, 34720, 1, 0, '', 'Light Bullets Stalker - Light Orb Spawn'),
(13, 0, 66153, 0, 18, 1, 34704, 1, 0, '', 'Dark Bullets Stalker - Dark Orb Spawn');
 
 
-- -------------------------------------------------------- 
-- 2011_09_21_01_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `spell_id` IN (53475,53487,54015);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(53475, 'spell_gen_oracle_wolvar_reputation'), -- Set Oracle Faction Friendly
(53487, 'spell_gen_oracle_wolvar_reputation'), -- Set Wolvar Faction Honored
(54015, 'spell_gen_oracle_wolvar_reputation'); -- Set Oracle Faction Honored 
 
-- -------------------------------------------------------- 
-- 2011_09_21_02_world_command.sql 
-- -------------------------------------------------------- 
DELETE FROM command WHERE name = 'dev';
INSERT INTO command VALUES
('dev', 3, 'Syntax: .dev [on/off]\r\n\r\nEnable or Disable in game Dev tag or show current state if on/off not provided.');
 
 
-- -------------------------------------------------------- 
-- 2011_09_21_02_world_trinity_string.sql 
-- -------------------------------------------------------- 
DELETE FROM trinity_string WHERE entry IN (1137, 1138);
INSERT INTO trinity_string (`entry`,`content_default`) VALUES
(1137, 'Dev mode is ON'),
(1138, 'Dev mode is OFF');
 
 
-- -------------------------------------------------------- 
-- 2011_09_22_00_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `spell_id`=63342;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(63342,'spell_kologarn_summon_focused_eyebeam');
 
 
-- -------------------------------------------------------- 
-- 2011_09_24_00_world_spell_script_names.sql 
-- -------------------------------------------------------- 
-- Remove redundant areatrigger scripts
DELETE FROM `areatrigger_scripts` WHERE `entry` IN(5369,5423);
-- Add spellscript for trap spell
DELETE FROM `spell_script_names` WHERE `spell_id`=62705;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(62705,'spell_auto_repair');

 
 
-- -------------------------------------------------------- 
-- 2011_09_24_01_world_sai.sql 
-- -------------------------------------------------------- 
-- [Q] Help Tavara

-- Tavara SAI
SET @ENTRY := 17551;
SET @SPELL_GIFT_OF_THE_NAARU_PR := 59544; -- Gift of the Naaru - Priest
SET @SPELL_LESSER_HEAL_R1 := 2050; -- Lesser Heal R1
SET @SPELL_LESSER_HEAL_R2 := 2052; -- Lesser Heal R2
SET @SPELL_RENEW_R1 := 139; -- Renew R1 (they don't have R2 yet)
UPDATE `creature_template` SET `AIName`='SmartAI',`RegenHealth`=0 WHERE `entry`=@ENTRY;
UPDATE `quest_template` SET `ReqSpellCast1`=0 WHERE `entry`=9586;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,1,@SPELL_LESSER_HEAL_R1,0,0,0,33,17551,0,0,0,0,0,7,0,0,0,0,0,0,0,"Tavara - On Spellhit - Give Quest Credit"),
(@ENTRY,0,1,0,8,0,100,1,@SPELL_LESSER_HEAL_R2,0,0,0,33,17551,0,0,0,0,0,7,0,0,0,0,0,0,0,"Tavara - On Spellhit - Give Quest Credit"),
(@ENTRY,0,2,0,8,0,100,1,@SPELL_GIFT_OF_THE_NAARU_PR,0,0,0,33,17551,0,0,0,0,0,7,0,0,0,0,0,0,0,"Tavara - On Spellhit - Give Quest Credit"),
(@ENTRY,0,3,0,8,0,100,1,@SPELL_RENEW_R1,0,0,0,33,17551,0,0,0,0,0,7,0,0,0,0,0,0,0,"Tavara - On Spellhit - Give Quest Credit");

-- [Q] Weakness to Lightning

-- Scavenge-bot 004-A8 SAI
SET @ENTRY := 25752;
SET @SPELL_CUTING_LASER := 49945;
SET @SPELL_POWER_OF_THE_STORM := 46432;
UPDATE `creature_template` SET `AIName`='SmartAI',`mechanic_immune_mask`=`mechanic_immune_mask`|8 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,10000,10000,15000,11,@SPELL_CUTING_LASER,0,0,0,0,0,2,0,0,0,0,0,0,0,"Scavenge-bot 004-A8 - In Combat - Cast Cutting Laser"),
(@ENTRY,0,1,0,8,0,100,0,@SPELL_POWER_OF_THE_STORM,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Scavenge-bot 004-A8 - On Spellhit - Set Phase 1"),
(@ENTRY,0,2,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,7,0,0,0,0,0,0,0,"Scavenge-bot 004-A8 - On Death - Quest Credit (Phase 1)");

-- Scavenge-bot 005-B6 SAI
SET @ENTRY := 25792;
SET @SPELL_CUTING_LASER := 49945;
SET @SPELL_POWER_OF_THE_STORM := 46432;
UPDATE `creature_template` SET `AIName`='SmartAI',`mechanic_immune_mask`=`mechanic_immune_mask`|8 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,10000,10000,15000,11,@SPELL_CUTING_LASER,0,0,0,0,0,2,0,0,0,0,0,0,0,"Scavenge-bot 005-B6 - In Combat - Cast Cutting Laser"),
(@ENTRY,0,1,0,8,0,100,0,@SPELL_POWER_OF_THE_STORM,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Scavenge-bot 005-B6 - On Spellhit - Set Phase 1"),
(@ENTRY,0,2,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,7,0,0,0,0,0,0,0,"Scavenge-bot 005-B6 - On Death - Quest Credit (Phase 1)");

-- Defendo-tank 66D SAI
SET @ENTRY := 25758;
SET @SPELL_SHOOT := 49987;
SET @SPELL_MACHINE_GUN := 49981;
SET @SPELL_POWER_OF_THE_STORM := 46432;
UPDATE `creature_template` SET `AIName`='SmartAI',`mechanic_immune_mask`=`mechanic_immune_mask`|8 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Defendo-tank 66D - On Aggro - Say Line 0"),
(@ENTRY,0,1,0,0,0,100,0,1100,3100,2300,13700,11,@SPELL_SHOOT,0,0,0,0,0,2,0,0,0,0,0,0,0,"Defendo-tank 66D - In Combat - Cast Shoot"),
(@ENTRY,0,2,0,0,0,100,0,9800,13100,18300,19200,11,@SPELL_MACHINE_GUN,0,0,0,0,0,2,0,0,0,0,0,0,0,"Defendo-tank 66D - In Combat - Cast Machine Gun"),
(@ENTRY,0,3,0,8,0,100,0,@SPELL_POWER_OF_THE_STORM,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defendo-tank 66D - On Spellhit - Set Phase 1"),
(@ENTRY,0,4,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,7,0,0,0,0,0,0,0,"Defendo-tank 66D - On Death - Quest Credit (Phase 1)");

-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Incoming $r flier! Shoot $g him:her; down!",12,0,100,0,0,0,"Defendo-tank 66D");

-- Sentry-bot 57-K SAI
SET @ENTRY := 25753;
SET @SPELL_STUN := 46641;
SET @SPELL_FIREWORK := 6668;
SET @SPELL_POWER_OF_THE_STORM := 46432;
UPDATE `creature_template` SET `AIName`='SmartAI',`mechanic_immune_mask`=`mechanic_immune_mask`|8 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,3000,13000,13000,26000,11,@SPELL_FIREWORK,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sentry-bot 57-K - Out of Combat - Cast Red Firework"),
(@ENTRY,0,1,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sentry-bot 57-K - On Aggro - Say Line 0"),
(@ENTRY,0,2,0,0,0,100,0,1100,3100,2300,13700,11,@SPELL_STUN,0,0,0,0,0,2,0,0,0,0,0,0,0,"Sentry-bot 57-K - In Combat - Cast Stun"),
(@ENTRY,0,3,0,8,0,100,0,@SPELL_POWER_OF_THE_STORM,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sentry-bot 57-K - On Spellhit - Set Phase 1"),
(@ENTRY,0,4,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,7,0,0,0,0,0,0,0,"Sentry-bot 57-K - On Death - Quest Credit (Phase 1)");

-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Warning! Warning! Intruder alert! Intruder alert!",12,0,100,0,0,0,"Sentry-bot 57-K"),
(@ENTRY,0,1,"You have been detected. You will be assimilated or eliminated.",12,0,100,0,0,0,"Sentry-bot 57-K"),
(@ENTRY,0,2,"Activate counter-measures. Repel intruder.",12,0,100,0,0,0,"Sentry-bot 57-K");

DELETE FROM `conditions` WHERE `SourceEntry` IN (35352) AND `ConditionValue2` IN (25752,25792,25758,25753);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,0,35352,0,24,1,25752,0,0,'',"Spell Power of the Storm can only be cast at Scavenge-bot 004-A8"),
(18,0,35352,0,24,1,25792,0,0,'',"Spell Power of the Storm can only be cast at Scavenge-bot 005-B6"),
(18,0,35352,0,24,1,25758,0,0,'',"Spell Power of the Storm can only be cast at Defendo-tank 66D"),
(18,0,35352,0,24,1,25753,0,0,'',"Spell Power of the Storm can only be cast at Sentry-bot 57-K");


-- Mammoth Calf SAI
SET @ENTRY := 24613;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_TRAMPLE := 15550;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Mammoth Calf - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,3000,9000,9000,18000,11,@SPELL_TRAMPLE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Mammoth Calf - In Combat - Cast Trample");

-- Wooly Mammoth SAI
SET @ENTRY := 24614;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_TRAMPLE := 15550;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Wooly Mammoth - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,3000,9000,9000,18000,11,@SPELL_TRAMPLE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Wooly Mammoth - In Combat - Cast Trample");

-- Wooly Rhino Bull SAI
SET @ENTRY := 25489;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_RHINO_CHARE := 50500;
SET @SPELL_THICK_HIDE := 50502;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Wooly Rhino Bull - On Death - Cast Animal Blood"),
(@ENTRY,0,1,2,4,0,100,0,0,0,0,0,11,@SPELL_RHINO_CHARE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Wooly Rhino Bull - On Aggro - Cast Rhino Charge"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,11,@SPELL_THICK_HIDE,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wooly Rhino Bull - On Aggro - Cast Thick Hide");

-- Carrion Condor SAI
SET @ENTRY := 26174;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_SWOOP := 5708;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Carrion Condor - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,3000,9000,9000,18000,11,@SPELL_SWOOP,0,0,0,0,0,2,0,0,0,0,0,0,0,"Carrion Condor - In Combat - Cast Swoop");

-- Marsh Caribou SAI
SET @ENTRY := 25680;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_GORE := 32019;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Marsh Caribou - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_GORE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Marsh Caribou - In Combat - Cast Gore");

-- Marsh Fawn SAI
SET @ENTRY := 25829;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_GORE := 32019;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Marsh Fawn - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_GORE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Marsh Fawn - In Combat - Cast Gore");

-- Sand Turtle SAI
SET @ENTRY := 25482;
SET @SPELL_ANIMAL_BLOOD := 46221;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Sand Turtle - On Death - Cast Animal Blood");

-- Tundra Wolf SAI
SET @ENTRY := 25675;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_INFECTED_BITE := 7367;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Tundra Wolf - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,3000,9000,9000,18000,11,@SPELL_INFECTED_BITE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Tundra Wolf - In Combat - Cast Infected Bite");

-- Wooly Mammoth Bull SAI
SET @ENTRY := 25743;
SET @SPELL_THUNDERING_ROAR := 46316;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Wooly Mammoth Bull - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,3000,9000,9000,18000,11,@SPELL_THUNDERING_ROAR,0,0,0,0,0,2,0,0,0,0,0,0,0,"Wooly Mammoth Bull - In Combat - Cast Thundering Roar"); -- It's a fear spell

-- Wooly Rhino Calf SAI
SET @ENTRY := 25488;
SET @SPELL_ANIMAL_BLOOD := 46221;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Wooly Rhino Calf - On Death - Cast Animal Blood");

-- Wooly Rhino Matriarch SAI
SET @ENTRY := 25487;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_THICK_HIDE := 50502;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Wooly Rhino Matriarch - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,4,0,100,0,0,0,0,0,11,@SPELL_THICK_HIDE,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wooly Rhino Matriarch - On Aggro - Cast Thick Hide");
 
 
-- -------------------------------------------------------- 
-- 2011_09_25_00_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_bloodlust';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_heroism';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(2825,'spell_sha_bloodlust'),
(32182,'spell_sha_heroism');

 
 
-- -------------------------------------------------------- 
-- 2011_09_26_00_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `spell_id` IN (62374,62475);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(62374,'spell_pursue'),
(62475,'spell_systems_shutdown');
 
 
-- -------------------------------------------------------- 
-- 2011_09_28_00_world_achievement_reward.sql 
-- -------------------------------------------------------- 
-- Set `title_A` to male variant (Patron)
UPDATE `achievement_reward` SET `title_A`=138 WHERE `entry`=1793;
 
 
-- -------------------------------------------------------- 
-- 2011_09_28_01_world_spell_dbc.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_dbc` WHERE `Id`=72958;
INSERT INTO `spell_dbc` (`Id`,`Attributes`,`AttributesEx`,`AttributesEx2`,`ProcChance`,`DurationIndex`,`Effect1`,`EffectImplicitTargetA1`,`EffectApplyAuraName1`,`EffectAmplitude1`,`EffectTriggerSpell1`,`Comment`) VALUES
(72958,0x000001C0,0,0,101,21,6,1,23,85000,72957,'Shaman T10 shoulder visual');
 
 
-- -------------------------------------------------------- 
-- 2011_09_28_02_world_game_event.sql 
-- -------------------------------------------------------- 
ALTER TABLE `game_event_creature` DROP PRIMARY KEY, ADD PRIMARY KEY (`guid`,`eventEntry`);
ALTER TABLE `game_event_gameobject` DROP PRIMARY KEY, ADD PRIMARY KEY (`guid`,`eventEntry`);
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_00_world_creature_template.sql 
-- -------------------------------------------------------- 
-- Fix quest 11162 Challenge to the Black Flight
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~768 WHERE `entry`=23789; -- Smolderwing
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_01_world_gameobject_template.sql 
-- -------------------------------------------------------- 
UPDATE `gameobject_template` SET `faction`=1732 WHERE `entry`=195139; -- Portal to Stormwind
UPDATE `gameobject_template` SET `faction`=1735 WHERE `entry`=195140; -- Portal to Orgrimmar

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128|2 WHERE `entry` IN (18967,18968,19230); -- Dark Assault - Alliance/Horde/Legion Portal - Invisible Stalker

DELETE FROM `gameobject` WHERE `id` IN (195139, 195140);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(164, 195140, 530, 1, 1, -161.3178, 965.4099, 54.29044, 0, 0, 0, 0, 0, 200, 0, 1), -- Portal to Orgrimmar
(170, 195139, 530, 1, 1, -337.4917, 962.6188, 54.28853, 0, 0, 0, 0, 0, 200, 0, 1); -- Portal to Stormwind
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_02_world_game_event_creature.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128|2 WHERE `entry` IN (19871); -- World Trigger (World Trigger (Not Immune NPC))

DELETE FROM `game_event_creature` WHERE `guid` IN (62848,62849) AND `eventEntry`=11;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES 
(11, 62848),
(11, 62849);
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_03_world_conditions.sql 
-- -------------------------------------------------------- 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceEntry`=41058;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 0, 41058, 0, 24, 1, 29625, 0, 0, '', 'Hyldnir Harpoon target Hyldsmeet Proto-Drake'),
(18, 0, 41058, 0, 24, 1, 29754, 0, 0, '', 'Hyldnir Harpoon target Column Ornament');
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_04_world_sai.sql 
-- -------------------------------------------------------- 
-- Fix quest Strength of the Tempest
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=29079;
DELETE FROM `smart_scripts` WHERE `entryorguid`=29079 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29079,0,0,0,9,0,100,0,0,70,2000,6000,11,53062,0,0,0,0,0,18,70,0,0,0,0,0,0,'Shrine of the Tempest - Range cast Lightning Strike'); -- GUESSING, 10% sure that this is the correct spell. Could 51213 Weather Shrine Active Aura

DELETE FROM `spell_scripts` WHERE `id`=53062;
INSERT INTO `spell_scripts` (`id`, `effIndex`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(53062, 0, 0, 15, 53067, 2, 0, 0, 0, 0, 0); -- Cast create item spell
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_05_world_sai.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `unit_flags`=32768,`equipment_id`=53 WHERE `entry`=24062; -- Wildervar Miner
UPDATE `creature_template` SET `unit_flags`=33536 WHERE `entry`=24178; -- Shatterhorn

UPDATE `creature_model_info` SET `bounding_radius`=1.25,`combat_reach`=4.375,`gender`=0 WHERE `modelid`=22486; -- Shatterhorn

DELETE FROM `creature_template_addon` WHERE `entry` IN (24062,24178);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(24062,0,1,257,0, NULL), -- Wildervar Miner
(24178,0,3,1,0, '6606'); -- Shatterhorn, Self Visual - Sleep Until Cancelled  (DND)
DELETE FROM `creature_addon` WHERE `guid` IN (120419,120422,106573);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES 
(120419,0,0,0,0,1,''), -- Wildervar Miner, talk
(120422,0,0,0,0,1,''); -- Wildervar Miner, talk

DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;

-- The ram meat spell may only be used if player is inside the mine
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=43209;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,43209,0,23,4534,0,0,64,'','Place Ram Meat can only be used in Wildervar Mine');

-- Insert missing spell_target_position for Place Ram Meat spell
DELETE FROM `spell_target_position` WHERE `id`=43209;
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(43209,571,2636.288086,-5050.891113,295.537445,5.374982);

-- Shatterhorn SAI
SET @ENTRY := 24178;
SET @SPELL_GROUND_SMASH := 12734; -- Ground Smash
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - On Aggro - Say Line 0'),
(@ENTRY,0,1,0,0,0,100,0,3000,5000,12000,13000,11,@SPELL_GROUND_SMASH,1,0,0,0,0,2,0,0,0,0,0,0,0,'Shatterhorn - In Combat - Cast Ground Smash'),
(@ENTRY,0,2,0,6,0,100,0,0,0,0,0,41,8000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - Force Despawn 8 Seconds After Death'),
(@ENTRY,0,3,0,8,0,0,0,43209,0,0,0,19,0x300,1,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - On Place Meat spellhit remove unit flags'),
(@ENTRY,0,4,0,8,0,0,0,43209,0,0,0,28,6606,1,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - On Place Meat spellhit remove sleep aura'),
(@ENTRY,0,5,0,8,0,0,0,43209,0,0,0,91,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - On Place Meat spellhit remove byte1 3');

-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,'%s wakes up from the smell of fresh meat!',16,0,100,15,0,0,'Shatterhorn on aggro line and roar at same time');

/* Target is null, can't use event_scripts
-- Event send by Place Ram Meat spell
DELETE FROM `event_scripts` WHERE `id`=15739;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(15739, 2, 14, 6606, 0, 0, 0, 0, 0, 0),
(15739, 3, 5, 0x6+0x35, 0x300, 0, 0, 0, 0, 0);
*/
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_06_world_misc.sql 
-- -------------------------------------------------------- 
-- Fix quest What Illidan Wants, Illidan Gets...
-- Make the npc_text entries work properly
DELETE FROM `gossip_menu` WHERE `entry` IN (8336,8342,8341,8340,8339,8338) AND `text_id` IN (10401,10405,10406,10407,10408,10409);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES 
(8336,10401),
(8342,10405),
(8341,10406),
(8340,10407),
(8339,10408),
(8338,10409);

-- Conditions for gossip menu of quest What Illidan Wants, Illidan Gets...
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8336;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,8336,0,0,9,10577,0,0,0,'','Only show first gossip if player is on quest What Illidan Wants, Illidan Gets...');

-- Insert options (for players)
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (8336,8342,8341,8340,8339,8338);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`) VALUES
(8336,0,0,'I bring word from Lord Illidan.',1,1,8342),
(8342,0,0,'The cipher fragment is to be moved. Have it delivered to Zuluhed.',1,1,8341),
(8341,0,0,'Perhaps you did not hear me, Ruusk. I am giving you an order from Illidan himself!',1,1,8340),
(8340,0,0,'Very well. I will return to the Black Temple and notify Lord Illidan of your unwillingness to carry out his wishes. I suggest you make arrangements with your subordinates and let them know that you will soon be leaving this world.',1,1,8339),
(8339,0,0,'Do I need to go into all the gory details? I think we are both well aware of what Lord Illidan does with those that would oppose his word. Now, I must be going! Farewell, Ruusk! Forever...',1,1,8338),
(8338,0,0,'Ah, good of you to come around, Ruusk. Thank you and farewell.',1,1,0); -- Here the quest credit is given

-- Commander Ruusk SAI
UPDATE `creature_template` SET `gossip_menu_id`=8336,`AIName`='SmartAI' WHERE `entry`=20563;
DELETE FROM `smart_scripts` WHERE `entryorguid`=20563 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(20563,0,0,1,62,0,100,0,8338,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Commander Ruusk - On Gossip Select - Close Gossip'),
(20563,0,1,0,61,0,100,0,0,0,0,0,26,10577,0,0,0,0,0,7,0,0,0,0,0,0,0,'Commander Ruusk - On Gossip Select (link) - Quest Credit');
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_07_world_sai.sql 
-- -------------------------------------------------------- 
SET @ENTRY_FIRJUS := 24213;
SET @ENTRY_JLARBORN := 24215;
SET @ENTRY_YORUS := 24214;
SET @ENTRY_OLUF := 23931;
SET @QUEST := 11300;

-- Summon Firjus on quest accept - this starts the quest
UPDATE `quest_template` SET `StartScript`=@QUEST WHERE `entry`=@QUEST;
DELETE FROM `quest_start_scripts` WHERE `id`=@QUEST;
INSERT INTO `quest_start_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(@QUEST,3,10,@ENTRY_FIRJUS,300000,0,799.653931,-4718.678711,-96.236053,4.992353);

-- Firjus, Jlarborn, Yorus and Oluf SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ENTRY_FIRJUS,@ENTRY_JLARBORN,@ENTRY_YORUS,@ENTRY_OLUF);
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (@ENTRY_FIRJUS,@ENTRY_JLARBORN,@ENTRY_YORUS,@ENTRY_OLUF);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY_FIRJUS,@ENTRY_JLARBORN,@ENTRY_YORUS,@ENTRY_OLUF) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY_FIRJUS,0,0,0,0,0,100,0,3000,6000,12000,15000,11,15284,0,0,0,0,0,2,0,0,0,0,0,0,0,'Firjus - In Combat - Cleave'),
(@ENTRY_FIRJUS,0,1,0,0,0,100,0,10000,10000,10000,10000,11,43348,0,0,0,0,0,2,0,0,0,0,0,0,0,'Firjus - In Combat - Head Crush'),
(@ENTRY_FIRJUS,0,2,0,6,0,100,1,0,0,0,0,12,@ENTRY_JLARBORN,1,300000,0,0,0,8,0,0,0,799.653931,-4718.678711,-96.236053,4.992353,'Firjus - On Death - Summon Jlarborn'),
(@ENTRY_JLARBORN,0,0,0,0,0,100,1,1000,2000,0,0,11,19131,0,0,0,0,0,2,0,0,0,0,0,0,0,'Jlarborn - In Combat - Shield Charge'),
(@ENTRY_JLARBORN,0,1,0,0,0,100,0,4000,5000,15000,16000,11,12169,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jlarborn - In Combat - Shield Block'),
(@ENTRY_JLARBORN,0,2,0,0,0,100,0,7000,8000,18000,19000,11,38233,0,0,0,0,0,2,0,0,0,0,0,0,0,'Jlarborn - In Combat - Shield Bash'),
(@ENTRY_JLARBORN,0,3,0,0,0,100,0,10000,10000,10000,10000,11,8374,0,0,0,0,0,2,0,0,0,0,0,0,0,'Jlarborn - In Combat - Arcing Smash'),
(@ENTRY_JLARBORN,0,4,0,6,0,100,1,0,0,0,0,12,@ENTRY_YORUS,1,300000,0,0,0,8,0,0,0,799.653931,-4718.678711,-96.236053,4.992353,'Jlarborn - On Death - Summon Yorus'),
(@ENTRY_YORUS,0,0,0,0,0,100,0,3000,6000,12000,15000,11,15284,0,0,0,0,0,2,0,0,0,0,0,0,0,'Yorus - In Combat - Cleave'),
(@ENTRY_YORUS,0,1,0,0,0,100,0,8000,9000,18000,19000,11,41057,0,0,0,0,0,1,0,0,0,0,0,0,0,'Yorus - In Combat - Whirlwind'),
(@ENTRY_YORUS,0,2,0,6,0,100,1,0,0,0,0,12,@ENTRY_OLUF,1,300000,0,0,0,8,0,0,0,799.653931,-4718.678711,-96.236053,4.992353,'Yorus - On Death - Summon Oluf'),
(@ENTRY_OLUF,0,0,0,0,0,100,0,3000,6000,12000,15000,11,15284,0,0,0,0,0,2,0,0,0,0,0,0,0,'Oluf - In Combat - Cleave'),
(@ENTRY_OLUF,0,1,0,0,0,100,0,8000,9000,28000,29000,11,13730,0,0,0,0,0,1,0,0,0,0,0,0,0,'Oluf - In Combat - Demoralizing Shout'),
(@ENTRY_OLUF,0,2,0,0,0,100,0,7000,7000,21000,21000,11,6533,0,0,0,0,0,2,0,0,0,0,0,0,0,'Oluf - In Combat - Net'),
(@ENTRY_OLUF,0,3,0,0,0,100,1,1000,1000,0,0,11,42870,0,0,0,0,0,2,0,0,0,0,0,0,0,'Oluf - In Combat - Throw Harpoon'),
(@ENTRY_OLUF,0,4,0,0,0,100,0,10000,10000,10000,10000,11,41057,0,0,0,0,0,1,0,0,0,0,0,0,0,'Oluf - In Combat - Whirlwind'),
(@ENTRY_OLUF,0,5,0,6,0,100,1,0,0,0,0,50,186640,90000,0,0,0,0,8,0,0,0,799.653931,-4718.678711,-96.236053,4.992353,'Oluf - On Death - Summon Ancient Cipher');
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_08_world_sai.sql 
-- -------------------------------------------------------- 
-- Doctor Razorgrin SAI
SET @ENTRY := 25678;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `creature_ai_texts` WHERE `entry`=-767;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Doctor Razorgin - On Aggro - Say Line 0 (random)');
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,'Ah, good... more parts!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines'),
(@ENTRY,0,1,'Clear!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines'),
(@ENTRY,0,2,'Fresh meat!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines'),
(@ENTRY,0,3,'I recommened evisceration!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines'),
(@ENTRY,0,4,'It''s no good... you need more work first.',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines'),
(@ENTRY,0,5,'Live, damn you!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines'),
(@ENTRY,0,6,'The doctor is in!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines');
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_09_world_creatures.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `faction_A`=16,`faction_H`=16,`unit_flags`=0x8040,`speed_run`=2.85714,`InhabitType`=`InhabitType`|4 WHERE `entry`=32358; -- Fumblub Gearwind
UPDATE `creature_template` SET `faction_A`=1885,`faction_H`=1885,`unit_flags`=0x8040,`speed_run`=1.28571 WHERE `entry`=32438; -- Syreian the Bonecarver

UPDATE `creature_model_info` SET `bounding_radius`=1.25,`combat_reach`=3.919432,`gender`=1 WHERE `modelid`=27970; -- Syreian the Bonecarver

UPDATE `creature_addon` SET `mount`=25587, `bytes1`=0x3000000 WHERE `guid`=151938; -- Fumblub Gearwind

DELETE FROM `creature_template_addon` WHERE `entry` IN (32358,32438);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(32358,25587,0x3000000,1,0, NULL), -- Fumblub Gearwind
(32438,0,0,2,0, NULL); -- Syreian the Bonecarver
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_10_world_questrelation.sql 
-- -------------------------------------------------------- 
-- Removing obsolete quest 960, which was replaced by quest 961
DELETE FROM `creature_questrelation` WHERE `quest`=960;
DELETE FROM `creature_involvedrelation` WHERE `quest`=960;

DELETE FROM `disables` WHERE `sourceType`=1 AND `entry`=960;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(1, 960, 0, '', '', 'Deprecated quest');
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_11_world_loot.sql 
-- -------------------------------------------------------- 
-- Skin loot entry
SET @LibraryLaborer := 29724;
SET @UldarBoss := 29725;
SET @AirStrip := 29726;
SET @ReavandDispo := 29727;
SET @HallsofStone := 29728;
SET @Dirkee := 29729;
SET @Recovery := 29730;
-- Ref Loot Entry
SET @UldarBossRef := 50013;
SET @AirStripRef := 50013+1;
SET @HallsofStoneRef := 50013+2;
SET @ReavandDispoRef := 50013+3;
SET @LibraryLaborerRef := 50013+4;
-- Add loot to the skinning table 
DELETE FROM `skinning_loot_template` WHERE `entry` IN (@Recovery,@Dirkee,@LibraryLaborer,@ReavandDispo,@HallsofStone,@AirStrip,@UldarBoss);
INSERT INTO `skinning_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES 
(@Recovery, 41338, 42, 1, 0, 1, 3), -- Sprung Whirlygig
(@Recovery, 41337, 44, 1, 0, 1, 3), -- Whizzed out Gizmo
(@Recovery, 39690, 9, 1, 0, 1, 3), -- Volatile Blasting trigger
(@Recovery, 39681, 4, 1, 0, 2, 4), -- Handfull of copper bolts
(@Recovery, 49050, 0.5, 1, 0, 1, 1), -- jeeves
(@Recovery, 39682, 0.5, 1, 0, 1, 1), -- Overcharged Capacitor
(@Dirkee, 41338, 42, 1, 0, 1, 3), -- Sprung Whirlygig
(@Dirkee, 41337, 44.5, 1, 0, 1, 3), -- Whizzed out Gizmo
(@Dirkee, 39690, 10, 1, 0, 1, 3), -- Volatile Blasting trigger
(@Dirkee, 39681, 3, 1, 0, 2, 4), -- Handfull of copper bolts
(@Dirkee, 49050, 0.5, 1, 0, 1, 1), -- jeeves
(@LibraryLaborer , 1, 100, 1, 0, -@LibraryLaborerRef, 1),
(@ReavandDispo, 1, 100, 1, 0, -@ReavandDispoRef, 1),
(@HallsofStone, 1, 100, 1, 0, -@HallsofStoneRef, 1),
(@AirStrip, 1, 100, 1, 0, -@AirStripRef, 1),
(@UldarBoss, 1, 100, 1, 0, -@UldarBossRef, 1);
-- Add loot to the reference table 
DELETE FROM `reference_loot_template` WHERE `entry` IN (@AirStripRef,@ReavandDispoRef,@LibraryLaborerRef,@HallsofStoneRef,@UldarBossRef);
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES 
(@AirStripRef, 41338, 33, 1, 0, 1, 1), -- Sprung Whirlygig
(@AirStripRef, 41337, 42, 1, 0, 1, 1), -- Whizzed out Gizmo
(@AirStripRef, 39690, 13, 1, 0, 1, 3), -- Volatile Blasting trigger
(@AirStripRef, 39681, 10, 1, 0, 1, 4), -- Handfull of copper bolts
(@AirStripRef, 39686, 1.2, 1, 0, 1, 1), -- Frost steel Tube
(@AirStripRef, 49050, 0.8, 1, 0, 1, 1), -- jeeves
(@ReavandDispoRef, 41338, 40, 1, 0, 1, 3), -- Sprung Whirlygig
(@ReavandDispoRef, 41337, 40, 1, 0, 1, 3), -- Whizzed out Gizmo
(@ReavandDispoRef, 39690, 9.5, 1, 0, 1, 3), -- Volatile Blasting trigger
(@ReavandDispoRef, 39681, 9.5, 1, 0, 2, 4), -- Handfull of copper bolts
(@ReavandDispoRef, 39686, 0.5, 1, 0, 1, 1), -- Frost steel Tube
(@ReavandDispoRef, 49050, 0.5, 1, 0, 1, 1), -- jeeves
(@LibraryLaborerRef, 41338, 43, 1, 0, 1, 3), -- Sprung Whirlygig
(@LibraryLaborerRef, 41337, 42, 1, 0, 1, 3), -- Whizzed out Gizmo
(@LibraryLaborerRef, 39690, 9, 1, 0, 1, 3), -- Volatile Blasting trigger
(@LibraryLaborerRef, 39681, 4, 1, 0, 2, 4), -- Handfull of copper bolts
(@LibraryLaborerRef, 49050, 1, 1, 0, 1, 1), -- jeeves
(@LibraryLaborerRef, 39686, 0.5, 1, 0, 1, 1), -- Frost steel Tube
(@LibraryLaborerRef, 39682, 0.5, 1, 0, 1, 1), -- Overcharged Capacitor
(@HallsofStoneRef, 41338, 43.5, 1, 0, 1, 3), -- Sprung Whirlygig
(@HallsofStoneRef, 41337, 42, 1, 0, 1, 3), -- Whizzed out Gizmo
(@HallsofStoneRef, 39690, 8, 1, 0, 1, 3), -- Volatile Blasting trigger
(@HallsofStoneRef, 39681, 5, 1, 0, 2, 4), -- Handfull of copper bolts
(@HallsofStoneRef, 49050, 0.5, 1, 0, 1, 1), -- jeeves
(@HallsofStoneRef, 39686, 0.5, 1, 0, 1, 1), -- Frost steel Tube
(@HallsofStoneRef, 39682, 0.5, 1, 0, 1, 1), -- Overcharged Capacitor
(@UldarBossRef, 35627, 43, 1, 0, 2, 10), -- Eternal Shadow
(@UldarBossRef, 35624, 42, 1, 0, 4, 10), -- Eternal Earth
(@UldarBossRef, 35623, 43, 1, 0, 2, 6), -- Eternal Air
(@UldarBossRef, 36860, 42, 1, 0, 2, 6), -- Eternal Fire
(@UldarBossRef, 39690, 30, 1, 0, 16, 19), -- Volatile Blasting trigger
(@UldarBossRef, 39686, 26, 1, 0, 2, 3), -- Frost steel Tube
(@UldarBossRef, 39682, 22, 1, 0, 5, 5), -- Overcharged Capacitor
(@UldarBossRef, 39681, 21, 1, 0, 8, 10), -- Handfull of copper bolts
(@UldarBossRef, 49050, 2, 1, 0, 1, 1); -- jeeves

UPDATE `creature_template` SET `skinloot`=@LibraryLaborer WHERE `entry` IN (29389,29724); -- Library Guardian and Mechagnome Laborer
UPDATE `creature_template` SET `skinloot`=@ReavandDispo WHERE `entry` IN (34273,34274,29382); -- Stromforged Reaver and XB-488 Disposalbot
UPDATE `creature_template` SET `skinloot`=@Dirkee WHERE `entry`=32500; -- Dirkee
UPDATE `creature_template` SET `skinloot`=@Recovery WHERE `entry` IN (34267,34268); -- Parts Recovery Technician
UPDATE `creature_template` SET `skinloot`=@AirStrip WHERE `entry` IN (32358,25792,25758,25752,25753,25814,25793); -- Fumblub Gearwind, Scavenge-bot 005-B6, Defendo-tank 66D, Scavenge-bot 004-A8, Sentry-bot 57-K, Fizzcrank Mechagnome, 55-D Collect-a-tron
UPDATE `creature_template` SET `skinloot`=@HallsofStone WHERE `entry` IN (27972,31383,27971,31387); -- Lightning Construct, Unrelenting Construct
UPDATE `creature_template` SET `skinloot`=@UldarBoss WHERE `entry` IN (34332,34106,33113,34003,33293,33885); -- Leviathan Mk II, Flame Leviathan, XT-002 Deconstructor
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_12_world_creatures.sql 
-- -------------------------------------------------------- 
-- Jormunger Control Orb
DELETE FROM `gameobject` WHERE `id`=192262;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(173, 192262, 571, 1, 0x8, 8497.219, -90.90104, 789.2875, 0.1396245, 0, 0, 0.06975555, 0.9975641, 0, 0, 0);

DELETE FROM `creature` WHERE `id` IN (30301,30322,30300);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(4089, 30301, 571, 1, 0x8, 0, 0, 8497.78, -99.0251, 786.528, 3.01942, 120, 0, 0, 1, 0, 0, 0, 0, 0), -- Tamed Jormungar
(4090, 30322, 571, 1, 0x8, 0, 0, 8505.47, -86.2532, 787.339, 3.28122, 120, 0, 0, 1, 0, 0, 0, 0, 0), -- Earthen Jormungar Handler
(4765, 30322, 571, 1, 0x8, 0, 0, 8502.62, -111.308, 790.176, 3.05433, 120, 0, 0, 1, 0, 0, 0, 0, 0),
(6095, 30322, 571, 1, 0x8, 0, 0, 8498.78, -46.0375, 788.895, 2.53073, 120, 0, 0, 1, 0, 0, 0, 0, 0),
(6096, 30300, 571, 1, 0x8, 0, 0, 8015.63, -126.515, 865.719, 3.39914, 120, 0, 0, 1, 0, 0, 0, 0, 0); -- Iron Colossus

-- Template updates
UPDATE `gameobject_template` SET `flags`=0x4 WHERE `entry`=192262; -- Jormungar Control Orb
UPDATE `creature_template` SET `faction_A`=1771,`faction_H`=1771,`unit_flags`=0x8040,`speed_walk`=2.8,`speed_run`=1.5873 WHERE `entry`=30300; -- Iron Colossus
UPDATE `creature_template` SET `faction_A`=1770,`faction_H`=1770,`npcflag`=0x1,`unit_flags`=0x300,`equipment_id`=1003,`speed_run`=0.99206 WHERE `entry`=30322; -- Earthen Jormungar Handler
UPDATE `creature_template` SET `faction_A`=113,`faction_H`=113,`unit_flags`=0x300,`speed_walk`=6,`speed_run`=2.14286,`VehicleId`=227 WHERE `entry`=30301; -- Tamed Jormungar

-- Model data
UPDATE `creature_model_info` SET `bounding_radius`=3.1,`combat_reach`=50,`gender`=0 WHERE `modelid`=27093; -- Iron Colossus
UPDATE `creature_model_info` SET `bounding_radius`=0.31,`combat_reach`=1,`gender`=0 WHERE `modelid`=26091; -- Earthen Jormungar Handler
UPDATE `creature_model_info` SET `bounding_radius`=1.55,`combat_reach`=5,`gender`=2 WHERE `modelid`=26935; -- Tamed Jormungar

-- Addon data for creature 30300 (Iron Colossus)
DELETE FROM `creature_template_addon` WHERE `entry` IN (30300,30322,30301);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(30300,0,0,1,0, NULL), -- Iron Colossus
(30322,0,0,1,0, NULL), -- Earthen Jormungar Handler
(30301,0,0,1,0, NULL); -- Tamed Jormungar

DELETE FROM `spell_area` WHERE spell=56526;
INSERT INTO `spell_area`(`spell`,`area`,`quest_start`,`quest_start_active`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`) VALUES 
(56526,4436,13007,1,13007,0,0,2,1), -- Snowdrift Plains
(56526,4435,13007,1,13007,0,0,2,1); -- Navirs Cradle
 
 
-- -------------------------------------------------------- 
-- 2011_10_01_13_world_dbc.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_dbc` WHERE `Id`=31247;
INSERT INTO `spell_dbc`(`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`AttributesEx7`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`) VALUES
(31247,0,0,256,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,-1,0,0,77,0/*122*/,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,'Silithyst Cap Reward');
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_00_world_creature_template.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `minlevel`=82, `maxlevel`=82 WHERE `entry`=31674; -- Ingvar the Plunderer (1)
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_01_world_factionchange.sql 
-- -------------------------------------------------------- 
DELETE FROM `player_factionchange_items` WHERE `alliance_id`=48356; -- Wrong entry
 
DELETE FROM `player_factionchange_spells` WHERE `alliance_id` IN (67093,67091,67095,67096,67092,67085,67080,67082,67087,67083,67084,67086,60867,67065,67064,67079,67066);
INSERT INTO `player_factionchange_spells` (`alliance_id`,`horde_id`) VALUES
(67093,67132),
(67091,67130),
(67095,67134),
(67096,67135),
(67092,67131),
(67085,67141),
(67080,67136),
(67082,67138),
(67087,67139),
(67083,67143),
(67084,67140),
(67086,67142),
(60867,60866),
(67065,67147),
(67064,67144),
(67079,67145),
(67066,67146);
 
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (47003,47626,44503,47654);
INSERT INTO `player_factionchange_items` (`race_A`,`alliance_id`,`commentA`,`race_H`,`horde_id`,`commentH`) VALUES
(0,47003,'Dawnbreaker Greaves',0,47430,'Dawnbreaker Sabatons'),
(0,47626,'Plans: Sunforged Breastplate',0,47643,'Plans: Sunforged Breastplate'),
(0,44503,'Schematic: Mekgineers Chopper',0,44502,'Schematic: Mechano-Hog'),
(0,47654,'Pattern: Bejeweled Wizards Bracers',0,47639,'Pattern: Bejeweled Wizards Bracers');
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_03_world_sai.sql 
-- -------------------------------------------------------- 
SET @ENTRY := 33499; -- Skeletal Woodcutter
SET @QUEST_LOOT := 45080; -- Large Femur
SET @QUEST := 13654; -- There's Something About the Squire
SET @SPELL1 := 63124; -- Incapacitate Maloric
SET @SPELL2 := 63126; -- Search Maloric

-- add quest item to Skeletal Woodcutter
UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@ENTRY;
DELETE FROM `creature_loot_template` WHERE `entry`=@ENTRY;
INSERT INTO `creature_loot_template` VALUES
(@ENTRY,@QUEST_LOOT,-100,1,0,1,1); -- 100% drop

-- set visual effects on the skeletons
DELETE FROM `creature_template_addon` WHERE `entry`=@ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`emote`) VALUES
(@ENTRY,234); -- chopping wood

SET @ENTRY := 33498; -- Maloric
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,23,0,100,0,@SPELL1,1,0,0,81,16777216,0,0,0,0,0,1,0,0,0,0,0,0,0,'Maloric - on Aura: Incapacitate Maloric - set npcflag: Spellclick'),
(@ENTRY,0,1,0,23,0,100,0,@SPELL1,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Maloric - on NoAura: Incapacitate Maloric - set npcflag: none');

-- conditions for Large Femur and Maloric
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceEntry`=@QUEST_LOOT;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=@SPELL2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,0,@QUEST_LOOT,0,24,1,@ENTRY,0,0,'','Item:Large Femur only target Maloric'),
(17,0,@SPELL2,0,9,@QUEST,0,0,0,'','Needs taken Quest 13654 to perform Spell: Search Maloric');

-- cast search Maloric, get quest item, quest completed
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=@ENTRY;
INSERT INTO `npc_spellclick_spells` VALUES
(@ENTRY,@SPELL2,@QUEST,1,@QUEST,2,0,0,0);
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_04_world_sai.sql 
-- -------------------------------------------------------- 
-- [Q] Scourgekabob
-- Despawn Mummy Bunny SAI
SET @ENTRY := 27931;
SET @SPELL_CREDIT := 50035;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts`  (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)  VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,11,@SPELL_CREDIT,0,0,0,0,0,7,0,0,0,0,0,0,0,'Despawn Mummy Bunny - Just Summoned - Quest Credit');

-- Fix an older sql guid
DELETE FROM `gameobject` WHERE `id`=192262; -- Jormunger Control Orb
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(173, 192262, 571, 1, 0x8, 8497.219, -90.90104, 789.2875, 0.1396245, 0, 0, 0.06975555, 0.9975641, 0, 0, 0);
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_05_world_sai.sql 
-- -------------------------------------------------------- 
-- Saronite Mine Slave SAI
SET @ENTRY := 31397;
SET @QUEST := 13300;
SET @GOSSIP := 10137;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,@GOSSIP,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Saronite Mine Slave - On Gossip Select - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,1,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Saronite Mine Slave - On Script - Close Gossip"),
(@ENTRY*100,9,1,0,0,0,100,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Saronite Mine Slave - On Script - Yell Line (random)"),
(@ENTRY*100,9,2,0,0,0,100,1,0,0,0,0,33,31866,0,0,0,0,0,0,0,0,0,0,0,0,0,"Saronite Mine Slave - On Script - Quest Credit"),
(@ENTRY*100,9,3,0,0,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,0,0,0,0,0,0,0,0,"Saronite Mine Slave - On Script - Force Despawn");

-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"AHAHAHAHA... you'll join us soon enough!",14,0,100,0,0,0,"Saronite Mine Slave"),
(@ENTRY,0,1,"I don't want to leave! I want to stay here!",14,0,100,0,0,0,"Saronite Mine Slave"),
(@ENTRY,0,2,"NO! You're wrong! The voices in my head are beautiful!",14,0,100,0,0,0,"Saronite Mine Slave"),
(@ENTRY,0,3,"My life for you!",14,0,100,0,0,0,"Saronite Mine Slave"),
(@ENTRY,0,4,"I'm coming, master!",14,0,100,0,0,0,"Saronite Mine Slave");

-- Actual story menu
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=14068;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,14068);

-- Insert option menu
DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`) VALUES
(@GOSSIP,0,0,"Go on, you're free. Get out of here!",1,1,0);

-- Only show gossip if player is on quest Slaves to Saronite
DELETE FROM `conditions` WHERE `SourceGroup`=@GOSSIP AND `ConditionValue1`=@QUEST;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@GOSSIP,0,0,9,@QUEST,0,0,0,'',"Only show first gossip if player is on quest Slaves to Saronite");
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_06_world_misc.sql 
-- -------------------------------------------------------- 
-- Prisoners of the Grimtotems
UPDATE `gameobject_template` SET `ScriptName`='go_blackhoof_cage'/*,`data2`=30000*/ WHERE `entry`=186287;
UPDATE `quest_template` SET `ReqSpellCast1`=0 WHERE `entry`=11145;
DELETE FROM `creature_text` WHERE `entry`=23720;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(23720,0,0,"Thank you! There's no telling what those brutes would've done to me.",12,0,100,18,0,0,"Theramore Prisoner");
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_07_world_sai.sql 
-- -------------------------------------------------------- 
-- Electromental SAI
SET @ENTRY := 21729;
SET @SPELL_LIGHTNING_BOLT := 37273;
SET @SPELL_MAGNETO_COLLECTOR := 37136;
SET @SPELL_ELECTROMENTAL_VISUAL := 37248;
SET @SPELL_SUMMON_ELECTROMENTAL := 37264;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,1,0,0,0,0,11,@SPELL_ELECTROMENTAL_VISUAL,1,0,0,0,0,1,0,0,0,0,0,0,0,"Electromental - Out Of Combat - Cast Power Converters: Electromental Visual"),
(@ENTRY,0,1,0,0,0,100,0,1000,2000,2400,3800,11,@SPELL_LIGHTNING_BOLT,1,0,0,0,0,2,0,0,0,0,0,0,0,"Electromental - In Combat - Cast Lightning Bolt"),
(@ENTRY,0,2,0,8,0,100,0,@SPELL_MAGNETO_COLLECTOR,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Electromental - on spellhit - increment event phase'),
(@ENTRY,0,3,0,6,1,100,0,0,0,0,0,33,21731,0,0,0,0,0,7,0,0,0,0,0,0,0,'Electromental - on death during phase 1 - give quest credit');

-- Insert spell
DELETE FROM `spell_dbc` WHERE `Id`=@SPELL_SUMMON_ELECTROMENTAL;
INSERT INTO `spell_dbc`(`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`) VALUES
(@SPELL_SUMMON_ELECTROMENTAL,0,0,256,0,0,0,0,0,0,0,0,1,0,0,101,0,0,0,0,26,1,0,-1,0,0,28,0,0,1,0,0,0,0,0,0,0,0,0,0,0,18,38,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,@ENTRY,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,'Power Converters: Summon Electromental');
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_08_world_sai.sql 
-- -------------------------------------------------------- 
-- Fix quest 12166: The Liquid Fire Of Elune
SET @SPELL := 46770;
SET @VISUAL := 47972;
SET @ITEM := 36956;
SET @ELK := 26616;
SET @GRIZZLY := 26643;
SET @ELKDUMMY = 27111;
SET @GRIZZLYDUMMY = 27112;

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ELK, @GRIZZLY);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ELK,@GRIZZLY) AND `source_type`=0;
DELETE FROM `creature_ai_scripts` WHERE `id` IN (2661601,2661602,2661603,2664301,2664302,2664303);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@GRIZZLY,0,0,1,8,0,100,0x01,@SPELL,0,0,0,33,@GRIZZLYDUMMY,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rabid Grizzly - On spell hit - Give kill credit for quest 12166'),
(@GRIZZLY,0,1,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Rabid Grizzly - Despawn after 5 seconds'),
(@ELK,0,0,1,8,0,100,0x01,@SPELL,0,0,0,33,@ELKDUMMY,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Blighted Elk - On spell hit - Give kill credit for quest 12166'),
(@ELK,0,1,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Blighted Elk - Despawn after 5 secondes');
 
-- Fix the quest item to allow it to only target the two quest NPCs
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceEntry`=@ITEM;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,0,@ITEM,0,24,2,@GRIZZLY,0,0,'','Item Elune Liquid Fire target Rabid Grizzly (dead)'),
(18,0,@ITEM,0,24,2,@ELK,0,0,'','Item Elune Liquid Fire target Blighted Elk (dead)');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=46770;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(46770, 47972, 1, 'Liquid Fire of Elune');
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_09_world_creatures.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `baseattacktime`=2000,`unit_flags`=`unit_flags`|0x8040,`equipment_id`=1014 WHERE `entry` IN (35309,35310); -- Argent Lightwielder
UPDATE `creature_template` SET `baseattacktime`=2000,`unit_flags`=`unit_flags`|0x8040,`equipment_id`=279 WHERE `entry` IN (35307,35308); -- Argent Priestess
UPDATE `creature_template` SET `baseattacktime`=1500,`unit_flags`=`unit_flags`|0x140,`equipment_id`=1926 WHERE `entry` IN (35451,35490); -- The Black Knight

UPDATE `creature_model_info` SET `bounding_radius`=0.208,`combat_reach`=1.5,`gender`=1 WHERE `modelid`=29763; -- Argent Lightwielder
UPDATE `creature_model_info` SET `bounding_radius`=0.208,`combat_reach`=1.5,`gender`=1 WHERE `modelid`=29761; -- Argent Priestess
UPDATE `creature_model_info` SET `bounding_radius`=0.766,`combat_reach`=3,`gender`=0 WHERE `modelid`=29837; -- The Black Knight

DELETE FROM `creature_template_addon` WHERE `entry` IN (35309,35307,35451);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(35309,0,0,1,0, NULL), -- Argent Lightwielder
(35307,0,0,1,0, NULL), -- Argent Priestess
(35451,0,0,1,0, NULL); -- The Black Knight

-- Related to last commit:
UPDATE `creature_model_info` SET `bounding_radius`=1.222,`combat_reach`=3,`gender`=0 WHERE `modelid`=23966; -- Rabid Grizzly
UPDATE `creature_model_info` SET `bounding_radius`=0.98,`combat_reach`=0.98,`gender`=0 WHERE `modelid`=23952; -- Blighted Elk
DELETE FROM `creature_template_addon` WHERE `entry` IN (26616,26643);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(26616,0,0,1,0, NULL), -- Blighted Elk
(26643,0,0,1,0, NULL); -- Rabid Grizzly
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_10_world_sai.sql 
-- -------------------------------------------------------- 
-- [Q] In the Name of Loken
-- Gavrock SAI
SET @ENTRY := 26420;
SET @QUEST := 12204;
SET @GOSSIP := 9485;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,@GOSSIP,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavrock - On Gossip Select - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Gavrock - On Script - Close Gossip"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavrock - On Script - Remove Gossip & Quest Flags"),
(@ENTRY*100,9,2,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavrock - On Script - Say Text 0"),
(@ENTRY*100,9,3,0,0,0,100,0,10000,10000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavrock - On Script - Say Text 1"),
(@ENTRY*100,9,4,0,0,0,100,0,15000,15000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavrock - On Script - Say Text 2"),
(@ENTRY*100,9,5,0,0,0,100,0,0,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Gavrock - On Script - Quest Credit"),
(@ENTRY*100,9,6,0,0,0,100,0,0,0,0,0,81,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavrock - On Script - Add Gossip & Quest Flags");

-- NPC talk text insert from sniff
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Ah, yes. Loken is well known to me.",12,0,100,0,0,0,"Gavrock"),
(@ENTRY,1,0,"It is he who commands the sons of iron in their war against us.",12,0,100,0,0,0,"Gavrock"),
(@ENTRY,2,0,"From his hiding place, he oversees their preparations for war with the goal of exterminating the stone giants!",12,0,100,0,0,0,"Gavrock");

-- Add gossip_menu_option condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`) VALUES
(15,@GOSSIP,0,9,@QUEST);

-- Hugh Glass SAI
SET @ENTRY := 26484;
SET @QUEST := 12204;
SET @GOSSIP := 9484;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,@GOSSIP,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hugh Glass - On Gossip Select - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Hugh Glass - On Script - Close Gossip"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hugh Glass - On Script - Remove Gossip & Quest Flags"),
(@ENTRY*100,9,2,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hugh Glass - On Script - Say Text 0"),
(@ENTRY*100,9,3,0,0,0,100,0,10000,10000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hugh Glass - On Script - Say Text 1"),
(@ENTRY*100,9,5,0,0,0,100,0,0,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Hugh Glass - On Script - Quest Credit"),
(@ENTRY*100,9,6,0,0,0,100,0,0,0,0,0,81,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hugh Glass - On Script - Add Gossip & Quest Flags");

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES
(@GOSSIP, 0, 0, 'Calm down, I want to ask you about the Iron Dwarves and Loken.', 1, 1, 0, 0, 0, 0, NULL);

-- NPC talk text insert from sniff
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`TEXT`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"He's out to get me, too! I'd be careful around here if I was you, traveler. You never know which tree he's hiding behind!",12,0,100,0,0,0,"Hugh Glass"),
(@ENTRY,1,0,"That's not something Limpy Joe would ask! But yeah, I know Loken.",12,0,100,0,0,0,"Hugh Glass");

-- Add gossip_menu_option condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`) VALUES
(15,@GOSSIP,0,9,@QUEST);
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_11_world_sai.sql 
-- -------------------------------------------------------- 
-- [Q] The Dreghood Elder
SET @ENTRY_AYLAAN := 20679;
SET @ENTRY_AKORU := 20678;
SET @ENTRY_MOROD := 20677;

-- Aylaan the Waterwalker - Akoru the Firecaller - Morod the Windstirrer SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ENTRY_AKORU,@ENTRY_AYLAAN,@ENTRY_MOROD);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY_AKORU,@ENTRY_AYLAAN,@ENTRY_MOROD);
INSERT INTO `smart_scripts`  (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)  VALUES
(@ENTRY_AYLAAN,0,0,0,62,0,100,0,8161,0,0,0,33,@ENTRY_AYLAAN,0,0,0,0,0,7,0,0,0,0,0,0,0,"Aylaan the Waterwalker - On Gossip Select - Quest Credit The Dreghood Elders"),
(@ENTRY_AYLAAN,0,1,0,62,0,100,0,8161,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Aylaan the Waterwalker - On gossip option select - Close gossip"),
(@ENTRY_AKORU,0,0,0,62,0,100,0,8163,0,0,0,33,@ENTRY_AKORU,0,0,0,0,0,7,0,0,0,0,0,0,0,"Akoru the Firecaller - On Gossip Select - Quest Credit The Dreghood Elders"),
(@ENTRY_AKORU,0,1,0,62,0,100,0,8163,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Akoru the Firecaller - On gossip option select - Close gossip"),
(@ENTRY_MOROD,0,0,0,62,0,100,0,8162,0,0,0,33,@ENTRY_MOROD,0,0,0,0,0,7,0,0,0,0,0,0,0,"Morod the Windstirrer - On Gossip Select - Quest Credit The Dreghood Elders"),
(@ENTRY_MOROD,0,1,0,62,0,100,0,8162,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Morod the Windstirrer - On gossip option select - Close gossip");

-- Only show first gossip if player is on quest The Dreghood Elders
DELETE FROM `conditions` WHERE `SourceGroup` IN (8161,8163,8162) AND `ConditionValue1` IN (10368);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,8161,0,0,9,10368,0,0,0,'',"Only show gossip if player is on quest The Dreghood Elders"),
(15,8163,0,0,9,10368,0,0,0,'',"Only show gossip if player is on quest The Dreghood Elders"),
(15,8162,0,0,9,10368,0,0,0,'',"Only show gossip if player is on quest The Dreghood Elders");
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_12_world_sai.sql 
-- -------------------------------------------------------- 
-- [Q] The Warm-Up
-- Kirgaraak SAI
SET @ENTRY := 29352;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;


DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=@ENTRY;
DELETE FROM smart_scripts WHERE source_type=9 AND entryorguid=@ENTRY*100;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,0,0,5,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,'Kirgaraak - At 5% HP - Run Script'),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,33,30221,0,0,0,0,0,7,0,0,0,0,0,0,0,'Kirgaraak - On Script - Quest Credit'),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kirgaraak - On Script - Make Friendly'),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kirgaraak - On Script - Evade'),
(@ENTRY*100,9,3,0,0,0,100,0,10000,10000,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kirgaraak - On Script - Reset Faction');

UPDATE `creature_template` SET `exp`=0 WHERE `entry`=24921; -- Cosmetic Trigger - LAB

UPDATE `creature_model_info` SET `bounding_radius`=2,`combat_reach`=7,`gender`=0 WHERE `modelid`=26202; -- Kirgaraak

DELETE FROM `creature_template_addon` WHERE `entry` IN (@ENTRY,29918,24921);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@ENTRY,0,0,1,0, NULL), -- Kirgaraak
(29918,0,0,1,0, NULL), -- Warbear Matriarch
(24921,0,0,1,0, NULL); -- Cosmetic Trigger - LAB

-- Not working correctly. It will work when spells get fixed
-- 1) Can't have more than one 54324 in the same target. 2) That aura gets removed when target enters in combat and it shouldn't
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=24921;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN -104008 AND -103996 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(-103996, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-103997, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-103998, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-103999, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104000, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104001, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104002, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104003, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104004, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104005, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104006, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104007, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104008, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak');
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_13_world_sai.sql 
-- -------------------------------------------------------- 
-- Quest:The Armor's Secrets (12980)
DELETE FROM `creature` WHERE `id`=30190;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(6337,30190,571,1,1,0,0,8256.75,-433.488,970.583,4.223697,300,0,0,1,0,0,0,0,0);

-- Anvil and Metel bars
DELETE FROM `gameobject` WHERE `id` IN (192125,192128);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(177,192125,571,1,1,8262.05,-430.288,968.272,0,0,0,-0.861628,0.507539,120,0,1),
(183,192125,571,1,1,8231.716,-451.452576,968.368835,-3.10665226,0,0,0,0,120,0,1),
(181,192128,571,1,1,8281.357,-432.069,970.723,-2.844883,0,0,-0.9890156,0.1478114,120,0,1),
(188,192128,571,1,1,8233.997,-434.379456,970.722961,-2.07693934,0,0,0,0,120,0,1),
(190,192128,571,1,1,8243.935,-429.880981,970.722961,-1.08210289,0,0,0,0,120,0,1),
(194,192128,571,1,1,8246.777,-424.707367,970.722961,-1.16936862,0,0,0,0,120,0,1),
(197,192128,571,1,1,8264.213,-432.40332,975.778564,1.134463,0,0,0,0,120,0,1);

-- Template updates
UPDATE `creature_template` SET `npcflag`=`npcflag`|1,`speed_run`=0.99206 WHERE `entry`=30190; -- Attendant Tock
UPDATE `creature_template` SET `speed_run`=0.99206 WHERE `entry`=30170; -- Mechagnome Attendant

-- Addon data
DELETE FROM `creature_template_addon` WHERE `entry` IN (30190,30170);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(30190,0,0,1,0,NULL), -- Mechagnome Attendant
(30170,0,7,1,0, NULL); -- Attendant Tock

SET @ENTRY=30190;
UPDATE `creature_template` SET `gossip_menu_id`=9880, `AIName`='SmartAI' WHERE entry=@ENTRY;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9880;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9880,0,0,'I found this strange armor plate. Can you tell me more about it?',1,1,0,0,0,0, '');

DELETE FROM `gossip_menu` WHERE `entry`=9880;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(9880,13703);

DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=@ENTRY*100;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,9880,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Start Script'),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Remove Gossip Flag'),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Close Gossip'),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,50,192132,77000,0,0,0,0,8,0,0,0,8262.029,-430.0284,974.1605,-2.757613, 'Attendant Tock - Summon Armor'),
(@ENTRY*100,9,3,0,0,0,100,0,4000,4000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 0'),
(@ENTRY*100,9,4,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 1'),
(@ENTRY*100,9,5,0,0,0,100,0,4000,4000,0,0,69,0,0,0,0,0,0,8,0,0,0,8262.029,-430.0284,976.1391,1.6, 'Attendant Tock - Move'), -- Move
(@ENTRY*100,9,6,0,0,0,100,0,15000,15000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 2'),
(@ENTRY*100,9,7,0,0,0,100,0,6000,6000,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 3'),
(@ENTRY*100,9,8,0,0,0,100,0,7000,7000,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 4'),
(@ENTRY*100,9,9,0,0,0,100,0,7000,7000,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 5'),
(@ENTRY*100,9,10,0,0,0,100,0,6000,6000,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 6'),
(@ENTRY*100,9,11,0,0,0,100,0,5000,5000,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 7'),
(@ENTRY*100,9,12,0,0,0,100,0,6000,6000,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 8'),
(@ENTRY*100,9,13,0,0,0,100,0,0,0,0,0,69,0,0,0,0,0,0,1,0,0,0,8256.75,-433.488,970.583,4.223697, 'Attendant Tock - Move Home'),
(@ENTRY*100,9,14,0,0,0,100,0,6000,6000,0,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 9'),
(@ENTRY*100,9,15,0,0,0,100,0,0,0,0,0,33,30190,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Attendant Tock - Quest Credit'),
(@ENTRY*100,9,16,0,0,0,100,0,0,0,0,0,82,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Add Gossip Flag');

DELETE FROM `creature_text` WHERE `entry`=30190;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(30190,0,0,'Metallic specimen of foreign origin detected.',12,0,100,0,5,0, 'Attendant Tock'),
(30190,1,0,'Beginning analysis...',12,0,100,0,0,0, 'Attendant Tock'),
(30190,2,0,'Specimen identified as an alloy of saronite and iron.',12,0,100,0,0,0, 'Attendant Tock'),
(30190,3,0,'The ore used in this sample originated deep wihin the crust of Azeroth and was recently unearthed.',12,0,100,275,0,0, 'Attendant Tock'),
(30190,4,0,'The saronite in this sample is nearly pure. Ores like this do not occur naturally on the surface of Azeroth.',12,0,100,0,0,0, 'Attendant Tock'),
(30190,5,0,'This ore can only have been created by a powerful, malevolent force. Attempting to access databanks for more information...',12,0,100,1,0,0, 'Attendant Tock'),
(30190,6,0,'Access denied?!',12,0,100,6,0,0, 'Attendant Tock'),
(30190,7,0,'Further information can only be accessed from the archives within Ulduar, by order of Keeper Loken.',12,0,100,1,0,0, 'Attendant Tock'),
(30190,8,0,'But one thing is for certain: this plate''s size, thickness, and bolt holes point to a use as armor for a colossal structure.',12,0,100,1,0,0, 'Attendant Tock'),
(30190,9,0,'Directive completed. Returning TO standby mode.',12,0,100,1,0,0, 'Attendant Tock');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9880;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,9880,0,0,9,12980,0,0,0, '', 'The Armor''s Secrets');
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_14_world_sai.sql 
-- -------------------------------------------------------- 
-- Quest: No Where to Run (12261)
-- SAI for Destructive Ward
SET @ENTRY :=27430;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=@ENTRY*100;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,0,0,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - On spawn Start Script'),
(@ENTRY*100,9,0,0,0,0,100,0,2000,2000,0,0,11,48715,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Skeleton'),
(@ENTRY*100,9,1,0,0,0,100,0,15000,15000,0,0,11,48715,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Skeleton'),
(@ENTRY*100,9,2,0,0,0,100,0,1000,1000,0,0,11,48735,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Ward Powerup'),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Raid Emote'),
(@ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,11,48733,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Pulse'),
(@ENTRY*100,9,5,0,0,0,100,0,15000,15000,0,0,11,48718,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Construct'),
(@ENTRY*100,9,6,0,0,0,100,0,15000,15000,0,0,11,48718,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Construct'),
(@ENTRY*100,9,7,0,0,0,100,0,1000,1000,0,0,11,48735,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Ward Powerup'),
(@ENTRY*100,9,8,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Raid Emote'),
(@ENTRY*100,9,9,0,0,0,100,0,0,0,0,0,11,48733,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Pulse'),
(@ENTRY*100,9,10,0,0,0,100,0,25000,25000,0,0,11,48715,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Skeleton'),
(@ENTRY*100,9,11,0,0,0,100,0,0,0,0,0,11,48715,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Skeleton'),
(@ENTRY*100,9,12,0,0,0,100,0,0,0,0,0,11,48718,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Construct'),
(@ENTRY*100,9,13,0,0,0,100,0,2000,2000,0,0,11,48735,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Ward Powerup'),
(@ENTRY*100,9,14,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Raid Emote'),
(@ENTRY*100,9,15,0,0,0,100,0,0,0,0,0,11,48734,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Barrage'),
(@ENTRY*100,9,16,0,0,0,100,0,1000,1000,0,0,11,48734,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Barrage'),
(@ENTRY*100,9,17,0,0,0,100,0,1000,1000,0,0,11,48734,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Barrage'),
(@ENTRY*100,9,18,0,0,0,100,0,0,0,0,0,11,52409,0,0,0,0,0,23,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Ward Kill Credit'),
(@ENTRY*100,9,19,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Despawn');

DELETE FROM `creature_text` WHERE `entry`=27430;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27430,0,0, 'The Destructive Ward gains in power.',41,0,100,0,0,0, 'Destructive Ward'),
(27430,1,0, 'The Destructive Ward is fully charged!',41,0,100,0,0,0, 'Destructive Ward');

-- Template update
UPDATE `creature_template` SET `exp`=2,`minlevel`=73,`maxlevel`=73,`unit_flags`=`unit_flags`|4|256,`speed_run`=1, RegenHealth=0 WHERE `entry`=27430; -- Destructive Ward

-- Model data
UPDATE `creature_model_info` SET `bounding_radius`=1,`combat_reach`=1,`gender`=2 WHERE `modelid`=25167; -- Destructive Ward
UPDATE `creature_model_info` SET `bounding_radius`=0.945,`combat_reach`=0.945,`gender`=0 WHERE `modelid`=23951; -- Snowfall Elk

-- Addon data
DELETE FROM `creature_template_addon` WHERE `entry` IN (27430,26615);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(26615,0,0,1,0, NULL), -- Snowfall Elk
(27430,0,0,1,0, NULL); -- Destructive Ward
 
 
-- -------------------------------------------------------- 
-- 2011_10_02_15_world_sai.sql 
-- -------------------------------------------------------- 
-- [Q] Brother Against Brother
-- Lakka SAI
SET @ENTRY := 18956;
SET @QUEST := 10097;
SET @GOSSIP := 7868;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100) AND `source_type` IN (0,9);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,@GOSSIP,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lakka - On Gossip Select - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Lakka - On Script - Close Gossip"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Lakka - On Script - Say Text 0"), -- Target_type_action_invoker because of <name>
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Lakka - On Script - Quest Credit"),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lakka - On Script - Despawn");

-- NPC talk text insert
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Thank you for freeing me, $N! I'm going to make my way to Shattrath!",12,0,100,0,0,0,"Lakka");

-- Add gossip_menu_option condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`) VALUES
(15,@GOSSIP,0,9,@QUEST);
 
 
-- -------------------------------------------------------- 
-- 2011_10_04_00_world_creature_loot_template.sql 
-- -------------------------------------------------------- 
-- Make Fjola drop two items from her loot table
-- 10 Normal
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=34497 AND `item`=2;
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=34497 AND `item`=1;
-- 25 Normal
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=35350 AND `item`=2;
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=35350 AND `item`=1;
-- 10 Heroic
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=35351 AND `item`=2;
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=35351 AND `item`=1;
-- 25 Herioc
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=35352 AND `item`=2;
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=35352 AND `item`=1;
 
 
-- -------------------------------------------------------- 
-- 2011_10_05_00_world_spell_linked_spell.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -58600;
 
 
-- -------------------------------------------------------- 
-- 2011_10_05_01_world_instance_misc.sql 
-- -------------------------------------------------------- 
DELETE FROM `creature_text` WHERE `entry` IN (36597,38995,38579,36823,39217);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(36597,0,0,'So the Light''s vaunted justice has finally arrived? Shall I lay down Frostmourne and throw myself at your mercy, Fordring?',14,0,0,0,0,17349,'The Lich King - SAY_LK_INTRO_1'),
(36597,1,0,'You''ll learn of that first hand. When my work is complete, you will beg for mercy -- and I will deny you. Your anguished cries will be testament to my unbridled power...',14,0,0,22,0,17350,'The Lich King - SAY_LK_INTRO_2'),
(36597,2,0,'I''ll keep you alive to witness the end, Fordring. I would not want the Light''s greatest champion to miss seeing this wretched world remade in my image.',14,0,0,0,0,17351,'The Lich King - SAY_LK_INTRO_3'),
(36597,3,0,'Come then champions, feed me your rage!',14,0,0,0,0,0,'The Lich King - SAY_LK_AGGRO'),
(36597,4,0,'I will freeze you from within until all that remains is an icy husk!',14,0,0,0,0,17369,'The Lich King - SAY_LK_REMORSELESS_WINTER'),
(36597,5,0,'Watch as the world around you collapses!',14,0,0,0,0,17370,'The Lich King - SAY_LK_QUAKE'),
(36597,6,0,'Val''kyr, your master calls!',14,0,0,0,0,17373,'The Lich King - SAY_LK_SUMMON_VALKYR'),
(36597,7,0,'Frostmourne hungers...',14,0,0,0,0,17366,'The Lich King - SAY_LK_HARVEST_SOUL'),
(36597,8,0,'Argh... Frostmourne, obey me!',14,0,0,0,0,17367,'The Lich King - SAY_LK_FROSTMOURNE_ESCAPE'),
(36597,9,0,'Frostmourne feeds on the soul of your fallen ally!',14,0,0,0,0,17368,'The Lich King - SAY_LK_FROSTMOURNE_KILL'),
(36597,10,0,'Hope wanes!',14,0,0,0,0,17363,'The Lich King - SAY_LK_KILL'),
(36597,10,1,'The end has come!',14,0,0,0,0,17364,'The Lich King - SAY_LK_KILL'),
(36597,11,0,'Face now your tragic end!',14,0,0,0,0,17365,'The Lich King - SAY_LK_BERSERK'),
(36597,12,0,'%s begins to cast Defile!',41,0,0,0,0,0,'The Lich King - EMOTE_DEFILE_WARNING'),
(36597,13,0,'|TInterface\\Icons\\ability_creature_disease_02.blp:16|tYou have been infected by |cFFCF00FFNecrotic Plague!|r',42,0,0,0,0,0,'The Lich King - EMOTE_NECROTIC_PLAGUE_WARNING'),
(36597,14,0,'No questions remain unanswered. No doubts linger. You ARE Azeroth''s greatest champions. You overcame every challenge I laid before you. My mightiest servants have fallen before your relentless onslaught... your unbridled fury...',14,0,0,0,0,17353,'The Lich King - SAY_LK_OUTRO_1'),
(36597,15,0,'Is it truly the righteousness that drives you? I wonder...',14,0,0,0,0,17354,'The Lich King - SAY_LK_OUTRO_2'),
(36597,16,0,'You trained them well, Fordring. You delivered the greatest fighting force this world has ever known... right into my hands -- exactly as I intended. You shall be rewarded for your unwitting sacrifice.',14,0,0,0,0,17355,'The Lich King - SAY_LK_OUTRO_3'),
(36597,17,0,'Watch now as I raise them from the dead to become masters of the Scourge. They will shroud this world in chaos and destruction. Azeroth''s fall will come at their hands -- and you will be the first to die.',14,0,0,0,0,17356,'The Lich King - SAY_LK_OUTRO_4'),
(36597,18,0,'I delight in the irony...',14,0,0,0,0,17357,'The Lich King - SAY_LK_OUTRO_5'),
(36597,19,0,'Impossible...',14,0,0,0,0,17358,'The Lich King - SAY_LK_OUTRO_6'),
(36597,20,0,'Now I stand, the lion before the lambs... and they do not fear.',14,0,0,0,0,17361,'The Lich King - SAY_LK_OUTRO_7'),
(36597,21,0,'They cannot fear.',14,0,0,0,0,17362,'The Lich King - SAY_LK_OUTRO_8'),
(38995,0,0,'We''ll grant you a swift death, Arthas. More than can be said for the thousands you''ve tortured and slain.',14,0,0,0,0,17390,'Highlord Tirion Fordring - SAY_TIRION_INTRO_1'),
(38995,1,0,'So be it. Champions, attack!',14,0,0,0,0,17391,'Highlord Tirion Fordring - SAY_TIRION_INTRO_2'),
(38995,2,0,'LIGHT, GRANT ME ONE FINAL BLESSING. GIVE ME THE STRENGTH... TO SHATTER THESE BONDS!',14,0,0,0,0,17392,'Highlord Tirion Fordring - SAY_TIRION_OUTRO_1'),
(38995,3,0,'No more, Arthas! No more lives will be consumed by your hatred!',14,0,0,0,0,17393,'Highlord Tirion Fordring - SAY_TIRION_OUTRO_2'),
(38579,0,0,'Free at last! It is over, my son. This is the moment of reckoning.',14,0,0,1,0,17397,'Terenas Menethil - SAY_TERENAS_OUTRO_1'),
(38579,1,0,'Rise up, champions of the Light!',14,0,0,0,0,17398,'Terenas Menethil - SAY_TERENAS_OUTRO_2'),
(36823,0,0,'You have come to bring Arthas to justice? To see the Lich King destroyed?',14,0,0,0,0,17394,'Terenas Menethil - SAY_TERENAS_INTRO_1'),
(36823,1,0,'First, you must escape Frostmourne''s hold, or be damned as I am; trapped within this cursed blade for all eternity.',14,0,0,0,0,17395,'Terenas Menethil - SAY_TERENAS_INTRO_2'),
(36823,2,0,'Aid me in destroying these tortured souls! Together we will loosen Frostmourne''s hold and weaken the Lich King from within!',14,0,0,0,0,17396,'Terenas Menethil - SAY_TERENAS_INTRO_3'),
(39217,0,0,'You have come to bring Arthas to justice? To see the Lich King destroyed?',14,0,0,0,0,17394,'Terenas Menethil - SAY_TERENAS_INTRO_1'),
(39217,1,0,'First, you must escape Frostmourne''s hold, or be damned as I am; trapped within this cursed blade for all eternity.',14,0,0,0,0,17395,'Terenas Menethil - SAY_TERENAS_INTRO_2');

-- Text corrections
DELETE FROM `creature_text` WHERE `entry`=36627 AND `groupid` IN (4,9);
DELETE FROM `creature_text` WHERE `entry`=36678 AND `groupid`=9;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(36627,4,0,'|TInterface\\Icons\\spell_shadow_unstableaffliction_2.blp:16|t%s begins to cast |cFFFF0000Unstable Ooze Explosion!|r',41,0,0,0,0,0,'Rotface - EMOTE_UNSTABLE_EXPLOSION'),
(36627,9,0,'|TInterface\\Icons\\ability_creature_disease_02.blp:16|tYou have |cFF00FF00Mutated Infection!|r',42,0,0,0,0,0,'Rotface - EMOTE_MUTATED_INFECTION'),
(36678,9,0,'|TInterface\\Icons\\inv_misc_herb_evergreenmoss.blp:16|t%s cast |cFF00FF00Malleable Goo!|r',41,0,0,0,0,0,'Professor Putricide - EMOTE_MALLEABLE_GOO');

UPDATE `creature_template` SET `speed_walk`=2,`speed_run`=1.71429,`exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=974,`faction_H`=974,`unit_flags`=768,`dynamicflags`=0,`equipment_id`=2425,`baseattacktime`=1500 WHERE `entry` IN (36597,39166,39167,39168); -- The Lich King
UPDATE `creature_template` SET `exp`=2,`unit_class`=2 WHERE `entry`=38995; -- Highlord Tirion Fordring
UPDATE `creature_template` SET `speed_walk`=1.2,`speed_run`=0.428571,`exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`dynamicflags`=0 WHERE `entry` IN (36633,39305,39306,39307); -- Ice Sphere
UPDATE `creature_template` SET `speed_walk`=2,`speed_run`=1.42857,`exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=14,`faction_H`=14,`dynamicflags`=0 WHERE `entry`=36701; -- Raging Spirit
UPDATE `creature_template` SET `speed_walk`=1.2,`speed_run`=0.428571,`exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`dynamicflags`=0,`unit_flags`=33554944 WHERE `entry`=38757; -- Defile
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`faction_A`=14,`faction_H`=14,`speed_walk`=2,`speed_run`=1.71429,`unit_flags`=33554944,`dynamicflags`=0,`VehicleId`=532,`InhabitType`=1|4 WHERE `entry` IN (36609,39120,39121,39122); -- Val'kyr Shadowguard
UPDATE `creature_template` SET `speed_walk`=2,`speed_run`=1.71429,`exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=35,`faction_H`=35,`unit_flags`=33554944,`dynamicflags`=0,`VehicleId`=531,`InhabitType`=1|4,`flags_extra`=0 WHERE `entry`=36598; -- Strangulate Vehicle
UPDATE `creature_template` SET `speed_walk`=1.2,`speed_run`=0.428571,`exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`unit_flags`=33554944,`dynamicflags`=0,`flags_extra`=128 WHERE `entry`=38584; -- Frostmourne Trigger
UPDATE `creature_template` SET `speed_walk`=2.8,`speed_run`=1,`exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`unit_flags`=32832,`dynamicflags`=0,`flags_extra`=256,`InhabitType`=1|4 WHERE `entry` IN (37799,39284,39285,39286); -- Vile Spirit
UPDATE `creature_template` SET `speed_walk`=1,`speed_run`=1,`exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=1665,`faction_H`=1665,`unit_flags`=32832,`dynamicflags`=0,`flags_extra`=0,`equipment_id`=2475 WHERE `entry` IN (36823,38579,39217); -- Terenas Menethil
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry`=24648; -- Invisible Stalker (Scale x2)
UPDATE `creature_template` SET `difficulty_entry_1`=39287,`difficulty_entry_2`=39288,`difficulty_entry_3`=39289 WHERE `entry`=39190; -- Wicked Spirit
UPDATE `creature_template` SET `speed_walk`=2.8,`speed_run`=1,`exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`unit_flags`=32832,`dynamicflags`=0,`flags_extra`=256,`InhabitType`=1|4 WHERE `entry` IN (39190,39287,39288,39289); -- Wicked Spirit
UPDATE `creature_template` SET `exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=14,`faction_H`=14,`dynamicflags`=0,`flags_extra`=256 WHERE `entry`=36824; -- Spirit Warden
UPDATE `creature_template` SET `exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=14,`faction_H`=14,`dynamicflags`=0,`flags_extra`=128 WHERE `entry`=39137; -- Shadow Trap
UPDATE `creature_template` SET `exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`InhabitType`=1|4,`flags_extra`=`flags_extra`|128 WHERE `entry`=39189; -- Spirit Bomb

-- HACK, Unit::_IsValidAttackTarget returns false because of UNIT_FLAG_OOC_NOT_ATTACKABLE flag
UPDATE `creature_template` SET `unit_flags`=0x02000000 WHERE `entry`=36171;

UPDATE `creature_model_info` SET `combat_reach`=5.5 WHERE `modelid`=30721; -- The Lich King
UPDATE `creature_model_info` SET `gender`=0 WHERE `modelid`=31286; -- Highlord Tirion Fordring

DELETE FROM `creature` WHERE `guid`=202865;
DELETE FROM `creature_addon` WHERE `guid`=150211;
INSERT INTO `creature_addon` (`guid`,`bytes1`,`auras`) VALUES
(150211,1,'72846 73220 73878'); -- The Lich King

DELETE FROM `creature_template_addon` WHERE `entry` IN (39137,36609,39120,39121,39122,36598,37799,39284,39285,39286,39190,39287,39288,39289,36823,38579,39217,39189);
INSERT INTO `creature_template_addon` (`entry`,`bytes1`,`auras`) VALUES
(39137,0,'73530'),
(36609,50331648,''), -- Val'kyr Shadowguard
(39120,50331648,''), -- Val'kyr Shadowguard
(39121,50331648,''), -- Val'kyr Shadowguard
(39122,50331648,''), -- Val'kyr Shadowguard
(36598,50331648,''), -- Strangulate Vehicle
(37799,50331648,''), -- Vile Spirit
(39284,50331648,''), -- Vile Spirit
(39285,50331648,''), -- Vile Spirit
(39286,50331648,''), -- Vile Spirit
(39190,50331648,''), -- Wicked Spirit
(39287,50331648,''), -- Wicked Spirit
(39288,50331648,''), -- Wicked Spirit
(39289,50331648,''), -- Wicked Spirit
(36823,0,'72372'), -- Terenas Menethil
(38579,0,'72372'), -- Terenas Menethil
(39217,0,'72372'), -- Terenas Menethil
(39189,0,'73572'); -- Spirit Bomb

UPDATE `gameobject` SET `rotation3`=1,`animprogress`=255,`spawntimesecs`=604800 WHERE `guid` IN (100056,100061,100064);
UPDATE `gameobject` SET `rotation2`=1,`animprogress`=255,`spawntimesecs`=604800 WHERE `guid` IN (100057,100058,100059,100060,100062);
UPDATE `gameobject` SET `rotation3`=1,`animprogress`=255,`spawntimesecs`=-604800 WHERE `guid`=100063;

UPDATE `gameobject_template` SET `faction`=1375,`flags`=32 WHERE `entry`=202438; -- Lavaman Pillars (Unchained)
UPDATE `gameobject_template` SET `faction`=1375,`flags`=32 WHERE `entry`=202188; -- Doodad_Icecrown_ThroneFrostyWind01
UPDATE `gameobject_template` SET `faction`=1375,`flags`=32 WHERE `entry`=202189; -- Doodad_Icecrown_ThroneFrostyEdge01

DELETE FROM `gameobject` WHERE `id`=202438;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`position_x`,`position_y`,`position_z`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(100488,202438,631,15,425.0885,-2123.311,858.6748,1,-604800,255,1);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (71614,70338,73785,73786,73787,68981,74270,74271,74272,72262,71440,76379,74086,72595,73650,72679,74318,74319,74320,73028,74321,74322,74323,73582,71809,71811,72431,72405,72429,73159);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,71614,0,18,1,38995,0,0, '', 'Ice Lock - target Highlord Tirion Fordring'),
(13,0,70338,0,18,1,0,0,0, '', 'Necrotic Plague - target player'),
(13,0,70338,0,18,1,37698,0,0, '', 'Necrotic Plague - target Shambling Horror'),
(13,0,70338,0,18,1,37695,0,0, '', 'Necrotic Plague - target Drudge Ghoul'),
(13,0,73785,0,18,1,0,0,0, '', 'Necrotic Plague - target player'),
(13,0,73785,0,18,1,37698,0,0, '', 'Necrotic Plague - target Shambling Horror'),
(13,0,73785,0,18,1,37695,0,0, '', 'Necrotic Plague - target Drudge Ghoul'),
(13,0,73786,0,18,1,0,0,0, '', 'Necrotic Plague - target player'),
(13,0,73786,0,18,1,37698,0,0, '', 'Necrotic Plague - target Shambling Horror'),
(13,0,73786,0,18,1,37695,0,0, '', 'Necrotic Plague - target Drudge Ghoul'),
(13,0,73787,0,18,1,0,0,0, '', 'Necrotic Plague - target player'),
(13,0,73787,0,18,1,37698,0,0, '', 'Necrotic Plague - target Shambling Horror'),
(13,0,73787,0,18,1,37695,0,0, '', 'Necrotic Plague - target Drudge Ghoul'),
(13,0,68981,0,18,0,202141,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing02'),
(13,0,68981,0,18,0,202142,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing01'),
(13,0,68981,0,18,0,202143,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing03'),
(13,0,68981,0,18,0,202144,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing04'),
(13,0,74270,0,18,0,202141,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing02'),
(13,0,74270,0,18,0,202142,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing01'),
(13,0,74270,0,18,0,202143,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing03'),
(13,0,74270,0,18,0,202144,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing04'),
(13,0,74271,0,18,0,202141,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing02'),
(13,0,74271,0,18,0,202142,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing01'),
(13,0,74271,0,18,0,202143,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing03'),
(13,0,74271,0,18,0,202144,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing04'),
(13,0,74272,0,18,0,202141,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing02'),
(13,0,74272,0,18,0,202142,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing01'),
(13,0,74272,0,18,0,202143,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing03'),
(13,0,74272,0,18,0,202144,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing04'),
(13,0,72262,0,18,1,22515,0,0, '', 'Quake - target World Trigger'),
(13,0,71440,0,18,1,36597,0,0, '', 'Harvest Soul - target The Lich King'),
(13,0,76379,0,18,1,36597,0,0, '', 'Harvest Soul - target The Lich King'),
(13,0,74086,0,18,1,0,0,0, '', 'Destroy Soul - target player'),
(13,0,72595,0,18,1,0,0,0, '', 'Restore Soul - target player'),
(13,0,73650,0,18,1,0,0,0, '', 'Restore Soul - target player'),
(13,0,72679,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,74318,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,74319,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,74320,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,73028,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,74321,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,73650,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,74323,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,73582,0,18,1,39190,0,0, '', 'Trigger Vile Spirit (Inside, Heroic) - target Wicked Spirit'),
(13,0,71809,0,18,1,36597,0,0, '', 'Jump - target The Lich King'),
(13,0,71811,0,18,1,36597,0,0, '', 'Jump - target The Lich King'),
(13,0,72431,0,18,1,0,0,0, '', 'Jump - target player'),
(13,0,72405,0,18,1,38995,0,0, '', 'Broken Frostmourne - target Highlord Tirion Fordring'),
(13,0,72429,0,18,1,0,0,0, '', 'Mass Resurrection - target player'),
(13,0,73159,0,18,1,0,0,0, '', 'Play Movie - target player');

DELETE FROM `spell_target_position` WHERE `id` IN (70860,72546,73655);
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(70860,631,529.302,-2124.49, 840.857,3.1765), -- Frozen Throne Teleport
(72546,631,514.000,-2523.00,1050.990,3.1765), -- Harvest Soul (normal mode)
(73655,631,495.708,-2523.76,1050.990,3.1765); -- Harvest Soul (heroic mode)

DELETE FROM `spell_area` WHERE `spell`=74276;
INSERT INTO `spell_area` (`spell`,`area`,`autocast`) VALUES
(74276,4910,1); -- In Frostmourne Room

DELETE FROM `disables` WHERE `entry` IN (12825,13246,13247,13244,13245,13342,13309,13362,13311,12823,13163,13164,13243,12764,12909,12826,13103,13136,13137,13138,12818) AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (12825,13246,13247,13244,13245,13342,13309,13362,13311,12823,13163,13164,13243,12764,12909,12826,13103,13136,13137,13138,12818);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(12825,12,2,0,''), -- Bane of the Fallen King
(13246,11,0,0,'achievement_been_waiting_long_time'), -- Been Waiting a Long Time for This (10 player)
(13246,12,0,0,''), -- Been Waiting a Long Time for This (10 player)
(13247,11,0,0,'achievement_been_waiting_long_time'), -- Been Waiting a Long Time for This (10 player) Heroic
(13247,12,2,0,''), -- Been Waiting a Long Time for This (10 player) Heroic
(13244,11,0,0,'achievement_been_waiting_long_time'), -- Been Waiting a Long Time for This (25 player)
(13244,12,1,0,''), -- Been Waiting a Long Time for This (25 player)
(13245,11,0,0,'achievement_been_waiting_long_time'), -- Been Waiting a Long Time for This (25 player) Heroic
(13245,12,3,0,''), -- Been Waiting a Long Time for This (25 player) Heroic
(13342,12,0,0,''), -- Lich King 10-player bosses killed
(13309,12,0,0,''), -- Lich King 10-player raids completed (final boss killed)
(13362,12,1,0,''), -- Lich King 25-player bosses killed
(13311,12,1,0,''), -- Lich King 25-player raids completed (final boss killed)
(12823,11,0,0,'achievement_neck_deep_in_vile'), -- Neck-Deep in Vile (10 player)
(12823,12,0,0,''), -- Neck-Deep in Vile (10 player)
(13163,11,0,0,'achievement_neck_deep_in_vile'), -- Neck-Deep in Vile (10 player) Heroic
(13163,12,2,0,''), -- Neck-Deep in Vile (10 player) Heroic
(13164,11,0,0,'achievement_neck_deep_in_vile'), -- Neck-Deep in Vile (25 player)
(13164,12,1,0,''), -- Neck-Deep in Vile (25 player)
(13243,11,0,0,'achievement_neck_deep_in_vile'), -- Neck-Deep in Vile (25 player) Heroic
(13243,12,3,0,''), -- Neck-Deep in Vile (25 player) Heroic
(12764,12,0,0,''), -- The Frozen Throne (10 player)
(12909,12,1,0,''), -- The Frozen Throne (25 player)
(12826,12,3,0,''), -- The Light of Dawn
(13103,12,0,0,''), -- Victories over the Lich King (Icecrown 10 player)
(13136,12,1,0,''), -- Victories over the Lich King (Icecrown 25 player)
(13137,12,2,0,''), -- Victories over the Lich King (Heroic Icecrown 10 player)
(13138,12,3,0,''), -- Victories over the Lich King (Heroic Icecrown 25 player)
(12818,12,3,0,''); -- Realm First! Fall of the Lich King
 
 
-- -------------------------------------------------------- 
-- 2011_10_05_01_world_scriptname.sql 
-- -------------------------------------------------------- 
UPDATE `creature_template` SET `ScriptName`='boss_the_lich_king' WHERE `entry`=36597;
UPDATE `creature_template` SET `ScriptName`='npc_tirion_fordring_tft' WHERE `entry`=38995;
UPDATE `creature_template` SET `ScriptName`='npc_shambling_horror_icc' WHERE `entry`=37698;
UPDATE `creature_template` SET `ScriptName`='npc_raging_spirit' WHERE `entry`=36701;
UPDATE `creature_template` SET `ScriptName`='npc_valkyr_shadowguard' WHERE `entry`=36609;
UPDATE `creature_template` SET `ScriptName`='npc_strangulate_vehicle' WHERE `entry`=36598;
UPDATE `creature_template` SET `ScriptName`='npc_terenas_menethil' WHERE `entry` IN (36823,38579,39217); -- not difficulty_entries
UPDATE `creature_template` SET `ScriptName`='npc_spirit_warden' WHERE `entry`=36824;
UPDATE `creature_template` SET `ScriptName`='npc_spirit_bomb' WHERE `entry`=39189;
UPDATE `creature_template` SET `ScriptName`='npc_broken_frostmourne' WHERE `entry`=38584;
 
 
-- -------------------------------------------------------- 
-- 2011_10_05_01_world_spell_script_names.sql 
-- -------------------------------------------------------- 
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_infest';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_necrotic_plague';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_necrotic_plague_jump';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_shadow_trap_visual';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_shadow_trap_periodic';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_quake';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_ice_burst_target_search';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_raging_spirit';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_defile';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_summon_into_air';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_soul_reaper';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_valkyr_target_search';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_eject_all_passengers';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_cast_back_to_caster';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_life_siphon';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_vile_spirits';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_vile_spirits_visual';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_vile_spirit_move_target_search';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_vile_spirit_damage_target_search';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_harvest_soul';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_lights_favor';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_soul_rip';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_restore_soul';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_in_frostmourne_room';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_summon_spirit_bomb';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_trigger_vile_spirit';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_jump';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_jump_remove_aura';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_mass_resurrection';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_play_movie';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(70541,'spell_the_lich_king_infest'),
(73779,'spell_the_lich_king_infest'),
(73780,'spell_the_lich_king_infest'),
(73781,'spell_the_lich_king_infest'),
(70337,'spell_the_lich_king_necrotic_plague'),
(73912,'spell_the_lich_king_necrotic_plague'),
(73913,'spell_the_lich_king_necrotic_plague'),
(73914,'spell_the_lich_king_necrotic_plague'),
(70338,'spell_the_lich_king_necrotic_plague_jump'),
(73785,'spell_the_lich_king_necrotic_plague_jump'),
(73786,'spell_the_lich_king_necrotic_plague_jump'),
(73787,'spell_the_lich_king_necrotic_plague_jump'),
(73530,'spell_the_lich_king_shadow_trap_visual'),
(74282,'spell_the_lich_king_shadow_trap_periodic'),
(72262,'spell_the_lich_king_quake'),
(69110,'spell_the_lich_king_ice_burst_target_search'),
(69200,'spell_the_lich_king_raging_spirit'),
(72754,'spell_the_lich_king_defile'),
(73708,'spell_the_lich_king_defile'),
(73709,'spell_the_lich_king_defile'),
(73710,'spell_the_lich_king_defile'),
(69037,'spell_the_lich_king_summon_into_air'),
(70497,'spell_the_lich_king_summon_into_air'),
(73579,'spell_the_lich_king_summon_into_air'),
(74300,'spell_the_lich_king_summon_into_air'),
(69409,'spell_the_lich_king_soul_reaper'),
(73797,'spell_the_lich_king_soul_reaper'),
(73798,'spell_the_lich_king_soul_reaper'),
(73799,'spell_the_lich_king_soul_reaper'),
(69030,'spell_the_lich_king_valkyr_target_search'),
(68576,'spell_the_lich_king_eject_all_passengers'),
(74445,'spell_the_lich_king_cast_back_to_caster'),
(68984,'spell_the_lich_king_cast_back_to_caster'),
(73488,'spell_the_lich_king_life_siphon'),
(73782,'spell_the_lich_king_life_siphon'),
(73783,'spell_the_lich_king_life_siphon'),
(73784,'spell_the_lich_king_life_siphon'),
(70498,'spell_the_lich_king_vile_spirits'),
(70499,'spell_the_lich_king_vile_spirits_visual'),
(70501,'spell_the_lich_king_vile_spirit_move_target_search'),
(70534,'spell_the_lich_king_vile_spirit_damage_target_search'),
(68980,'spell_the_lich_king_harvest_soul'),
(74325,'spell_the_lich_king_harvest_soul'),
(74296,'spell_the_lich_king_harvest_soul'),
(74297,'spell_the_lich_king_harvest_soul'),
(69382,'spell_the_lich_king_lights_favor'),
(69397,'spell_the_lich_king_soul_rip'),
(72595,'spell_the_lich_king_restore_soul'),
(73650,'spell_the_lich_king_restore_soul'),
(74276,'spell_the_lich_king_in_frostmourne_room'),
(74302,'spell_the_lich_king_summon_spirit_bomb'),
(74341,'spell_the_lich_king_summon_spirit_bomb'),
(74342,'spell_the_lich_king_summon_spirit_bomb'),
(74343,'spell_the_lich_king_summon_spirit_bomb'),
(73582,'spell_the_lich_king_trigger_vile_spirit'),
(71811,'spell_the_lich_king_jump'),
(72431,'spell_the_lich_king_jump_remove_aura'),
(72429,'spell_the_lich_king_mass_resurrection'),
(73159,'spell_the_lich_king_play_movie');
 
 
-- -------------------------------------------------------- 
-- 2011_10_06_00_world_creature_template.sql 
-- -------------------------------------------------------- 
/*
Approximate damage of NPCs before armor reduction
75k-90k - The Lich King
25k-30k - Shambling Horror
3.5-5k - Drudge Ghoul
30k-40k - Raging Spirit
10k-12k - Spirit Warden
10k-12k - Terenas Menethil

Multipliers
1.2 = 10H/25N
1.5 = 25H
*/

UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=150 WHERE `entry`=36597; -- The Lich King 10N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=180 WHERE `entry`=39167; -- The Lich King 25N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=180 WHERE `entry`=39168; -- The Lich King 10H
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=225 WHERE `entry`=39169; -- The Lich King 25H

UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=50 WHERE `entry`=37698; -- Shambling Horror 10N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=60 WHERE `entry`=39299; -- Shambling Horror 25N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=60 WHERE `entry`=39300; -- Shambling Horror 10H
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=75 WHERE `entry`=39301; -- Shambling Horror 25H

UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=7 WHERE `entry`=37695; -- Drudge Ghoul 10N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=8.4 WHERE `entry`=39309; -- Drudge Ghoul 25N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=8.4 WHERE `entry`=39310; -- Drudge Ghoul 10H
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=10.5 WHERE `entry`=39311; -- Drudge Ghoul 25H

UPDATE `creature_template` SET `difficulty_entry_1`=39302,`difficulty_entry_2`=39303,`difficulty_entry_3`=39304 WHERE `entry`=36701; -- Raging Spirit
UPDATE `creature_template` SET `speed_walk`=2,`speed_run`=1.42857,`exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=14,`faction_H`=14,`dynamicflags`=0 WHERE `entry` IN (39302,39303,39304); -- Raging Spirit
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=60 WHERE `entry`=36701; -- Raging Spirit 10N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=72 WHERE `entry`=39302; -- Raging Spirit 25N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=72 WHERE `entry`=39303; -- Raging Spirit 10H
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=90 WHERE `entry`=39304; -- Raging Spirit 25H

UPDATE `creature_template` SET `difficulty_entry_1`=39296 WHERE `entry`=36824; -- Spirit Warden
UPDATE `creature_template` SET `minlevel`=83,`maxlevel`=83,`exp`=2,`faction_A`=14,`faction_H`=14,`flags_extra`=256 WHERE `entry`=39296; -- Spirit Warden (1)
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=20 WHERE `entry`=36824; -- Spirit Warden 10N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=20 WHERE `entry`=39296; -- Spirit Warden 25N

UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=20 WHERE `entry`=36823; -- Terenas Menethil
 
 
-- -------------------------------------------------------- 
-- 2011_10_06_01_world_misc.sql 
-- -------------------------------------------------------- 
-- Pathing for Conquest Hold Berserker Entry: 27500
SET @NPC := 105857;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2721.081,`position_y`=-1832.136,`position_z`=4.838899 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2710.015,-1832.177,4.838899,0,0,0,100,0),
(@PATH,2,2700.421,-1833.964,4.838899,0,0,0,100,0),
(@PATH,3,2693.419,-1835.334,4.867931,0,0,0,100,0),
(@PATH,4,2700.177,-1834.009,4.838899,0,0,0,100,0),
(@PATH,5,2710.015,-1832.177,4.838899,0,0,0,100,0),
(@PATH,6,2721.081,-1832.136,4.838899,0,0,0,100,0),
(@PATH,7,2732.511,-1831.47,4.838899,0,0,0,100,0),
(@PATH,8,2737.419,-1830.768,4.838899,0,0,0,100,0),
(@PATH,9,2732.511,-1831.47,4.838899,0,0,0,100,0),
(@PATH,10,2721.081,-1832.136,4.838899,0,0,0,100,0);
-- Pathing for Conquest Hold Berserker Entry: 27500
SET @NPC := 105821;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2738.191,`position_y`=-1784.905,`position_z`=5.87062 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2734.5,-1775.514,6.962903,0,0,0,100,0),
(@PATH,2,2738.191,-1784.905,5.87062,0,0,0,100,0),
(@PATH,3,2741.883,-1793.762,5.804742,0,0,0,100,0),
(@PATH,4,2746.422,-1807.012,5.22166,0,0,0,100,0),
(@PATH,5,2748.496,-1816.049,5.223536,0,0,0,100,0),
(@PATH,6,2750.136,-1823.419,5.425339,0,0,0,100,0),
(@PATH,7,2748.496,-1816.049,5.223536,0,0,0,100,0),
(@PATH,8,2746.422,-1807.012,5.22166,0,0,0,100,0),
(@PATH,9,2741.883,-1793.762,5.804742,0,0,0,100,0),
(@PATH,10,2738.191,-1784.905,5.87062,0,0,0,100,0);
-- Pathing for Conquest Hold Berserker Entry: 27500
SET @NPC := 105859;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2753.638,`position_y`=-1895.846,`position_z`=5.03679 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2754.177,-1888.177,5.087607,0,0,0,100,0),
(@PATH,2,2754.56,-1879.827,5.126619,0,0,0,100,0),
(@PATH,3,2754.854,-1867.842,5.131936,0,0,0,100,0),
(@PATH,4,2754.627,-1856.456,5.450566,0,0,0,100,0),
(@PATH,5,2753.946,-1848.716,5.450566,0,0,0,100,0),
(@PATH,6,2751.545,-1837.476,5.39562,0,0,0,100,0),
(@PATH,7,2753.931,-1848.54,5.450566,0,0,0,100,0),
(@PATH,8,2754.627,-1856.456,5.450566,0,0,0,100,0),
(@PATH,9,2754.854,-1867.842,5.131936,0,0,0,100,0),
(@PATH,10,2754.56,-1879.827,5.126619,0,0,0,100,0),
(@PATH,11,2754.177,-1888.177,5.087607,0,0,0,100,0),
(@PATH,12,2753.638,-1895.846,5.03679,0,0,0,100,0);
-- Pathing for Conquest Hold Berserker Entry: 27500
SET @NPC := 105810;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2805.754,`position_y`=-1824.487,`position_z`=10.76279 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2811.704,-1833.185,11.26279,0,0,0,100,0),
(@PATH,2,2825.015,-1839.888,11.25652,0,0,0,100,0),
(@PATH,3,2811.704,-1833.185,11.26279,0,0,0,100,0),
(@PATH,4,2805.754,-1824.487,10.76279,0,0,0,100,0),
(@PATH,5,2806.472,-1815.43,10.76279,0,0,0,100,0),
(@PATH,6,2806.509,-1806.167,10.63779,0,0,0,100,0),
(@PATH,7,2806.472,-1815.43,10.76279,0,0,0,100,0),
(@PATH,8,2805.754,-1824.487,10.76279,0,0,0,100,0);
-- Pathing for Conquest Hold Berserker Entry: 27500
SET @NPC := 105750;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2691.886,`position_y`=-1764.669,`position_z`=9.601107 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2681.84,-1768.02,9.601107,0,0,0,100,0),
(@PATH,2,2691.886,-1764.669,9.601107,0,0,0,100,0),
(@PATH,3,2705.537,-1760.065,9.601107,0,0,0,100,0),
(@PATH,4,2714.329,-1758.981,9.601107,0,0,0,100,0),
(@PATH,5,2705.537,-1760.065,9.601107,0,0,0,100,0),
(@PATH,6,2691.886,-1764.669,9.601107,0,0,0,100,0);
-- Pathing for Conquest Hold Berserker Entry: 27500
SET @NPC := 105854;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2683.998,`position_y`=-1873.36,`position_z`=14.20639 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2681.924,-1863.327,14.19665,0,0,0,100,0),
(@PATH,2,2691.357,-1860.246,13.94065,0,0,0,100,0),
(@PATH,3,2705.164,-1860.508,13.85815,0,0,0,100,0),
(@PATH,4,2706.999,-1867.629,13.94356,0,0,0,100,0),
(@PATH,5,2702.301,-1873.661,13.86975,0,0,0,100,0),
(@PATH,6,2690.931,-1875.133,13.94601,0,0,0,100,0),
(@PATH,7,2683.998,-1873.36,14.20639,0,0,0,100,0);

-- Pathing for Westfall Brigade Marine Entry: 27501
SET @NPC := 105933;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2670.551,`position_y`=-2010.984,`position_z`=18.17214 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2673.404,-2006.613,18.2068,0,0,0,100,0),
(@PATH,2,2670.639,-2010.848,18.17313,0,0,0,100,0),
(@PATH,3,2667.047,-2016.413,18.20223,0,0,0,100,0),
(@PATH,4,2670.551,-2010.984,18.17214,0,0,0,100,0);
-- Pathing for Westfall Brigade Marine Entry: 27501
SET @NPC := 105932;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2633.481,`position_y`=-1987.501,`position_z`=8.764043 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2632.814,-1993.635,8.538836,0,0,0,100,0),
(@PATH,2,2638.163,-1998.093,8.282835,0,0,0,100,0),
(@PATH,3,2643.552,-2000.655,8.280496,0,0,0,100,0),
(@PATH,4,2646.837,-1997.753,8.30875,0,0,0,100,0),
(@PATH,5,2649.113,-1994.113,8.310638,0,0,0,100,0),
(@PATH,6,2649.836,-1989.002,8.284628,0,0,0,100,0),
(@PATH,7,2645.433,-1984.703,8.336969,0,0,0,100,0),
(@PATH,8,2638.931,-1981.989,8.592985,0,0,0,100,0),
(@PATH,9,2633.481,-1987.501,8.764043,0,0,0,100,0);

-- Missing spawn for Purkom "Venture Coin Vendor" Horde
DELETE FROM `creature` WHERE `id`=27730;
DELETE FROM `creature` WHERE `guid`=107018 AND `id`=27511;
INSERT INTO creature (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(107018,27730,571,1,1,0,0,2492.467,-1839.655,11.72851,5.532694,120,0,0,1,0,0);

-- Rogue Voidwalkers Shouldn't have weapons
UPDATE `creature_template` SET `equipment_id`=0 WHERE `entry`=16974;

-- Add Missing Spawn
DELETE FROM `creature` WHERE `guid` IN (13425,13426,13427,13428,14241);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
-- Bubb Lazarr
(13425,27628,571,1,1,0,0,2404.771,-1823.437,1.99793,5.078908,300,0,0,1,0,0),
-- Rocket Propelled Warhead
(13426,27593,571,1,1,0,0,2394.92358,-1832.18921,-1.69907868,2.687807,300,0,0,1,0,0),
(13427,27593,571,1,1,0,0,2396.13013,-1829.49475,-1.6780616,2.75762,300,0,0,1,0,0),
(13428,27593,571,1,1,0,0,2397.40283,-1826.75,-1.65229559,2.72271371,300,0,0,1,0,0),
(14241,27593,571,1,1,0,0,2398.62329,-1824.14063,-1.66098964,2.740167,300,0,0,1,0,0);

-- Template updates Rocket Propelled Warhead
UPDATE `creature_template` SET `npcflag`=`npcflag`|16777216,`InhabitType`=4,`unit_flags`=`unit_flags`|16384,`speed_walk`=12,`speed_run`=4.28571 WHERE `entry`=27593;

UPDATE `creature_model_info` SET `bounding_radius`=0.534723,`combat_reach`=3.5,`gender`=2 WHERE `modelid`=26611; -- Rocket Propelled Warhead

DELETE FROM `creature_template_addon` WHERE `entry`=27593;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(27593,0,0,1,0, NULL); -- Rocket Propelled Warhead

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=27593;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `quest_start`, `quest_start_active`, `quest_end`, `cast_flags`, `aura_required`, `aura_forbidden`, `user_type`) VALUES
(27593, 49177, 0, 0, 0, 1, 0, 0, 0); -- Ride Rocket Propelled Warhead

-- Fix requirements for Element 115 from Nayd
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=4 AND `SourceEntry`=37664;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 24095, 37664, 0, 9, 12433, 0, 0, 0, '', 'Element 115 - Seeking Solvent'),
(4, 24095, 37664, 1, 9, 12434, 0, 0, 0, '', 'Element 115 - Always Seeking Solvent'),
(4, 24095, 37664, 2, 9, 12443, 0, 0, 0, '', 'Element 115 - Seeking Solvent'),
(4, 24095, 37664, 3, 9, 12446, 0, 0, 0, '', 'Element 115 - Always Seeking Solvent'),
(4, 24095, 37664, 4, 9, 12437, 0, 0, 0, '', 'Element 115 - Riding the Red Rocket A'),
(4, 24095, 37664, 5, 9, 12432, 0, 0, 0, '', 'Element 115 - Riding the Red Rocket H');
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`=100 WHERE `entry`=24095 AND `item`=37664;

-- Add some missing Azure Scalebane Spawns to crystalsong Forest
DELETE FROM `creature` WHERE `guid` IN (6499,6627,7630,10504,12599,12954,13423,13424);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`unit_flags`,`dynamicflags`) VALUES
(6499,31402,571,1,1,0,0,5220.886,591.7798,187.861328,4.866286,180,10,0,1,0,1,0,0),
(6627,31402,571,1,1,0,0,5344.32,595.7,183.07399,4.99164152,180,10,0,1,0,1,0,0),
(7630,31402,571,1,1,0,0,5411.67773,623.1622,178.355133,0.87266463,180,10,0,1,0,1,0,0),
(10504,31402,571,1,1,0,0,5434.40332,783.9654,182.770508,0.5726554,180,10,0,1,0,1,0,0),
(12599,31402,571,1,1,0,0,5464.40771,716.290344,171.820313,2.65290046,180,10,0,1,0,1,0,0),
(12954,31402,571,1,1,0,0,5573.34326,862.8543,161.738586,1.48352981,180,10,0,1,0,1,0,0),
(13423,31402,571,1,1,0,0,5659.52734,987.839844,174.5677,0.314159274,180,0,0,1,0,0,570688256,32),
(13424,31402,571,1,1,0,0,5660.18652,1028.454,174.562653,2.79252672,180,0,0,1,0,0,570688256,32);
-- Addons for dead appearance
DELETE FROM `creature_addon` WHERE `guid` IN (13423,13424);
INSERT INTO `creature_addon` (`guid`,`bytes2`,`auras`) VALUES
(13423,1,29266),
(13424,1,29266);
UPDATE `creature_model_info` SET `bounding_radius`=0.465,`combat_reach`=1.5,`gender`=0 WHERE `modelid`=25195; -- Azure Scalebane
DELETE FROM `creature_template_addon` WHERE `entry`=31402;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(31402,0,0,1,0, NULL); -- Azure Scalebane
 
 
-- -------------------------------------------------------- 
-- _MERGED.sql 
-- -------------------------------------------------------- 
 
 
