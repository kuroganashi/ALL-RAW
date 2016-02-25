-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')
	
	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"
	
	DefaultAmmo = {['Yoichinoyumi'] = "Achiyalabopa Arrow", ['Annihilator'] = "Achiyalabopa Bullet", ['Nobility'] = "Eminent Arrow", ['Hangaku-no-Yumi'] = "Eminent Arrow", ['Doomsday'] = "Eminent Bullet"}
	U_Shot_Ammo = {['Yoichinoyumi'] = "Achiyalabopa Arrow", ['Annihilator'] = "Achiyalabopa Bullet", ['Nobility'] = "Eminent Arrow", ['Hangaku-no-Yumi'] = "Eminent Arrow", ['Doomsday'] = "Eminent Bullet"}

	select_default_macro_book()

	send_command('bind f9 gs c cycle RangedMode')
	send_command('bind ^f9 gs c cycle OffenseMode')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
end


-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = {hands="Sylvan Glovelettes +2",waist="Chaac Belt"}
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +1"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
	sets.precast.JA['Step'] = {head="Whirlpool Mask",ear2="Choreia Earring"}

	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Whirlpool Mask",neck="Fortitude Torque",ear1="Soil Pearl",ear2="Soil Pearl",
		body="Samnuha Coat",hands="Slither Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Taeon Boots"}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells

	sets.precast.FC = {
		head="Anwig Salade",body="Mirke Wardecors",neck="Jeweled Collar",ear2="Loquacious Earring",
		hands="Leyline Gloves",legs="Blood Cuisses",ring1="Weatherspoon Ring",ring2="Prolix Ring"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",back="Mujin Mantle"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head="Sylvan Gapette +2",neck="Ej Necklace",ear1="Volley Earring",ear2="Clearview Earring",
		body="Sylvan Caban +2",hands="Manibozho Gloves",ring1="Hajduk Ring",ring2="Hajduk Ring",
		back="Lutian Cape",waist="Impulse Belt",legs="Arcadian Braccae",feet="Orion Socks +1"}


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined

        sets.precast.WS = {ammo=DefaultAmmo,
		head="Lilitu Headpiece",body="Orion jerkin +1",hands="Floral Gauntlets",legs="Samnuha Tights",
		feet="Orion Socks +1",
		neck="Fotia Gorget",ring1="Rajas Ring",ring2="Garuda Ring",
		back="Lutian Cape",ear1="Oneiros Pearl",ear2="Clearview Earring",waist="Fotia Belt"}
        
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
		sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",
		neck="Fotia Gorget",legs="Samnuha Tights",
		ear1="Sylvan Earring",ear2="Clearview Earring",ring1="Garuda Ring",ring2="Garuda Ring",
		hands="Sigyn's Bazubands",
		back="Sylvan Chlamys",waist="Fotia Belt",feet="Orion Socks +1",body="Orion Jerkin +1"})
		
		sets.precast.WS['Coronach'] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",
		neck="Fotia Gorget",legs="Samnuha Tights",
		ear1="Flame Pearl",ear2="Clearview Earring",ring1="Rajas Ring",ring2="Pyrosoul Ring",
		hands="Sigyn's Bazubands",
		back="Terebellum Mantle",waist="Fotia Belt",feet="Orion Socks +1",body="Orion Jerkin +1"})
		
		sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS, {head="Thaumas Hat",
		neck="Stoicheion Medal",
		legs={ name="Taeon Tights", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		ear1="Hecate's Earring",ear2="Friomisi Earring",ring1="Garuda Ring",ring2="Garuda Ring",
		hands="Leyline Gloves",
		back="Toro Cape",waist="Aquiline Belt",feet="Iuitl Gaiters +1",body="Orion Jerkin +1"})
		
		sets.precast.WS['Trueflight'] = set_combine(sets.precast.WS, {head="Thaumas Hat",
		neck="Stoicheion Medal",
		legs={ name="Taeon Tights", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		ear1="Hecate's Earring",ear2="Friomisi Earring",ring1="Garuda Ring",ring2="Garuda Ring",
		hands="Leyline Gloves",
		back="Toro Cape",waist="Aquiline Belt",feet="Iuitl Gaiters +1",body="Orion Jerkin +1"})
		
		sets.precast.WS["Jishnu's Radiance"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",
		body="Orion jerkin +1",hands="Floral Gauntlets",
		feet="Orion Socks +1",legs="Byakko's Haidate",neck="Fotia Gorget",ring1="Rajas Ring",
		ring2="Ramuh Ring",back="Rancorous Mantle",
        ear1="Oneiros Pearl",ear2="Clearview Earring",waist="Fotia Belt"})
		
		sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS, {hands="Floral Gauntlets",
		legs="Samnuha Tights",
		ring1="Garuda Ring",ring2="Garuda Ring",back="Lutian Cape"})
		
        sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck="Ej Necklace",back="Libeccio Mantle"})
       
        sets.precast.WS.Ammo = set_combine(sets.precast.WS, {head="Arcadian Beret"})
        sets.precast.WS.AmmoAcc = set_combine(sets.precast.WS.Acc, {head="Arcadian Beret"})

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = {
		head="Anwig Salade",body="Mirke Wardecors",neck="Jeweled Collar",ear2="Loquacious Earring",
		hands="Leyline Gloves",legs="Blood Cuisses",ring1="Weatherspoon Ring",ring2="Prolix Ring"}

	sets.midcast.Utsusemi = {head="Anwig Salade",body="Mirke Wardecors",neck="Magoraga Beads",
		back="Mujin Mantle",ear2="Loquacious Earring",
		hands="Leyline Gloves",legs="Blood Cuisses",ring1="Weatherspoon Ring",ring2="Prolix Ring"}

	-- Ranged sets
	--(Need R.ATK/R.ACC/Store TP/Rapid Shot/WS DMG/Recycle)
	sets.midcast.RA = {
		head="Arcadian Beret",neck="Ocachi Gorget",ear1="Volley earring",ear2="Clearview Earring",
		body="Orion Jerkin +1",hands="Manibozho Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Lutian Cape",waist="Elanid Belt",legs="Samnuha Tights",feet="Orion Socks +1"}--Arcadian Braccae
	
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA,
		{head="Sylvan Gapette +2",neck="Ej Necklace",ear1="Volley Earring",ear2="Clearview Earring",
		body="Orion Jerkin +1",hands="Manibozho Gloves",ring1="Hajduk Ring",ring2="Hajduk Ring",
		back="Lutian Cape",waist="Elanid Belt",legs="Samnuha Tights",feet="Orion Socks +1"})

	sets.midcast.RA.Annihilator = set_combine(sets.midcast.RA)

	sets.midcast.RA.Annihilator.Acc = set_combine(sets.midcast.RA.Acc)

	sets.midcast.RA.Yoichinoyumi = set_combine(sets.midcast.RA, {ear2="Clearview Earring",
	ring1="Rajas Ring",back="Sylvan Chlamys"})

	sets.midcast.RA.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Acc, {ear2="Clearview Earring"})
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {sub="Legion Scutum",
		head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		ring1="Matrimony Ring",ring2="Defending Ring"}

	-- Idle sets
	sets.idle = {
		head="Arcadian Beret",neck="Twilight Torque",ear1="Volley Earring",ear2="Clearview Earring",
        body="Hachiryu Haramaki",hands="Orion Bracers +1",ring1="Matrimony Ring",ring2="Defending Ring",
		back="Lutian Cape",waist="Elanid Belt",legs="Arcadian Braccae",feet="Fajin Boots"}
	
	sets.idle.Town = {main="Hurlbat",sub="Legion Scutum",range="Nobility",ammo=DefaultAmmo,
		head="Arcadian Beret",neck="Twilight Torque",ear1="Volley Earring",ear2="Clearview Earring",
        body="Hachiryu Haramaki",hands="Orion Bracers +1",ring1="Matrimony Ring",ring2="Defending Ring",
		back="Lutian Cape",waist="Elanid Belt",legs="Arcadian Braccae",feet="Fajin Boots"}
	
	-- Defense sets
	sets.defense.PDT = {
		head="Iuitl Headpiece +1",neck="Twilight Torque",
		body="Orion Jerkin +1",hands="Orion Bracers +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Iuitl Tights +1",feet="Orion Socks +1"}

	sets.defense.MDT = {
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Orion Jerkin +1",hands="Orion Bracers +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Mollusca Cape",waist="Flume Belt",legs="Samnuha Tights",feet="Orion Socks +1"}

	sets.Kiting = {feet="Fajin Boots"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {
		head="Iuitl Headpiece +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Qaaxo Harness",hands="Floral Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Cetl Belt",legs={ name="Taeon Tights", augments={'Accuracy+3','"Triple Atk."+2','Crit. hit. damage +3%'}},feet="Taeon Boots"}

	sets.engaged.Acc = {
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Orion Jerkin +1",hands="Floral Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Samnuha Tights",feet="Orion Socks +1"}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {hands="Orion Bracers +1"})
	sets.buff.Camouflage = {body="Orion Jerkin +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		state.CombatWeapon:set(player.equipment.range)
	end

	if spell.action_type == 'Ranged Attack' or
	  (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
	end
	
	if state.DefenseMode.value ~= 'None' and spell.type == 'WeaponSkill' then
		-- Don't gearswap for weaponskills when Defense is active.
		eventArgs.handled = true
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
		equip(sets.buff.Barrage)
		eventArgs.handled = true
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Camouflage" then
		if gain then
			equip(sets.buff.Camouflage)
			disable('body')
		else
			enable('body')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			end
		elseif player.inventory[player.equipment.ammo].count < 15 then
			add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		end
	end
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 13)
end