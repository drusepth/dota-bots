local BotsInit = require( "game/botsinit" );
local MyModule = BotsInit.CreateGeneric();
local npcBot = nil; 
local MoveDesire = 0;
local AttackDesire = 0;
local RetreatDesire = 0;
local npcBotAR = 0;
local ProxRange = 1000;
local castWSDesire = 0;
local castTCDesire = 0;
local castSWDesire = 0;
local castMBDesire = 0;
local castPGDesire = 0;
local castESDesire = 0;
local castHBDesire = 0;
local castHB2Desire = 0;
local castCLDesire = 0;
local castFADesire = 0;
function  MinionThink(  hMinionUnit ) 
	if npcBot == nil then npcBot = GetBot(); end
	if not hMinionUnit:IsNull() and hMinionUnit ~= nil and hMinionUnit:IsAlive() then 
		if hMinionUnit:IsIllusion() then
			if ( hMinionUnit:IsUsingAbility() or hMinionUnit:IsChanneling() ) then return end
			AttackDesire, AttackTarget = ConsiderAttacking(hMinionUnit); 
			MoveDesire, Location = ConsiderMove(hMinionUnit); 
			if (AttackDesire > 0)
			then
				hMinionUnit:Action_AttackUnit( AttackTarget, true );
				return
			end
			if (MoveDesire > 0)
			then
				hMinionUnit:Action_MoveToLocation( Location );
				return
			end
		elseif hMinionUnit:GetUnitName() == "npc_dota_neutral_centaur_khan" then
			if ( hMinionUnit:IsUsingAbility() or hMinionUnit:IsChanneling() ) then return end
			abilityWS = hMinionUnit:GetAbilityByName( "centaur_khan_war_stomp" );
			castWSDesire = ConsiderWarStomp(hMinionUnit);
			AttackDesire, AttackTarget = ConsiderAttacking(hMinionUnit); 
			MoveDesire, Location = ConsiderMove(hMinionUnit); 
			RetreatDesire, RetreatLocation = ConsiderRetreat(hMinionUnit); 
			if castWSDesire > 0 then
				hMinionUnit:Action_UseAbility(abilityWS);
				return
			end
			if ( RetreatDesire > 0 ) 
			then
				hMinionUnit:Action_MoveToLocation( RetreatLocation );
				return;
			end
			if (AttackDesire > 0)
			then
				hMinionUnit:Action_AttackUnit( AttackTarget, true );
				return
			end
			if (MoveDesire > 0)
			then
				hMinionUnit:Action_MoveToLocation( Location );
				return
			end
		elseif hMinionUnit:GetUnitName() == "npc_dota_neutral_polar_furbolg_ursa_warrior" then
			if ( hMinionUnit:IsUsingAbility() or hMinionUnit:IsChanneling() ) then return end
			abilityTC = hMinionUnit:GetAbilityByName( "polar_furbolg_ursa_warrior_thunder_clap" );
			castTCDesire = ConsiderThunderClap(hMinionUnit);
			AttackDesire, AttackTarget = ConsiderAttacking(hMinionUnit); 
			MoveDesire, Location = ConsiderMove(hMinionUnit); 
			RetreatDesire, RetreatLocation = ConsiderRetreat(hMinionUnit);
			if castTCDesire > 0 then
				hMinionUnit:Action_UseAbility(abilityTC);
				return
			end
			if ( RetreatDesire > 0 ) 
			then
				hMinionUnit:Action_MoveToLocation( RetreatLocation );
				return;
			end
			if (AttackDesire > 0)
			then
				hMinionUnit:Action_AttackUnit( AttackTarget, true );
				return
			end
			if (MoveDesire > 0)
			then
				hMinionUnit:Action_MoveToLocation( Location );
				return
			end	
		elseif hMinionUnit:GetUnitName() == "npc_dota_neutral_satyr_hellcaller" then
			if ( hMinionUnit:IsUsingAbility() or hMinionUnit:IsChanneling() ) then return end
			abilitySW = hMinionUnit:GetAbilityByName( "satyr_hellcaller_shockwave" );
			castSWDesire, castSWLocation = ConsiderShockWave(hMinionUnit);
			AttackDesire, AttackTarget = ConsiderAttacking(hMinionUnit); 
			MoveDesire, Location = ConsiderMove(hMinionUnit); 
			RetreatDesire, RetreatLocation = ConsiderRetreat(hMinionUnit);
			if castSWDesire > 0 then
				hMinionUnit:Action_UseAbilityOnLocation(abilitySW, castSWLocation);
				return
			end
			if ( RetreatDesire > 0 ) 
			then
				hMinionUnit:Action_MoveToLocation( RetreatLocation );
				return;
			end
			if (AttackDesire > 0)
			then
				hMinionUnit:Action_AttackUnit( AttackTarget, true );
				return
			end
			if (MoveDesire > 0)
			then
				hMinionUnit:Action_MoveToLocation( Location );
				return
			end	
		elseif hMinionUnit:GetUnitName() == "npc_dota_neutral_satyr_soulstealer" then
			if ( hMinionUnit:IsUsingAbility() or hMinionUnit:IsChanneling() ) then return end
			abilityMB = hMinionUnit:GetAbilityByName( "satyr_soulstealer_mana_burn" );
			castMBDesire, castMBTarget = ConsiderManaBurn(hMinionUnit);
			AttackDesire, AttackTarget = ConsiderAttacking(hMinionUnit); 
			MoveDesire, Location = ConsiderMove(hMinionUnit); 
			RetreatDesire, RetreatLocation = ConsiderRetreat(hMinionUnit);
			if castMBDesire > 0 then
				hMinionUnit:Action_UseAbilityOnEntity(abilityMB, castMBTarget);
				return
			end
			if ( RetreatDesire > 0 ) 
			then
				hMinionUnit:Action_MoveToLocation( RetreatLocation );
				return;
			end
			if (AttackDesire > 0)
			then
				hMinionUnit:Action_AttackUnit( AttackTarget, true );
				return
			end
			if (MoveDesire > 0)
			then
				hMinionUnit:Action_MoveToLocation( Location );
				return
			end	
		elseif hMinionUnit:GetUnitName() == "npc_dota_neutral_satyr_trickster" then
			
			if ( hMinionUnit:IsUsingAbility() or hMinionUnit:IsChanneling() ) then return end
			
			abilityPG = hMinionUnit:GetAbilityByName( "satyr_trickster_purge" );
			
			castPGDesire, castPGTarget = ConsiderPurge(hMinionUnit);
			AttackDesire, AttackTarget = ConsiderAttacking(hMinionUnit); 
			MoveDesire, Location = ConsiderMove(hMinionUnit); 
			RetreatDesire, RetreatLocation = ConsiderRetreat(hMinionUnit);
			if castPGDesire > 0 then
				hMinionUnit:Action_UseAbilityOnEntity(abilityPG, castPGTarget);
				return
			end
			if ( RetreatDesire > 0 ) 
			then
				hMinionUnit:Action_MoveToLocation( RetreatLocation );
				return;
			end
			if (AttackDesire > 0)
			then
				hMinionUnit:Action_AttackUnit( AttackTarget, true );
				return
			end
			if (MoveDesire > 0)
			then
				hMinionUnit:Action_MoveToLocation( Location );
				return
			end	
		elseif hMinionUnit:GetUnitName() == "npc_dota_neutral_dark_troll_warlord" then
			if ( hMinionUnit:IsUsingAbility() or hMinionUnit:IsChanneling() ) then return end
			abilityES = hMinionUnit:GetAbilityByName( "dark_troll_warlord_ensnare" );
			castESDesire, castESTarget = ConsiderEnsnare(hMinionUnit);
			AttackDesire, AttackTarget = ConsiderAttacking(hMinionUnit); 
			MoveDesire, Location = ConsiderMove(hMinionUnit); 
			RetreatDesire, RetreatLocation = ConsiderRetreat(hMinionUnit);
			if castESDesire > 0 then
				hMinionUnit:Action_UseAbilityOnEntity(abilityES, castESTarget);
				return
			end
			if ( RetreatDesire > 0 ) 
			then
				hMinionUnit:Action_MoveToLocation( RetreatLocation );
				return;
			end
			if (AttackDesire > 0)
			then
				hMinionUnit:Action_AttackUnit( AttackTarget, true );
				return
			end
			if (MoveDesire > 0)
			then
				hMinionUnit:Action_MoveToLocation( Location );
				return
			end	
			
		elseif hMinionUnit:GetUnitName() == "npc_dota_neutral_mud_golem" then
			
			if ( hMinionUnit:IsUsingAbility() or hMinionUnit:IsChanneling() ) then return end
			
			abilityHB = hMinionUnit:GetAbilityByName( "mud_golem_hurl_boulder" );
			
			castHBDesire, castHBTarget = ConsiderBoulder(hMinionUnit);
			AttackDesire, AttackTarget = ConsiderAttacking(hMinionUnit); 
			MoveDesire, Location = ConsiderMove(hMinionUnit); 
			RetreatDesire, RetreatLocation = ConsiderRetreat(hMinionUnit);
			
			if castHBDesire > 0 then
				hMinionUnit:Action_UseAbilityOnEntity(abilityHB, castHBTarget);
				return
			end
			if ( RetreatDesire > 0 ) 
			then
				hMinionUnit:Action_MoveToLocation( RetreatLocation );
				return;
			end
			if (AttackDesire > 0)
			then
				hMinionUnit:Action_AttackUnit( AttackTarget, true );
				return
			end
			if (MoveDesire > 0)
			then
				hMinionUnit:Action_MoveToLocation( Location );
				return
			end	
		elseif hMinionUnit:GetUnitName() == "npc_dota_neutral_mud_golem_split"  then
			
			if ( hMinionUnit:IsUsingAbility() or hMinionUnit:IsChanneling() ) then return end
			
			abilityHB2 = hMinionUnit:GetAbilityByName( "mud_golem_hurl_boulder" );
			
			castHB2Desire, castHB2Target = ConsiderBoulder2(hMinionUnit);
			AttackDesire, AttackTarget = ConsiderAttacking(hMinionUnit); 
			MoveDesire, Location = ConsiderMove(hMinionUnit); 
			RetreatDesire, RetreatLocation = ConsiderRetreat(hMinionUnit);
			
			if castHB2Desire > 0 then
				hMinionUnit:Action_UseAbilityOnEntity(abilityHB2, castHB2Target);
				return
			end
			if ( RetreatDesire > 0 ) 
			then
				hMinionUnit:Action_MoveToLocation( RetreatLocation );
				return;
			end
			if (AttackDesire > 0)
			then
				hMinionUnit:Action_AttackUnit( AttackTarget, true );
				return
			end
			if (MoveDesire > 0)
			then
				hMinionUnit:Action_MoveToLocation( Location );
				return
			end		
		
		elseif hMinionUnit:GetUnitName() == "npc_dota_neutral_harpy_storm"  then
			
			if ( hMinionUnit:IsUsingAbility() or hMinionUnit:IsChanneling() ) then return end
			
			abilityCL = hMinionUnit:GetAbilityByName( "harpy_storm_chain_lightning" );
			
			castCLDesire, castCLTarget = ConsiderChainLighting(hMinionUnit);
			AttackDesire, AttackTarget = ConsiderAttacking(hMinionUnit); 
			MoveDesire, Location = ConsiderMove(hMinionUnit); 
			RetreatDesire, RetreatLocation = ConsiderRetreat(hMinionUnit);
			
			if castCLDesire > 0 then
				hMinionUnit:Action_UseAbilityOnEntity(abilityCL, castCLTarget);
				return
			end
			if ( RetreatDesire > 0 ) 
			then
				hMinionUnit:Action_MoveToLocation( RetreatLocation );
				return;
			end
			if (AttackDesire > 0)
			then
				hMinionUnit:Action_AttackUnit( AttackTarget, true );
				return
			end
			if (MoveDesire > 0)
			then
				hMinionUnit:Action_MoveToLocation( Location );
				return
			end	
		elseif hMinionUnit:GetUnitName() == "npc_dota_neutral_ogre_magi"  then
			
			if ( hMinionUnit:IsUsingAbility() or hMinionUnit:IsChanneling() ) then return end
			
			abilityFA = hMinionUnit:GetAbilityByName( "ogre_magi_frost_armor" );
			
			castFADesire, castFATarget = ConsiderFrostArmor(hMinionUnit);
			AttackDesire, AttackTarget = ConsiderAttacking(hMinionUnit); 
			MoveDesire, Location = ConsiderMove(hMinionUnit); 
			RetreatDesire, RetreatLocation = ConsiderRetreat(hMinionUnit);
			
			if castFADesire > 0 then
				hMinionUnit:Action_UseAbilityOnEntity(abilityFA, castFATarget);
				return
			end
			if ( RetreatDesire > 0 ) 
			then
				hMinionUnit:Action_MoveToLocation( RetreatLocation );
				return;
			end
			if (AttackDesire > 0)
			then
				hMinionUnit:Action_AttackUnit( AttackTarget, true );
				return
			end
			if (MoveDesire > 0)
			then
				hMinionUnit:Action_MoveToLocation( Location );
				return
			end		
		else	
			if ( hMinionUnit:IsUsingAbility() or hMinionUnit:IsChanneling() ) then return end
			AttackDesire, AttackTarget = ConsiderAttacking(hMinionUnit); 
			MoveDesire, Location = ConsiderMove(hMinionUnit); 
			RetreatDesire, RetreatLocation = ConsiderRetreat(hMinionUnit);
			if ( RetreatDesire > 0 ) 
			then
				hMinionUnit:Action_MoveToLocation( RetreatLocation );
				return;
			end
			if (AttackDesire > 0)
			then
				hMinionUnit:Action_AttackUnit( AttackTarget, true );
				return
			end
			if (MoveDesire > 0)
			then
				hMinionUnit:Action_MoveToLocation( Location );
				return
			end	
		end
	end
	
end
function CanBeAttacked( npcTarget )
	return npcTarget:CanBeSeen() and not npcTarget:IsInvulnerable();
end
function CanCastOnMagicImmuneTarget( npcTarget )
	return npcTarget:CanBeSeen() and not npcTarget:IsInvulnerable();
end
function CanCastOnNonMagicImmuneTarget( npcTarget )
	return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end
function ConsiderAttacking(hMinionUnit)
	local npcBot = GetBot();
	local target = npcBot:GetTarget();
	local AR = hMinionUnit:GetAttackRange();
	local OAR = npcBot:GetAttackRange();
	local AD = hMinionUnit:GetAttackDamage();
	
	if target ~= nil and CanBeAttacked(target) and GetUnitToUnitDistance(target, npcBot) <= OAR + 200 and GetUnitToUnitDistance(hMinionUnit, npcBot) <= ProxRange then
		return BOT_ACTION_DESIRE_MODERATE, target;
	else
		if hMinionUnit:WasRecentlyDamagedByTower( 2.0 ) then
			local NearbyLaneCreeps = hMinionUnit:GetNearbyLaneCreeps(800, false);
			if NearbyLaneCreeps[1] ~= nil then
				return BOT_ACTION_DESIRE_MODERATE, NearbyLaneCreeps[1];
			end
		end
		if npcBot:GetActiveMode() == BOT_MODE_LANING and GetUnitToUnitDistance(npcBot, hMinionUnit) < ProxRange then
			local NearbyLaneCreeps = hMinionUnit:GetNearbyLaneCreeps(1000, true);
			local TCreep = nil;
			for _,creep in pairs(NearbyLaneCreeps)
			do
				local CHealth = creep:GetHealth();
				if CHealth < 4*AD then
					TCreep = creep;
				end
			end
			if TCreep ~= nil then
				return BOT_ACTION_DESIRE_MODERATE, TCreep;
			end
		elseif ( npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP or
				 npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID or
				 npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT 
				 ) and GetUnitToUnitDistance(hMinionUnit, npcBot) <= ProxRange
		then
			local NearbyLaneCreeps = hMinionUnit:GetNearbyLaneCreeps(1000, true);
			local TCreep = nil;
			local MinHealth = 10000;
			for _,creep in pairs(NearbyLaneCreeps)
			do
				local CHealth = creep:GetHealth();
				if CHealth < MinHealth then
					TCreep = creep;
					MinHealth = CHealth;
				end
			end
			if TCreep ~= nil then
				return BOT_ACTION_DESIRE_MODERATE, TCreep;
			end
		elseif ( npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_TOP or
				 npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_MID or
				 npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_BOT ) and GetUnitToUnitDistance(hMinionUnit, npcBot) <= ProxRange
		then
			local tableNearbyEnemyHeroes = hMinionUnit:GetNearbyHeroes( 1000, true, BOT_MODE_NONE );
			if tableNearbyEnemyHeroes == nil then
				local NearbyLaneCreeps = hMinionUnit:GetNearbyLaneCreeps(1000, true);
				local TCreep = nil;
				local MinHealth = 10000;
				for _,creep in pairs(NearbyLaneCreeps)
				do
					local CHealth = creep:GetHealth();
					if CHealth < MinHealth then
						TCreep = creep;
						MinHealth = CHealth;
					end
				end
				if TCreep ~= nil then
					return BOT_ACTION_DESIRE_MODERATE, TCreep;
				end
			end
		elseif 	npcBot:GetActiveMode() == BOT_MODE_FARM and GetUnitToUnitDistance(hMinionUnit, npcBot) <= ProxRange
		then
			local NearbyCreeps = hMinionUnit:GetNearbyCreeps(1000, true);
			local TCreep = nil;
			local MinHealth = 10000;
			for _,creep in pairs(NearbyCreeps)
			do
				local CHealth = creep:GetHealth();
				if CHealth < MinHealth then
					TCreep = creep;
					MinHealth = CHealth;
				end
			end
			if TCreep ~= nil then
				return BOT_ACTION_DESIRE_MODERATE, TCreep;
			end
		end
		
	end
	return BOT_ACTION_DESIRE_NONE, 0;
end
function ConsiderMove(hMinionUnit)
	local target = npcBot:GetTarget()
	
	if AttackDesire > 0 or not npcBot:IsAlive() then
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	
	if target == nil or ( target ~= nil and not CanBeAttacked(target) ) or (target ~= nil and GetUnitToUnitDistance(target, npcBot) > ProxRange) then
		return BOT_ACTION_DESIRE_MODERATE, npcBot:GetLocation();
	end
	
	return BOT_ACTION_DESIRE_NONE, 0;
	
end
function ConsiderRetreat(hMinionUnit)
	
	if hMinionUnit:DistanceFromFountain() == 0 
	then
		return BOT_ACTION_DESIRE_NONE, {};
	end	
	
	local RB = Vector(-7200,-6666)
	local DB = Vector(7137,6548)
	
	if not npcBot:IsAlive() then
		if GetTeam( ) == TEAM_DIRE then
			location = DB;
		elseif GetTeam( ) == TEAM_RADIANT then
			location = RB;
		end
		return BOT_ACTION_DESIRE_LOW, location;
	end
	
	return BOT_ACTION_DESIRE_NONE, 0;
end
function ConsiderThunderClap(hMinionUnit)
	
	if ( abilityTC:IsNull() or not abilityTC:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE;
	end
	
	local nRadius = abilityTC:GetSpecialValueInt( "radius" );
	
	
	if ( npcBot:GetActiveMode() == BOT_MODE_RETREAT and npcBot:GetActiveModeDesire() >= BOT_MODE_DESIRE_HIGH ) 
	then
		local tableNearbyEnemyHeroes = hMinionUnit:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( npcBot:WasRecentlyDamagedByHero( npcEnemy, 1.0 ) and CanCastOnNonMagicImmuneTarget( npcEnemy ) ) 
			then
				return BOT_ACTION_DESIRE_HIGH;
			end
		end
	end
	
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_GANK or
		 npcBot:GetActiveMode() == BOT_MODE_ATTACK or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY ) 
	then
		local npcTarget = npcBot:GetTarget();
		if ( npcTarget ~= nil and npcTarget:IsHero() ) 
		then
			if ( CanCastOnNonMagicImmuneTarget( npcTarget ) and GetUnitToUnitDistance( hMinionUnit, npcTarget ) < nRadius )
			then
				return BOT_ACTION_DESIRE_HIGH;
			end
		end
	end
	return BOT_ACTION_DESIRE_NONE;
end
function ConsiderWarStomp(hMinionUnit)
	if ( abilityWS:IsNull() or not abilityWS:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE;
	end
	local nRadius = abilityWS:GetSpecialValueInt( "radius" );
	if ( npcBot:GetActiveMode() == BOT_MODE_RETREAT and npcBot:GetActiveModeDesire() >= BOT_MODE_DESIRE_HIGH ) 
	then
		local tableNearbyEnemyHeroes = hMinionUnit:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( npcBot:WasRecentlyDamagedByHero( npcEnemy, 1.0 ) and CanCastOnNonMagicImmuneTarget( npcEnemy ) ) 
			then
				return BOT_ACTION_DESIRE_HIGH;
			end
		end
	end
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_GANK or
		 npcBot:GetActiveMode() == BOT_MODE_ATTACK or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY ) 
	then
		local npcTarget = npcBot:GetTarget();
		if ( npcTarget ~= nil and npcTarget:IsHero() ) 
		then
			if ( CanCastOnNonMagicImmuneTarget( npcTarget ) and GetUnitToUnitDistance( hMinionUnit, npcTarget ) < nRadius )
			then
				return BOT_ACTION_DESIRE_HIGH;
			end
		end
	end
	return BOT_ACTION_DESIRE_NONE;
end
function ConsiderShockWave(hMinionUnit)
	
	if ( abilitySW:IsNull() or not abilitySW:IsFullyCastable() ) 
	then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	
	local nRadius = abilitySW:GetSpecialValueInt( "radius_end" );
	local nCastRange = abilitySW:GetCastRange();
	local nCastPoint = abilitySW:GetCastPoint( );
	local nDamage = abilitySW:GetAbilityDamage();
	
	
	local npcTargetToKill = npcBot:GetTarget();
	if ( npcTargetToKill ~= nil and npcTargetToKill:IsHero() and CanCastOnNonMagicImmuneTarget( npcTargetToKill ) )
	then
		if ( npcTargetToKill:GetActualIncomingDamage( nDamage, DAMAGE_TYPE_MAGICAL ) > npcTargetToKill:GetHealth() and GetUnitToUnitDistance( npcTargetToKill, hMinionUnit ) < nCastRange  )
		then
			return BOT_ACTION_DESIRE_MODERATE, npcTargetToKill:GetExtrapolatedLocation(nCastPoint);
		end
	end
	
	
	if ( npcBot:GetActiveMode() == BOT_MODE_RETREAT and npcBot:GetActiveModeDesire() >= BOT_MODE_DESIRE_HIGH ) 
	then
		local tableNearbyEnemyHeroes = hMinionUnit:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( npcBot:WasRecentlyDamagedByHero( npcEnemy, 2.0 ) ) 
			then
				return BOT_ACTION_DESIRE_MODERATE, npcEnemy:GetLocation();
			end
		end
	end
	
	
	if ( npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP or
		 npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID or
		 npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT  ) 
	then
		local locationAoE = npcBot:FindAoELocation( true, false, hMinionUnit:GetLocation(), nCastRange, nRadius, 0, 0 );
		if ( locationAoE.count >= 3 ) 
		then
			return BOT_ACTION_DESIRE_LOW, locationAoE.targetloc;
		end
	end
	
	
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_GANK or
		 npcBot:GetActiveMode() == BOT_MODE_ATTACK or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY ) 
	then
		local npcTarget = npcBot:GetTarget();
		if ( npcTarget ~= nil and npcTarget:IsHero() and GetUnitToUnitDistance( npcTarget, hMinionUnit ) < nCastRange and CanCastOnNonMagicImmuneTarget( npcTarget ) ) 
		then
				return BOT_ACTION_DESIRE_MODERATE, npcTarget:GetExtrapolatedLocation(nCastPoint);
		end
	end
	return BOT_ACTION_DESIRE_NONE, 0;
end
function ConsiderManaBurn(hMinionUnit)
	
	if ( abilityMB:IsNull() or not abilityMB:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	
	
	local nCastRange = abilityMB:GetCastRange();
	local nCastPoint = abilityMB:GetCastPoint();
	local nDamage = abilityMB:GetSpecialValueInt("burn_amount");
	
	
	
	local npcTarget = npcBot:GetTarget();
	if ( npcTarget ~= nil and npcTarget:IsHero() and CanCastOnNonMagicImmuneTarget( npcTarget ) )
	then
		if ( npcTarget:GetActualIncomingDamage( nDamage, DAMAGE_TYPE_MAGICAL  ) > npcTarget:GetHealth() and GetUnitToUnitDistance( npcTarget, hMinionUnit ) < ( nCastRange + 200 ) )
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget;
		end
	end
	
	
	
	if ( npcBot:GetActiveMode() == BOT_MODE_RETREAT and npcBot:GetActiveModeDesire() >= BOT_MODE_DESIRE_HIGH ) 
	then
		local tableNearbyEnemyHeroes = hMinionUnit:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( npcBot:WasRecentlyDamagedByHero( npcEnemy, 2.0 ) and CanCastOnNonMagicImmuneTarget(npcEnemy) ) 
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy;
			end
		end
	end
	
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_GANK or
		 npcBot:GetActiveMode() == BOT_MODE_ATTACK or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY ) 
	then
		local npcTarget = npcBot:GetTarget();
		if ( npcTarget ~= nil and npcTarget:IsHero() and CanCastOnNonMagicImmuneTarget(npcTarget) and GetUnitToUnitDistance(npcTarget, hMinionUnit) < nCastRange + 200 ) 
		then
			return BOT_ACTION_DESIRE_MODERATE, npcTarget;
		end
	end
	return BOT_ACTION_DESIRE_NONE, 0;
end
function ConsiderPurge(hMinionUnit)
	if ( abilityPG:IsNull() or not abilityPG:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	local nCastRange = abilityPG:GetCastRange();
	local nCastPoint = abilityPG:GetCastPoint();
	if ( npcBot:GetActiveMode() == BOT_MODE_RETREAT and npcBot:GetActiveModeDesire() >= BOT_MODE_DESIRE_HIGH ) 
	then
		local tableNearbyEnemyHeroes = hMinionUnit:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( npcBot:WasRecentlyDamagedByHero( npcEnemy, 2.0 ) and CanCastOnNonMagicImmuneTarget(npcEnemy) ) 
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy;
			end
		end
	end
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_GANK or
		 npcBot:GetActiveMode() == BOT_MODE_ATTACK or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY ) 
	then
		local npcTarget = npcBot:GetTarget();
		if ( npcTarget ~= nil and npcTarget:IsHero() and CanCastOnNonMagicImmuneTarget(npcTarget) and GetUnitToUnitDistance(npcTarget, hMinionUnit) < nCastRange + 200 ) 
		then
			return BOT_ACTION_DESIRE_MODERATE, npcTarget;
		end
	end
	return BOT_ACTION_DESIRE_NONE, 0;
end
function ConsiderEnsnare(hMinionUnit)
	if ( abilityES:IsNull() or not abilityES:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	local nCastRange = abilityES:GetCastRange();
	local nCastPoint = abilityES:GetCastPoint();
	if ( npcBot:GetActiveMode() == BOT_MODE_RETREAT and npcBot:GetActiveModeDesire() >= BOT_MODE_DESIRE_HIGH ) 
	then
		local tableNearbyEnemyHeroes = hMinionUnit:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( npcBot:WasRecentlyDamagedByHero( npcEnemy, 2.0 ) and CanCastOnNonMagicImmuneTarget(npcEnemy) ) 
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy;
			end
		end
	end
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_GANK or
		 npcBot:GetActiveMode() == BOT_MODE_ATTACK or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY ) 
	then
		local npcTarget = npcBot:GetTarget();
		if ( npcTarget ~= nil and npcTarget:IsHero() and CanCastOnNonMagicImmuneTarget(npcTarget) and GetUnitToUnitDistance(npcTarget, hMinionUnit) < nCastRange + 200 ) 
		then
			return BOT_ACTION_DESIRE_MODERATE, npcTarget;
		end
	end
	return BOT_ACTION_DESIRE_NONE, 0;
end
function ConsiderBoulder(hMinionUnit)
	
	if ( abilityHB:IsNull() or not abilityHB:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	local nCastRange = abilityHB:GetCastRange();
	local nCastPoint = abilityHB:GetCastPoint();
	local nDamage = abilityHB:GetSpecialValueInt("damage");
	local npcTarget = npcBot:GetTarget();
	if ( npcTarget ~= nil and npcTarget:IsHero() and CanCastOnNonMagicImmuneTarget( npcTarget ) )
	then
		if ( npcTarget:GetActualIncomingDamage( nDamage, DAMAGE_TYPE_MAGICAL  ) > npcTarget:GetHealth() and GetUnitToUnitDistance( npcTarget, hMinionUnit ) < nCastRange  )
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget;
		end
	end
	if ( npcBot:GetActiveMode() == BOT_MODE_RETREAT and npcBot:GetActiveModeDesire() >= BOT_MODE_DESIRE_HIGH ) 
	then
		local tableNearbyEnemyHeroes = hMinionUnit:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( npcBot:WasRecentlyDamagedByHero( npcEnemy, 2.0 ) and CanCastOnNonMagicImmuneTarget(npcEnemy) ) 
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy;
			end
		end
	end
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_GANK or
		 npcBot:GetActiveMode() == BOT_MODE_ATTACK or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY ) 
	then
		local npcTarget = npcBot:GetTarget();
		if ( npcTarget ~= nil and npcTarget:IsHero() and CanCastOnNonMagicImmuneTarget(npcTarget) and GetUnitToUnitDistance(npcTarget, hMinionUnit) < nCastRange ) 
		then
			return BOT_ACTION_DESIRE_MODERATE, npcTarget;
		end
	end
	return BOT_ACTION_DESIRE_NONE, 0;
end
function ConsiderBoulder2(hMinionUnit)
	if ( abilityHB2:IsNull() or not abilityHB2:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	local nCastRange = abilityHB2:GetCastRange();
	local nCastPoint = abilityHB2:GetCastPoint();
	local nDamage = abilityHB2:GetSpecialValueInt("damage");
	local npcTarget = npcBot:GetTarget();
	if ( npcTarget ~= nil and npcTarget:IsHero() and CanCastOnNonMagicImmuneTarget( npcTarget ) )
	then
		if ( npcTarget:GetActualIncomingDamage( nDamage, DAMAGE_TYPE_MAGICAL  ) > npcTarget:GetHealth() and GetUnitToUnitDistance( npcTarget, hMinionUnit ) < nCastRange  )
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget;
		end
	end
	if ( npcBot:GetActiveMode() == BOT_MODE_RETREAT and npcBot:GetActiveModeDesire() >= BOT_MODE_DESIRE_HIGH ) 
	then
		local tableNearbyEnemyHeroes = hMinionUnit:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( npcBot:WasRecentlyDamagedByHero( npcEnemy, 2.0 ) and CanCastOnNonMagicImmuneTarget(npcEnemy) ) 
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy;
			end
		end
	end
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_GANK or
		 npcBot:GetActiveMode() == BOT_MODE_ATTACK or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY ) 
	then
		local npcTarget = npcBot:GetTarget();
		if ( npcTarget ~= nil and npcTarget:IsHero() and CanCastOnNonMagicImmuneTarget(npcTarget) and GetUnitToUnitDistance(npcTarget, hMinionUnit) < nCastRange ) 
		then
			return BOT_ACTION_DESIRE_MODERATE, npcTarget;
		end
	end
	return BOT_ACTION_DESIRE_NONE, 0;
end
function ConsiderChainLighting(hMinionUnit)
	if ( abilityCL:IsNull() or not abilityCL:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	local nCastRange = abilityCL:GetCastRange();
	local nCastPoint = abilityCL:GetCastPoint();
	local nDamage = abilityCL:GetSpecialValueInt("initial_damage");
	local npcTarget = npcBot:GetTarget();
	if ( npcTarget ~= nil and npcTarget:IsHero() and CanCastOnNonMagicImmuneTarget( npcTarget ) )
	then
		if ( npcTarget:GetActualIncomingDamage( nDamage, DAMAGE_TYPE_MAGICAL  ) > npcTarget:GetHealth() and GetUnitToUnitDistance( npcTarget, hMinionUnit ) < nCastRange  )
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget;
		end
	end
	if ( npcBot:GetActiveMode() == BOT_MODE_RETREAT and npcBot:GetActiveModeDesire() >= BOT_MODE_DESIRE_HIGH ) 
	then
		local tableNearbyEnemyHeroes = hMinionUnit:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( npcBot:WasRecentlyDamagedByHero( npcEnemy, 2.0 ) and CanCastOnNonMagicImmuneTarget(npcEnemy) ) 
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy;
			end
		end
	end
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_GANK or
		 npcBot:GetActiveMode() == BOT_MODE_ATTACK or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY ) 
	then
		local npcTarget = npcBot:GetTarget();
		if ( npcTarget ~= nil and npcTarget:IsHero() and CanCastOnNonMagicImmuneTarget(npcTarget) and GetUnitToUnitDistance(npcTarget, hMinionUnit) < nCastRange ) 
		then
			return BOT_ACTION_DESIRE_MODERATE, npcTarget;
		end
	end
	return BOT_ACTION_DESIRE_NONE, 0;
end
function ConsiderFrostArmor()
	
	if ( abilityFA:IsNull() or not abilityFA:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	
	local nCastRange = abilityFA:GetCastRange();
	if not npcBot:HasModifier("modifier_ogre_magi_frost_armor") then
		return BOT_ACTION_DESIRE_MODERATE, npcBot;
	end
	
	local tableNearbyFriendlyHeroes = npcBot:GetNearbyHeroes( nCastRange, false, BOT_MODE_NONE );
	for _,myFriend in pairs(tableNearbyFriendlyHeroes) do
		if ( not myFriend:HasModifier("modifier_ogre_magi_frost_armor") ) 
		then
			return BOT_ACTION_DESIRE_MODERATE, myFriend;
		end
	end	
	
	return BOT_ACTION_DESIRE_NONE, 0;
end
return MyModule;