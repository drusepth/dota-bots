if GetBot():IsInvulnerable() or not GetBot():IsHero() or not string.find(GetBot():GetUnitName(), "hero") or  GetBot():IsIllusion() then
	return;
end
local ability_item_usage_generic = dofile( GetScriptDirectory().."/ability_item_usage_shutnik" )
local utils = require(GetScriptDirectory() ..  "/util")
local mutil = require(GetScriptDirectory() ..  "/MyUtility")
function AbilityLevelUpThink()  
	ability_item_usage_generic.AbilityLevelUpThink(); 
end
function BuybackUsageThink()
	ability_item_usage_generic.BuybackUsageThink();
end
function CourierUsageThink()
	ability_item_usage_generic.CourierUsageThink();
end
local npcBot = GetBot();
local castDCDesire = 0;
local castFGDesire = 0;
local castDPDesire = 0;
local castFBDesire = 0;
local abilityDC = nil;
local abilityFG = nil;
local abilityDP = nil;
local abilityFB = nil;
local mode = -1;
function AbilityUsageThink()
	
	if ( npcBot:IsUsingAbility() or npcBot:IsChanneling() or npcBot:IsSilenced()  ) then return end
	if abilityDC == nil then abilityDC = npcBot:GetAbilityByName( "terrorblade_reflection" ); end
	if abilityFG == nil then abilityFG = npcBot:GetAbilityByName( "terrorblade_metamorphosis" ); end
	if abilityDP == nil then abilityDP = npcBot:GetAbilityByName( "terrorblade_conjure_image" ); end
	if abilityFB == nil then abilityFB = npcBot:GetAbilityByName( "terrorblade_sunder" ); end
	
	castDPDesire = ConsiderDarkPact();
	castDCDesire = ConsiderDecay();
	castFGDesire = ConsiderFleshGolem();
	castFBDesire, castFBTarget = ConsiderFireblast();
	if ( castFBDesire > 0 ) 
	then
		npcBot:Action_UseAbilityOnEntity( abilityFB, castFBTarget );
		return;
	end
	if ( castFGDesire > 0 ) 
	then
		npcBot:Action_UseAbility( abilityFG );
		return;
	end
	if ( castDPDesire > 0 ) 
	then
		npcBot:Action_UseAbility( abilityDP );
		return;
	end
	if ( castDCDesire > 0 ) 
	then
		npcBot:Action_UseAbility( abilityDC );
		return;
	end
	
end
function CanCastDecayOnTarget( npcTarget )
	return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end
function CanCastFleshGolemOnTarget( npcTarget )
	return npcTarget:CanBeSeen() and not npcTarget:IsInvulnerable();
end
function CanCastDoomOnTarget( npcTarget )
	return npcTarget:CanBeSeen() and not npcTarget:IsInvulnerable();
end
function ConsiderDecay()
	
	if ( not abilityDC:IsFullyCastable() ) 
	then 
		return BOT_ACTION_DESIRE_NONE;
	end
	
	local nRadius = abilityDC:GetSpecialValueInt( "range" );
	local nCastPoint = abilityDC:GetCastPoint( );
	
	
	
	if mutil.IsRetreating(npcBot)
	then
		local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( npcBot:WasRecentlyDamagedByHero( npcEnemy, 2.0 ) and mutil.CanCastOnNonMagicImmune(npcEnemy) ) 
			then
				return BOT_ACTION_DESIRE_MODERATE;
			end
		end
	end
	
	if mutil.IsInTeamFight(npcBot, 1200)
	then
		local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE );
		if ( tableNearbyEnemyHeroes ~= nil and #tableNearbyEnemyHeroes >= 2 ) then
			return BOT_ACTION_DESIRE_MODERATE;
		end
	end
	
	
	if mutil.IsGoingOnSomeone(npcBot)
	then
		local npcTarget = npcBot:GetTarget();
		if ( mutil.IsValidTarget(npcTarget) and mutil.CanCastOnNonMagicImmune(npcTarget) and mutil.IsInRange( npcTarget, npcBot, nRadius - 200) ) 
		then
				return BOT_ACTION_DESIRE_MODERATE;
		end
	end
	return BOT_ACTION_DESIRE_NONE;
end
function ConsiderDarkPact()
	
	if ( not abilityDP:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE;
	end
	
	local nRadius = 800;
	local nRange = npcBot:GetAttackRange() + abilityFG:GetSpecialValueInt( "bonus_range" );
	
	
	if mutil.IsRetreating(npcBot)
	then
		local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nRange, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( npcBot:WasRecentlyDamagedByHero( npcEnemy, 2.0 )  ) 
			then
				return BOT_ACTION_DESIRE_MODERATE;
			end
		end
	end
	 
	if  mutil.IsDefending(npcBot) or mutil.IsPushing(npcBot)
	then
		local tableNearbyEnemyCreeps = npcBot:GetNearbyLaneCreeps( nRange, true );
		local tableNearbyEnemyTowers = npcBot:GetNearbyTowers( nRange, true );
		if ( tableNearbyEnemyCreeps ~= nil or tableNearbyEnemyTowers ~= nil ) and npcBot:GetMana()/npcBot:GetMaxMana() > 0.5  then
			return BOT_ACTION_DESIRE_LOW;
		end
	end
	
	
	if mutil.IsGoingOnSomeone(npcBot)
	then
		local npcTarget = npcBot:GetTarget();
		if  mutil.IsValidTarget(npcTarget) and mutil.IsInRange( npcTarget, npcBot, nRange)
		then
			return BOT_ACTION_DESIRE_HIGH;
		end
	end
	return BOT_ACTION_DESIRE_NONE;
end
function ConsiderFleshGolem()
	
	if ( not abilityFG:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE;
	end
	
	local nRadius = npcBot:GetAttackRange() + abilityFG:GetSpecialValueInt( "bonus_range" );
	
	if mutil.IsInTeamFight(npcBot, 1200)
	then
		local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE  );
		if ( tableNearbyEnemyHeroes ~= nil and #tableNearbyEnemyHeroes >= 2 )
		then
			return BOT_ACTION_DESIRE_MODERATE;
		end
	end
	
	
	if mutil.IsGoingOnSomeone(npcBot)
	then
		local npcTarget = npcBot:GetTarget();
		if mutil.IsValidTarget(npcTarget) and mutil.IsInRange( npcTarget, npcBot, nRadius)
		then
			return BOT_ACTION_DESIRE_MODERATE;
		end
	end
	
	return BOT_ACTION_DESIRE_NONE;
end
function ConsiderFireblast()
	
	if ( not abilityFB:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	
	local nCastRange = abilityFB:GetCastRange();
	
	
	if mutil.IsRetreating(npcBot) and npcBot:GetHealth()/npcBot:GetMaxHealth() < 0.35 
	then
		local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nCastRange+200, true, BOT_MODE_NONE );
		local sunderTarget = mutil.GetMostHPPercent(tableNearbyEnemyHeroes, true);
		if sunderTarget ~= nil then
			return BOT_ACTION_DESIRE_HIGH, sunderTarget;
		end
	end
	
	
	
	if mutil.IsInTeamFight(npcBot, 1200) and npcBot:GetHealth()/npcBot:GetMaxHealth() < 0.35 
	then
		local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nCastRange + 200, true, BOT_MODE_NONE );
		local sunderTarget = mutil.GetMostHPPercent(tableNearbyEnemyHeroes, true);
		if ( sunderTarget ~= nil  )
		then
			return BOT_ACTION_DESIRE_HIGH, npcMostHealthyEnemy;
		end
	end
	
	return BOT_ACTION_DESIRE_NONE, 0;
end
