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
    indi_timer = ''
    indi_duration = 180
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.weaponskill_waist = "Fotia Belt"

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
	sets.precast.JA['Cardinal Chant'] = {head="Geo. Galero +1"}
	sets.precast.JA['Collimated Fervor'] = {head="Bagua Galero"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}
	sets.precast.JA['Life Cycle'] = {body="Geo. Tunic +1"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants"}
	sets.precast.JA['Full Cycle'] = {hands="Bagua Mitaines"}
	sets.precast.JA['Bolster'] = {body="Bagua Tunic"}
	
    -- Fast cast sets for spells

    sets.precast.FC = {
		head="Nahtirah Hat",neck="Jeweled Collar",ear2="Loquacious Earring",
		body="Hagondes Coat +1",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Lifestream Cape",waist="Witful Belt",legs="Geo. Pants +1",feet="Regal Pumps"}

	sets.precast.FC.Cure = {main="Tamaxchi",
		head="Nahtirah Hat",ear2="Loquacious Earring",neck="Jeweled Collar",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Geo. Pants +1",feet="Regal Pumps"}

    --sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})

    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {head="Geo. Galero +1",neck="Fotia Gorget",ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Geo. Tunic +1",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Lifestream Cape",waist="Fotia Belt",legs="Theurgist's Slacks",feet="Umbani Boots"}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Flash Nova'] = {
		head="Nahtirah Hat",neck="Stoicheion Medal",ear2="Friomisi Earring",ear1="Hecate's Earring",
		body="Witching Robe",hands="Yaoyotl Gloves",ring1="Strendu Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Lengo Pants",feet="Hag. Sabots +1"}
    
	sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}

	sets.precast.WS['Exudation'] = {head="Buremte Hat",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Geo. Tunic +1",hands="Bagua Mitaines",ring1="Aquasoul Ring",ring2="Aquasoul Ring",
		back="Toro Cape",waist="Cetl Belt",legs="Lengo Pants",feet="Bagua Sandals"}

	sets.precast.WS['Realmrazer'] = {head="Buremte Hat",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Geo. Tunic +1",hands="Yaoyotl Gloves",ring1="Aquasoul Ring",ring2="Aquasoul Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Lengo Pants",feet="Umbani Boots"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Hagondes Coat +1",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Lifestream Cape",waist="Witful Belt",legs="Geo. Pants +1",feet="Regal Pumps"}

    sets.midcast.Geomancy = {range="Dunna",
		head="Azimuth Hood",body="Bagua Tunic",hands="Geo. Mitaines +1",
		legs="Bagua Pants",feet="Medium's Sabots",
		ear1="Gifted Earring",ear2="Magnetic Earring",
		back="Lifestream Cape",waist="Austerity Belt"}
		
    sets.midcast.Geomancy.Indi = {range="Dunna",
		head="Azimuth Hood",body="Bagua Tunic",hands="Geo. Mitaines +1",
		legs="Bagua Pants",feet="Azimuth Gaiters",
		ear1="Gifted Earring",ear2="Magnetic Earring",
		back="Lifestream Cape",waist="Austerity Belt"}

    sets.midcast.Cure = set_combine(sets.precast.FC, {main="Tamaxchi",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix ring",
		back="Pahtli Cape",legs="Nares Trews",feet="Regal Pumps"})
    
    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Protectra = set_combine(sets.precast.FC, {ring1="Sheltered Ring"})
	sets.midcast.Protect = sets.midcast.Protectra
	
	sets.midcast.Shellra = set_combine(sets.precast.FC, {ring1="Sheltered Ring"})
	sets.midcast.Shell = sets.midcast.Shellra

	sets.midcast.Stoneskin = set_combine(sets.precast.FC, {waist="Siegel Sash",ear1="Earthcry Earring",legs="Haven Hose"})
	
	sets.midcast.Regen = set_combine(sets.precast.FC, {main="Bolelabunga",body="Telchine Chas."})

	sets.midcast['Elemental Magic'] = {main="Divinity",
		head="Buremte Hat",neck="Eddy Necklace",ear2="Friomisi Earring",ear1="Hecate's Earring",
		body="Witching Robe",hands="Yaoyotl Gloves",ring2="Acumen Ring",ring1="Strendu Ring",
		back="Searing Cape",waist="Aswang Sash",legs="Theurgist's Slacks",feet="Umbani Boots"}--Azimuth Coat
	
	sets.midcast['Enfeebling Magic'] = {main="Divinity",
		head="Buremte Hat",neck="Eddy Necklace",ear2="Lifestorm Earring",ear1="Psystorm Earring",
		body="Azimuth Coat",hands="Azimuth Gloves",ring2="Sangoma Ring",ring1="Strendu Ring",
		back="Lifestream Cape",waist="Aswang Sash",legs="Theurgist's Slacks",feet="Umbani Boots"}
	
	sets.midcast.Drain = {main="Divinity",
		head="Bagua Galero",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Geo. Tunic +1",hands="Yaoyotl Gloves",ring1="Excelsis Ring",ring2="Sangoma Ring",
		back="Lifestream Cape",waist="Fucho-No-Obi",legs="Azimuth Tights",feet="Umbani Boots"}

	sets.midcast.Aspir = sets.midcast.Drain
	
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {main="Owleyes",head="Wivre Hairpin",neck="Twilight Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat +1",hands="Bagua Mitaines",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants",feet="Serpentes Sabots"}

		
																	-- EMPERYAN ARMOR :

--Azimuth Hood = DEF:72 HP+15 MP+46 STR+10 DEX+10 VIT+10 AGI+2 INT+21 MND+13 CHR+13 Evasion+15 Magic Evasion+58 "Magic Def. Bonus"+3 Haste+5% Geomancy skill +10 "Full Circle"+1 Luopan: "Regen"+2 Set: MP occasionally not depleted when using geomancy spells


--Azimuth Coat = DEF:92 HP+23 MP+56 STR+12 DEX+12 VIT+12 AGI+12 INT+22 MND+17 CHR+17 Evasion+17 Magic Evasion+62 Magic Accuracy+13 "Magic Atk. Bonus"+13 "Magic Def. Bonus"+3 Haste+2% Elemental magic skill +13 Enmity-7 "Refresh"+2 Set: MP occasionally not depleted when using geomancy spells


--Azimuth Gloves = DEF:62 HP+8 MP+57 STR+4 DEX+16 VIT+14 AGI+3 INT+13 MND+20 CHR+11 Magic Accuracy+17 Evasion+8 Magic Evasion+32 "Magic Def. Bonus"+1 Enfeebling magic skill +13 Haste+3% Enmity-10 Set: MP occasionally not depleted when using geomancy spells


--Azimuth Tights = DEF:80 HP+18 MP+36 STR+13 VIT+5 AGI+10 INT+31 MND+14 CHR+11 Magic Accuracy+10 "Magic Atk. Bonus"+10 Evasion+11 Magic Evasion+80 "Magic Def. Bonus"+3 Dark magic skill +15 Haste+4% Set: MP occasionally not depleted when using geomancy spells


--Azimuth Gaiters = DEF:49 HP+34 MP+47 STR+5 DEX+5 VIT+5 AGI+18 INT+12 MND+11 CHR+20 Evasion+28 Magic Evasion+80"Magic Def. Bonus"+3 Haste+3% "Indicolure" spell duration +15 Physical damage taken -3% Set: MP occasionally not depleted when using geomancy spells


    -- Idle sets

    sets.idle = {main="Owleyes",sub="Legion Scutum",range="Dunna",
		head="Wivre Hairpin",neck="Twilight Torque",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Hagondes Coat +1",hands="Bagua Mitaines",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants",feet="Geo. Sandals +1"}--Arciela's Grace +1,Lifestream Cape

    sets.idle.PDT = {main="Divinity",sub="Legion Scutum",range="Dunna",
		head="Wivre Hairpin",neck="Twilight Torque",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Hagondes Coat +1",hands="Geo. Mitaines +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants",feet="Geo. Sandals +1"}

	sets.idle.MDT = {main="Divinity",range="Dunna",
		head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat +1",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hag. Sabots +1"}	
		
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Owleyes",sub="Legion Scutum",range="Dunna",
		head="Wivre Hairpin",neck="Twilight Torque",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Hagondes Coat +1",hands="Geo. Mitaines +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Lifestream Cape",waist="Fucho-No-Obi",legs="Bagua Pants",feet="Bagua Sandals"}

    sets.idle.PDT.Pet = {main="Divinity",sub="Legion Scutum",range="Dunna",
		head="Wivre Hairpin",neck="Twilight Torque",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Hagondes Coat +1",hands="Geo. Mitaines +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants",feet="Geo. Sandals +1"}

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {legs="Bagua Pants"})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {legs="Bagua Pants"})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {legs="Bagua Pants"})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {legs="Bagua Pants"})

    sets.idle.Town = {main="Owleyes",sub="Legion Scutum",range="Dunna",
		head="Wivre Hairpin",neck="Twilight Torque",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Hagondes Coat +1",hands="Bagua Mitaines",ring1="Matrimony Ring",ring2="Defending Ring",
		back="Lifestream Cape",waist="Fucho-No-Obi",legs="Assiduity Pants",feet="Geo. Sandals +1"} --Bolelabunga

    sets.idle.Weak = {main="Owleyes",sub="Legion Scutum",range="Dunna",
		head="Wivre Hairpin",neck="Twilight Torque",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Hagondes Coat +1",hands="Bagua Mitaines",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants",feet="Geo. Sandals +1"}

    -- Defense sets

    sets.defense.PDT = {main="Divinity",range="Dunna",
		head="Hagondes Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat +1",hands="Geo. Mitaines +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hag. Sabots +1"}

    sets.defense.MDT = {main="Divinity",range="Dunna",
		head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat +1",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hag. Sabots +1"}

    sets.Kiting = {feet="Geo. Sandals +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {main="Divinity",range="Dunna",
		head="Geo. Galero +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Hagondes Coat +1",hands="Geo. Mitaines +1",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Umbra Cape",waist="Cetl Belt",legs="Theurgist's Slacks",feet="Umbani Boots"}

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(4, 18)
end
