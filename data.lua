---Has a list of all formatted entries added by add_entry(), and is processed and extended to data
---@type {name: string, science: [string,int][], prereqs: string[], icon: string, effects: data.ChangeRecipeProductivityModifier, formula: string}[]
local tech_entries = {}

---generates the productivit effects for the new technology for each input recipe
---@param recipes string[]
---@return data.ChangeRecipeProductivityModifier[]
local function generate_effects(recipes)
    local effects = {}
    for _, entry in pairs(recipes) do
        effects[#effects + 1] = {
            type = "change-recipe-productivity",
            recipe = entry,
            change = 0.1
        }
    end
    return effects
end

---Adds a convienent format entry to the tech_entries table
---@param params {name: string, icon: string, recipes: string[], formula?: string, science?: [string,int][], prereqs?: string[], custom?: string}
local function add_entry(params)
    if not params.name then
        error("add_entry() is missing the `name` field")
    end
    if not params.icon then
        error("add_entry() is missing the `icon` field")
    end
    if not params.recipes then
        error("add_entry() is missing the `recipes` field")
    end

    params.science = params.science or {}
    params.science[#params.science + 1] = {"automation-science-pack", 1}
    params.science[#params.science + 1] = {"logistic-science-pack", 1}
    params.science[#params.science + 1] = {"chemical-science-pack", 1}
    params.science[#params.science + 1] = {"production-science-pack", 1}

    params.prereqs = params.prereqs or {}
    params.prereqs[#params.prereqs + 1] = "production-science-pack"

    local index = #tech_entries + 1
    tech_entries[index] = {
        name = params.name,
        science = params.science,
        prereqs = params.prereqs,
        icon = params.icon,
        effects = generate_effects(params.recipes),
        formula = params.formula or "1.5^L*1000",
        custom = params.custom
    }
end

local function process_entries(entries)
    for _, entry in pairs(entries) do
        local locale = "item-name."..entry.name
        if entry.custom then
            locale = entry.custom..entry.name
        end

        local tech = {
            type = "technology",
            name = entry.name.."-productivity",
            localised_name = {"too-many-prods.productivity-function", {locale}, {"too-many-prods.productivity"}},
            icons = util.technology_icon_constant_recipe_productivity(entry.icon),
            icon_size = 256,
            effects = entry.effects,
            prerequisites = entry.prereqs,
            unit =
            {
                count_formula = entry.formula,
                ingredients = entry.science,
                time = 60
            },
            max_level = "infinite",
            upgrade = true
        }--[[@as data.TechnologyPrototype]]

        data:extend{tech}
    end
end

add_entry{
    name = "iron-plate",
    icon = "__too-many-prods__/graphics/iron-plate.png",
    recipes = {"iron-plate","casting-iron"}
}
add_entry{
    name = "iron-stick",
    icon = "__too-many-prods__/graphics/iron-stick.png",
    recipes = {"iron-stick","casting-iron-stick"}
}
add_entry{
    name = "iron-gear-wheel",
    icon = "__too-many-prods__/graphics/iron-gear.png",
    recipes = {"iron-gear-wheel","casting-iron-gear-wheel"}
}
add_entry{
    name = "copper-plate",
    icon = "__too-many-prods__/graphics/copper-plate.png",
    recipes = {"copper-plate","casting-copper"}
}
add_entry{
    name = "copper-cable",
    icon = "__too-many-prods__/graphics/copper-wire.png",
    recipes = {"copper-cable","casting-copper-cable"},
    prereqs = {"electronics"}
}
add_entry{
    name = "electronic-circuit",
    icon = "__base__/graphics/technology/electronics.png",
    recipes = {"electronic-circuit"},
    prereqs = {"electronics"}
}
add_entry{
    name = "advanced-circuit",
    icon = "__base__/graphics/technology/advanced-circuit.png",
    recipes = {"advanced-circuit"},
    prereqs = {"advanced-circuit"}
}
add_entry{
    name = "engine-unit",
    icon = "__base__/graphics/technology/engine.png",
    recipes = {"engine-unit"},
    prereqs = {"engine"}
}
add_entry{
    name = "electric-engine-unit",
    icon = "__base__/graphics/technology/electric-engine.png",
    recipes = {"electric-engine-unit"},
    prereqs = {"electric-engine"}
}
add_entry{
    name = "automation-science-pack",
    icon = "__base__/graphics/technology/automation-science-pack.png",
    recipes = {"automation-science-pack"},
    prereqs = {"automation-science-pack"}
}
add_entry{
    name = "logistic-science-pack",
    icon = "__base__/graphics/technology/logistic-science-pack.png",
    recipes = {"logistic-science-pack"},
    prereqs = {"logistic-science-pack"}
}
add_entry{
    name = "chemical-science-pack",
    icon = "__base__/graphics/technology/chemical-science-pack.png",
    recipes = {"chemical-science-pack"},
    prereqs = {"chemical-science-pack"}
}
add_entry{
    name = "production-science-pack",
    icon = "__base__/graphics/technology/production-science-pack.png",
    recipes = {"production-science-pack"},
}
add_entry{
    name = "utility-science-pack",
    icon = "__base__/graphics/technology/utility-science-pack.png",
    recipes = {"utility-science-pack"},
    science = {{"utility-science-pack", 1}},
    prereqs = {"utility-science-pack"}
}
add_entry{
    name = "space-science-pack",
    icon = "__base__/graphics/technology/space-science-pack.png",
    recipes = {"space-science-pack"},
    science = {{"space-science-pack", 1}},
    prereqs = {"space-science-pack"}
}
add_entry{
    name = "agricultural-science-pack",
    icon = "__space-age__/graphics/technology/agricultural-science-pack.png",
    recipes = {"agricultural-science-pack"},
    science = {{"space-science-pack", 1},{"agricultural-science-pack", 1}},
    prereqs = {"agricultural-science-pack"}
}
add_entry{
    name = "metallurgic-science-pack",
    icon = "__space-age__/graphics/technology/metallurgic-science-pack.png",
    recipes = {"metallurgic-science-pack"},
    science = {{"space-science-pack", 1},{"metallurgic-science-pack", 1}},
    prereqs = {"metallurgic-science-pack"}
}
add_entry{
    name = "electromagnetic-science-pack",
    icon = "__space-age__/graphics/technology/electromagnetic-science-pack.png",
    recipes = {"electromagnetic-science-pack"},
    science = {{"space-science-pack", 1},{"electromagnetic-science-pack", 1}},
    prereqs = {"electromagnetic-science-pack"}
}
add_entry{
    name = "cryogenic-science-pack",
    icon = "__space-age__/graphics/technology/cryogenic-science-pack.png",
    recipes = {"cryogenic-science-pack"},
    science = {{"space-science-pack", 1},{"electromagnetic-science-pack", 1},{"metallurgic-science-pack", 1},{"agricultural-science-pack", 1},{"cryogenic-science-pack", 1}},
    prereqs = {"cryogenic-science-pack"}
}
add_entry{
    name = "promethium-science-pack",
    icon = "__space-age__/graphics/technology/promethium-science-pack.png",
    recipes = {"promethium-science-pack"},
    science = {{"space-science-pack", 1},{"electromagnetic-science-pack", 1},{"metallurgic-science-pack", 1},{"agricultural-science-pack", 1},{"cryogenic-science-pack", 1},{"promethium-science-pack", 1}},
    prereqs = {"promethium-science-pack"}
}
add_entry{
    name = "explosives",
    icon = "__base__/graphics/technology/explosives.png",
    recipes = {"explosives"},
    prereqs = {"explosives"}
}
add_entry{
    name = "battery",
    icon = "__base__/graphics/technology/battery.png",
    recipes = {"battery"},
    prereqs = {"battery"}
}
add_entry{
    name = "sulfur",
    icon = "__base__/graphics/technology/sulfur-processing.png",
    recipes = {"sulfur","biosulfur"},
    science = {{"agricultural-science-pack",1}},
    prereqs = {"sulfur-processing","agricultural-science-pack"}
}
add_entry{
    name = "sulfuric-acid",
    icon = "__too-many-prods__/graphics/sulfuric-acid.png",
    recipes = {"sulfuric-acid"},
    prereqs = {"sulfur-processing"},
    custom = "fluid-name."
}
add_entry{
    name = "lubricant",
    icon = "__base__/graphics/technology/lubricant.png",
    science = {{"agricultural-science-pack",1}},
    recipes = {"lubricant","biolubricant"},
    prereqs = {"lubricant"},
    custom = "fluid-name."
}
add_entry{
    name = "oil-processing",
    icon = "__too-many-prods__/graphics/advanced-oil-processing.png",
    recipes = {"basic-oil-processing","advanced-oil-processing"},
    prereqs = {"advanced-oil-processing"},
    custom = "too-many-prods."
}
add_entry{
    name = "solid-fuel",
    icon = "__too-many-prods__/graphics/solid-fuel.png",
    recipes = {"solid-fuel-from-heavy-oil", "solid-fuel-from-light-oil", "solid-fuel-from-petroleum-gas","solid-fuel-from-ammonia"},
    prereqs = {"advanced-oil-processing"}
}
add_entry{
    name = "oil-cracking",
    icon = "__too-many-prods__/graphics/oil-cracking.png",
    recipes = {"heavy-oil-cracking", "light-oil-cracking"},
    prereqs = {"advanced-oil-processing"},
    custom = "too-many-prods."
}
add_entry{
    name = "flying-robot-frame",
    icon = "__base__/graphics/technology/robotics.png",
    recipes = {"flying-robot-frame"},
    prereqs = {"robotics"}
}
add_entry{
    name = "uranium-fuel-cell",
    icon = "__too-many-prods__/graphics/nuclear-fuel-cell.png",
    recipes = {"uranium-fuel-cell"},
    prereqs = {"nuclear-power"}
}
add_entry{
    name = "nuclear-fuel-reprocessing",
    icon = "__base__/graphics/technology/nuclear-fuel-reprocessing.png",
    recipes = {"nuclear-fuel-reprocessing"},
    prereqs = {"nuclear-fuel-reprocessing"},
    custom = "recipe-name."
}
add_entry{
    name = "bacteria-cultivation",
    icon = "__space-age__/graphics/technology/bacteria-cultivation.png",
    science = {{"space-science-pack",1}},
    recipes = {"iron-bacteria-cultivation","copper-bacteria-cultivation"},
    prereqs = {"bacteria-cultivation"},
    custom = "technology-name."
}
add_entry{
    name = "bioflux",
    icon = "__space-age__/graphics/technology/bioflux.png",
    science = {{"space-science-pack",1}},
    recipes = {"bioflux"},
    prereqs = {"bioflux"}
}
add_entry{
    name = "steam",
    icon = "__too-many-prods__/graphics/acid-neutralisation.png",
    science = {{"space-science-pack",1}},
    recipes = {"acid-neutralisation"},
    prereqs = {"calcite-processing"},
    custom = "fluid-name."
}
add_entry{
    name = "superconductor",
    icon = "__too-many-prods__/graphics/superconductor.png",
    science = {{"space-science-pack",1}},
    recipes = {"superconductor"},
    prereqs = {"electromagnetic-plant"}
}
add_entry{
    name = "supercapacitor",
    icon = "__too-many-prods__/graphics/supercapacitor.png",
    science = {{"space-science-pack",1}},
    recipes = {"supercapacitor"},
    prereqs = {"electromagnetic-plant"}
}
add_entry{
    name = "electrolyte",
    icon = "__too-many-prods__/graphics/electrolyte.png",
    science = {{"space-science-pack",1}},
    recipes = {"electrolyte"},
    prereqs = {"electromagnetic-plant"},
    custom = "fluid-name."
}
add_entry{
    name = "coal-liquefaction",
    icon = "__base__/graphics/technology/coal-liquefaction.png",
    science = {{"space-science-pack",1}},
    recipes = {"coal-liquefaction","simple-coal-liquefaction"},
    prereqs = {"coal-liquefaction"},
    custom = "recipe-name."
}
add_entry{
    name = "water",
    icon = "__too-many-prods__/graphics/steam-condensation.png",
    science = {{"space-science-pack",1}},
    recipes = {"steam-condensation","ice-melting"},
    prereqs = {"space-platform-thruster"},
    custom = "fluid-name."
}
add_entry{
    name = "holmium-processing",
    icon = "__space-age__/graphics/technology/holmium-processing.png",
    science = {{"space-science-pack",1}},
    recipes = {"holmium-solution","holmium-plate"},
    prereqs = {"holmium-processing"},
    custom = "technology-name."
}
add_entry{
    name = "uranium-processing",
    icon = "__base__/graphics/technology/kovarex-enrichment-process.png",
    science = {{"space-science-pack",1}},
    recipes = {"kovarex-enrichment-process", "uranium-processing"},
    prereqs = {"kovarex-enrichment-process"},
    custom = "technology-name."
}
add_entry{
    name = "carbon",
    icon = "__too-many-prods__/graphics/carbon.png",
    science = {{"space-science-pack",1},{"metallurgic-science-pack",1},{"agricultural-science-pack",1}},
    recipes = {"carbon","burnt-spoilage"},
    prereqs = {"tungsten-carbide","biochamber"}
}
add_entry{
    name = "tungsten-carbide",
    icon = "__space-age__/graphics/technology/tungsten-carbide.png",
    science = {{"space-science-pack",1},{"metallurgic-science-pack",1}},
    recipes = {"tungsten-carbide"},
    prereqs = {"tungsten-carbide"}
}
add_entry{
    name = "tungsten-plate",
    icon = "__space-age__/graphics/technology/tungsten-steel.png",
    science = {{"space-science-pack",1},{"metallurgic-science-pack",1}},
    recipes = {"tungsten-plate"},
    prereqs = {"tungsten-steel"}
}
add_entry{
    name = "molten-iron-and-copper",
    icon = "__too-many-prods__/graphics/molten-iron.png",
    science = {{"space-science-pack",1},{"metallurgic-science-pack",1}},
    recipes = {"molten-iron-from-lava","molten-copper-from-lava","molten-iron","molten-copper"},
    prereqs = {"foundry"},
    custom = "too-many-prods."
}
add_entry{
    name = "nutrients",
    icon = "__too-many-prods__/graphics/nutrients.png",
    science = {{"space-science-pack",1},{"agricultural-science-pack",1}},
    recipes = {"nutrients-from-yumako-mash","nutrients-from-bioflux","nutrients-from-biter-egg","nutrients-from-fish","nutrients-from-spoilage"}
}
add_entry{
    name = "jelly",
    icon = "__space-age__/graphics/technology/jellynut.png",
    science = {{"space-science-pack",1},{"agricultural-science-pack",1}},
    recipes = {"jellynut-processing"},
    prereqs = {"jellynut"}
}
add_entry{
    name = "yumako-mash",
    icon = "__space-age__/graphics/technology/yumako.png",
    science = {{"space-science-pack",1},{"agricultural-science-pack",1}},
    recipes = {"yumako-processing"},
    prereqs = {"yumako"}
}
add_entry{
    name = "carbon-fiber",
    icon = "__space-age__/graphics/technology/carbon-fiber.png",
    science = {{"space-science-pack",1},{"agricultural-science-pack",1}},
    recipes = {"carbon-fiber"},
    prereqs = {"carbon-fiber"}
}
add_entry{
    name = "biter-egg",
    icon = "__too-many-prods__/graphics/biter-egg.png",
    science = {{"space-science-pack",1},{"agricultural-science-pack",1}},
    recipes = {"biter-egg"},
    prereqs = {"captivity"}
}
add_entry{
    name = "pentapod-egg",
    icon = "__too-many-prods__/graphics/pentapod-egg.png",
    science = {{"space-science-pack",1},{"agricultural-science-pack",1}},
    recipes = {"pentapod-egg"},
    prereqs = {"biochamber"}
}
add_entry{
    name = "coal",
    icon = "__too-many-prods__/graphics/coal-synthesis.png",
    science = {{"space-science-pack",1},{"agricultural-science-pack",1}},
    recipes = {"coal-synthesis"},
    prereqs = {"rocket-turret"}
}
add_entry{
    name = "fluoroketone-hot",
    icon = "__too-many-prods__/graphics/fluoroketone-hot.png",
    science = {{"space-science-pack",1},{"agricultural-science-pack",1},{"metallurgic-science-pack",1},{"electromagnetic-science-pack",1},{"cryogenic-science-pack",1}},
    recipes = {"fluoroketone"},
    prereqs = {"cryogenic-plant"},
    custom = "fluid-name."
}
add_entry{
    name = "lithium",
    icon = "__space-age__/graphics/technology/lithium-processing.png",
    science = {{"space-science-pack",1},{"agricultural-science-pack",1},{"metallurgic-science-pack",1},{"electromagnetic-science-pack",1},{"cryogenic-science-pack",1}},
    recipes = {"lithium","lithium-plate"},
    prereqs = {"lithium-processing"}
}
add_entry{
    name = "quantum-processor",
    icon = "__space-age__/graphics/technology/quantum-processor.png",
    science = {{"space-science-pack",1},{"agricultural-science-pack",1},{"metallurgic-science-pack",1},{"electromagnetic-science-pack",1},{"cryogenic-science-pack",1}},
    recipes = {"quantum-processor"},
    prereqs = {"quantum-processor"}
}
add_entry{
    name = "fusion-power-cell",
    icon = "__too-many-prods__/graphics/fusion-power-cell.png",
    science = {{"space-science-pack",1},{"agricultural-science-pack",1},{"metallurgic-science-pack",1},{"electromagnetic-science-pack",1},{"cryogenic-science-pack",1}},
    recipes = {"fusion-power-cell"},
    prereqs = {"fusion-reactor"}
}
add_entry{
    name = "nuclear-fuel",
    icon = "__too-many-prods__/graphics/nuclear-fuel.png",
    science = {{"space-science-pack",1}},
    recipes = {"nuclear-fuel"},
    prereqs = {"kovarex-enrichment-process"}
}
add_entry{
    name = "thruster-fuel-and-oxidizer",
    icon = "__space-age__/graphics/technology/space-platform-thruster.png",
    science = {{"space-science-pack",1}},
    recipes = {"thruster-fuel","thruster-oxidizer","advanced-thruster-fuel","advanced-thruster-oxidizer"},
    prereqs = {"space-platform-thruster"},
    custom = "too-many-prods."
}
if settings.startup["tmp-fish-mode"].value then
    add_entry{
        name = "fish-breeding",
        icon = "__space-age__/graphics/technology/fish-breeding.png",
        science = {{"space-science-pack",1},{"agricultural-science-pack",1}},
        recipes = {"fish-breeding"},
        prereqs = {"fish-breeding"},
        custom = "technology-name."
    }
end


process_entries(tech_entries)