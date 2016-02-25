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
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Special')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
    
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto",hands="Sakonji Kote",back="Takaha Mantle"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Yaoyotl Helm",neck="Fortitude Torque",ear1="Soil Pearl",ear2="Soil Pearl",
		body="Found. Breastplate",hands="Slither Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Founder's Hose",feet="Amm Greaves"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Potestas Bomblet",
		head="Otomi Helm",neck="Justiciar's Torque",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Phorcys Korazin",hands="Acro Gauntlets",ring1="Rajas Ring",ring2="Pyrosoul Ring",
		back="Buquwik Cape",waist="Windbuffet Belt",legs="Founder's Hose",feet="Acro Leggings"}--Founder's Breastplate/Founder's Gauntlets/Founder's Hose/Founder's Greaves/Founder's Corona
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {back="Letalis Mantle",waist="Anguinus Belt"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})
	sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})
	sets.precast.WS['Tachi: Fudo'].Mod = set_combine(sets.precast.WS['Tachi: Fudo'], {waist="Fotia Belt"})

	sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})
	sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})
	sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {waist="Fotia Belt"})

	sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})
	sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",waist="Fotia Belt"})
	sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'], {waist="Fotia Belt"})

	sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})

	sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})

	sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})

	sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})

	sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})


    -- Midcast Sets
    sets.midcast.FastRecast = {
		head="Yaoyotl Helm",ear2="Loquacious Earring",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		neck="Jeweled Collar",
		body="Otro. Harness +1",hands="Leyline Gloves",
		legs="Founder's Hose",feet="Otronif Boots +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Wiglen Gorget",ring1="Dark Ring",ring2="Defending Ring"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {main="Tsurumaru", sub="Pole Grip",ammo="Hagneia Stone",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Twilight Mail",hands="Otronif Gloves +1",ring1="Matrimony Ring",ring2="Defending Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Otronif Brais +1",feet="Danzo Sune-ate"}
    
    sets.idle.Field = {ammo="Hagneia Stone",
		head="Twilight Helm",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Twilight Mail",hands="Otronif Gloves +1",ring1="Matrimony Ring",ring2="Defending Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Otronif Brais +1",feet="Danzo Sune-ate"}

    sets.idle.Weak = {ammo="Hagneia Stone",
		head="Twilight Helm",neck="Twiligh Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Twilight Mail",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Otronif Brais +1",feet="Danzo Sune-ate"}
    
    -- Defense sets
    sets.defense.PDT = {
		head="Founder's Corona",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Otronif Brais +1",feet="Amm Greaves"}

    sets.defense.Reraise = {
		head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Leyline Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Iximulew Cape",waist="Flume Belt",legs="Otronif Brais +1",feet="Amm Greaves"}

    sets.defense.MDT = {
		head="Founder's Corona",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Found. Breastplate",hands="Founder's Gauntlets",ring1="Dark Ring",ring2="Defending Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Founder's Hose",feet="Amm Greaves"}

    sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {ammo="Hagneia Stone",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Unkai Domaru +2",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Takaha Mantle",waist="Goading Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
    sets.engaged.Acc = {ammo="Hagneia Stone",
		head="Yaoyotl Helm",neck="Peacock Amulet",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Found. Breastplate",hands="Leyline Gloves",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Otronif Brais +1",feet="Founder's Greaves"}
    sets.engaged.Special = {ammo="Hagneia Stone",
		head="Founder's Corona",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Found. Breastplate",hands="Founder's Gauntlets",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Founder's Hose",feet="Loyalist Sabatons"}
	sets.engaged.PDT = {ammo="Hagneia Stone",
        head="Founder's Corona",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Found. Breastplate",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Defending Ring",
        back="Iximulew Cape",waist="Goading Belt",legs="Otronif Brais +1",feet="Amm Greaves"}
    sets.engaged.Acc.PDT = {ammo="Hagneia Stone",
        head="Otronif Mask +1",neck="Peacock Amulet",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Otronif Harness +1",hands="Leyline Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Letalis Mantle",waist="Anguinus Belt",legs="Unkai Haidate +2",feet="Amm Greaves"}
    sets.engaged.Reraise = {ammo="Hagneia Stone",
        head="Twilight Helm",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Twilight Mail",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Ik Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
    sets.engaged.Acc.Reraise = {ammo="Hagneia Stone",
        head="Twilight Helm",neck="Peacock Amulet",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Twilight Mail",hands="Leyline Gloves",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Letalis Mantle",waist="Anguinus Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
    sets.engaged.Adoulin = {ammo="Hagneia Stone",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Unkai Domaru +2",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Takaha Mantle",waist="Goading Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
    sets.engaged.Adoulin.Acc = {ammo="Hagneia Stone",
		head="Yaoyotl Helm",neck="Peacock Amulet",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Found. Breastplate",hands="Leyline Gloves",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
    sets.engaged.Adoulin.Special = {ammo="Hagneia Stone",
		head="Founder's Corona",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Found. Breastplate",hands="Founder's Gauntlets",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Founder's Hose",feet="Loyalist Sabatons"}
	sets.engaged.Adoulin.PDT = {ammo="Hagneia Stone",
        head="Otronif Mask +1",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Defending Ring",
        back="Iximulew Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Amm Greaves"}
    sets.engaged.Adoulin.Acc.PDT = {ammo="Hagneia Stone",
        head="Otronif Mask +1",neck="Peacock Amulet",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Otronif Harness +1",hands="Leyline Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Letalis Mantle",waist="Anguinus Belt",legs="Unkai Haidate +2",feet="Amm Greaves"}
    sets.engaged.Adoulin.Reraise = {ammo="Hagneia Stone",
        head="Twilight Helm",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Twilight Mail",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Ik Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
    sets.engaged.Adoulin.Acc.Reraise = {ammo="Hagneia Stone",
        head="Twilight Helm",neck="Peacock Amulet",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Twilight Mail",hands="Leyline Gloves",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Letalis Mantle",waist="Anguinus Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}


    sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
    sets.buff.Sengikori = {feet="Unkai Sune-ate +2"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
    end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 11)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 11)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 11)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 11)
    else
        set_macro_page(1, 11)
    end
end

