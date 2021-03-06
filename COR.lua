-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Ranged', 'Melee', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')

	gear.RAbullet = "Eminent Bullet"
	gear.WSbullet = "Eminent Bullet"
	gear.MAbullet = "Eminent Bullet"
	gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15

    -- Additional local binds
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body="Navarch's Frac +2"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac"}
	sets.precast.JA['Crooked Cards'] = {body="Lanun Frac"}
    
    sets.precast.CorsairRoll = {ring1="Luzaf's Ring",ring2="Barataria Ring",head="Lanun Tricorne",hands="Navarch's Gants +2"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Navarch's Culottes +2"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Navarch's Bottes +2"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Navarch's Tricorne +2"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Navarch's Frac +2"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Navarch's Gants +2"})
    
    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants"}
    
    sets.precast.CorsairShot = {head="Blood Mask"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Whirlpool Mask",neck="Fortitude Torque",ear1="Soil Pearl",ear2="Soil Pearl",
		body="Iuitl Vest +1",hands="Slither Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Thur. Boots +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {head="Anwig Salade",ear2="Loquacious Earring",body="Mirke Wardecors",neck="Jeweled Collar",
	hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",back="Mujin Mantle",
	legs={ name="Taeon Tights", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+2',}}}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    sets.precast.RA = {ammo=gear.RAbullet,		
		head="Navarch's Tricorne +2",neck="Peacock Amulet",ear2="Clearview Earring",ear1="Volley Earring",
		body="Lak. Frac",hands="Floral Gauntlets",ring1="Hajduk Ring",ring2="Hajduk Ring",
		back="Gunslinger's Cape",waist="Elanid Belt",legs="Lanun Culottes",feet="Lak. Bottes"}

	sets.midcast.RangedAttack = {ammo=gear.RAbullet,
		head="Lanun Tricorne",neck="Ocachi Gorget",ear2="Clearview Earring",ear1="Volley Earring",
		body="Lak. Frac",hands="Manibozho Gloves",ring1="Hajduk Ring",ring2="Hajduk Ring",
		back="Libeccio Mantle",waist="Impulse Belt",legs="Samnuha Tights",feet="Lak. Bottes"}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Iuitl Headgear +1",neck="Ocachi Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest +1",hands="Floral Gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Elanid Belt",legs="Iuitl Tights +1",feet="Iuitl Gaiters +1"}


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
 sets.precast.WS['Evisceration'] = sets.precast.WS

	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {legs="Samnuha Tights",ring1="Garuda Ring",ring2="Garuda Ring"})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {legs="Samnuha Tights"})

	sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
		head="Lanun Tricorne",neck="Fotia Gorget",ear2="Clearview Earring",ear1="Suppanomimi",
		body="Lak. Frac",hands="Sigyn's Bazubands",ring1="Garuda Ring",ring2="Garuda Ring",
		back="Terebellum Mantle",waist="Fotia Belt",legs="Kaabnax  Trousers",feet="Taeon Boots"}

	sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet,
		head="Lanun Tricorne",neck="Fotia Gorget",ear2="Clearview Earring",ear1="Suppanomimi",
		body="Lak. Frac",hands="Sigyn's Bazubands",ring1="Garuda Ring",ring2="Garuda Ring",
		back="Terebellum Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Taeon Boots"}
		--feet="Lak. Bottes

	sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
		head="Thaumas Hat",neck="Stoicheion Medal",ear2="Friomisi Earring",ear1="Hecate's Earring",
		body="Lanun Frac",hands="Leyline Gloves",ring1="Garuda Ring",ring2="Garuda Ring",
		back="Gunslinger's Cape",waist="Aquiline Belt",
		legs={ name="Taeon Tights", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		feet="Lanun Bottes"}

	sets.precast.WS['Wildfire'].Brew = {ammo=gear.MAbullet,
		head="Thaumas Hat",neck="Stoicheion Medal",ear2="Friomisi Earring",ear1="Hecate's Earring",
		body="Lanun Frac",hands="Leyline Gloves",ring1="Garuda Ring",ring2="Acumen Ring",
		back="Gunslinger's Cape",waist="Fotia Belt",
		legs={ name="Taeon Tights", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		feet="Lanun Bottes"}

	sets.precast.WS['Leaden Salute'] = sets.precast.WS['Wildfire']
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
		head="Anwig Salade",neck="Jeweled Collar",
		body="Mirke Wardecors",hands="Leyline Gloves",back="Mujin Mantle",
		legs="Blood Cuisses",feet="Iuitl Gaiters +1",ring1="Weatherspoon Ring",ring2="Prolix Ring"}
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {ammo=gear.QDbullet,
		head="Thaumas Hat",neck="Stoicheion Medal",ear2="Friomisi Earring",ear1="Hecate's Earring",
		body="Lanun Frac",hands="Navarch's gants +2",ring1="Garuda Ring",ring2="Arvina Ringlet",
		back="Toro Cape",waist="Aquiline Belt",
		legs={ name="Taeon Tights", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		feet="Lanun Bottes"}

    sets.midcast.CorsairShot.Acc = {ammo=gear.QDbullet,
		head="Thaumas Hat",neck="Stoicheion Medal",ear2="Friomisi Earring",ear1="Hecate's Earring",
		body="Lanun Frac",hands="Navarch's gants +2",ring1="Garuda Ring",ring2="Arvina Ringlet",
		back="Toro Cape",waist="Aquiline Belt",
		legs={ name="Taeon Tights", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		feet="Lanun Bottes"}

    sets.midcast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
		head="Thaumas Hat",neck="Stoicheion Medal",ear2="Friomisi Earring",ear1="Hecate's Earring",
		body="Lanun Frac",hands="Navarch's gants +2",ring1="Garuda Ring",ring2="Arvina Ringlet",
		back="Toro Cape",waist="Aquiline Belt",
		legs={ name="Taeon Tights", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		feet="Lanun Bottes"}

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']


    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
		head="Lanun Tricorne",neck="Ocachi Gorget",ear2="Clearview Earring",ear1="Volley Earring",
		body="Lak. Frac",hands="Manibozho Gloves",ring1="Hajduk Ring",ring2="Hajduk Ring",
		back="Libeccio Mantle",waist="Impulse Belt",legs="Samnuha Tights",feet="Lak. Bottes"}

    sets.midcast.RA.Acc = {ammo=gear.RAbullet,
		head="Lanun Tricorne",neck="Ocachi Gorget",ear2="Clearview Earring",ear1="Volley Earring",
		body="Lak. Frac",hands="Floral Gauntlets",ring1="Hajduk Ring",ring2="Hajduk Ring",
		back="Gunslinger's Cape",waist="Impulse Belt",legs="Samnuha Tights",feet="Lak. Bottes"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Ocachi Gorget",ring1="Dark Ring",ring2="Defending Ring"}
    

    -- Idle sets
    sets.idle = {ammo=gear.RAbullet,
		head="Lanun Tricorne",neck="Ocachi Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Lanun Frac",hands="Lanun Gants",ring1="Matrimony Ring",ring2="Defending Ring",
		back="Gunslinger's Cape",waist="Elanid Belt",legs="Lanun Culottes",feet="Hermes' Sandals"}

    sets.idle.Town = {main="Surcouf's Jambiya",sub="Legion Scutum",range="Doomsday",ammo=gear.RAbullet,
		head="Lanun Tricorne",neck="Ocachi Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Lanun Frac",hands="Lanun Gants",ring1="Matrimony Ring",ring2="Defending Ring",
		back="Gunslinger's Cape",waist="Elanid Belt",legs="Lanun Culottes",feet="Hermes' Sandals"}
    
    -- Defense sets
    sets.defense.PDT = {
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Clearview Earring",ear2="Volley Earring",
		body="Iuitl Vest +1",hands="Iuitl Wristbands +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Samnuha Tights",feet="Iuitl Gaiters +1"}

    sets.defense.MDT = {
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Clearview Earring",ear2="Volley Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Defending Ring",
		back="Engulfer Cape",waist="Flume Belt",legs="Samnuha Tights",feet="Iuitl Gaiters +1"}
    

    sets.Kiting = {feet="Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged.Melee = {ammo=gear.RAbullet,
		head="Lanun Tricorne",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Lanun Frac",hands="Lanun Gants",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Cetl Belt",legs="Lanun Culottes",feet="Lanun Bottes"}
    
    sets.engaged.Acc = {ammo=gear.RAbullet,
		head="Lanun Tricorne",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Lanun Frac",hands="Lanun Gants",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Cetl Belt",legs="Lanun Culottes",feet="Lanun Bottes"}

    sets.engaged.Melee.DW = {ammo=gear.RAbullet,
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
    
    sets.engaged.Acc.DW = {ammo=gear.RAbullet,
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}


    sets.engaged.Ranged = {ammo=gear.RAbullet,
        head="Whirlpool Mask",neck="Twilight Torque",ear1="Clearview Earring",ear2="Volley Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 14)
end