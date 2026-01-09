_G.Settings = {
    ["AutoParry"] = {
        Enabled = true,
        Debug = true,

        ["Main"] = {
            Range = 15,
            Delay = 0, -- anything < than 0.6 could break it
            Chance = 100,
            RandomChance = false,
            Method = "Sound", -- Sound // Animation, sound will be always more accurate, use animation for legit porpuses
            CheckIfLooking = false,
            Threshold = 0.35,
        },

        ["Aimbot"] = {
            Enabled = false,
            Keybind = "LeftAlt",
            Hold = true,
            Hitpart = "Head",
            X = 0.01,
            Y = 0.01,
        },

        ["Miscellaneous"] = {
            HitboxExpander = false, -- your character must load first 
            ShowHBE = false,
            ShowRange = false,

            AntiAim = {
                Enabled = false,
                Frequency = 0.0003,
            },

            UnlockFPS = {
                Enabled = false,
                FPScap = 144,
            },
        },

        ["Anti"] = {
            Enabled = false, --- pending fixes DO NOT use
            Delay = 0.35,
            Range = 50,
        },

        ["Big"] = {
            Settings = {
                Head = false,
                Torso = false,
                HSize = 10,
                TSize = 10,
            }
        },

        ["Alternative"] = {
            AltBypass = false, 
            KDR = 1.5, 
        },

        ["Mistake"] = {
            Enabled = false, -- legit mistake 
            Range = 2,
            Chance = 0.5,
        },

        ["Custom"] = {
            Sounds = {
                Enabled = false,
                Hit = "Normal", -- TF2 // Damn // ClashR // Rust // HAHA // Bozo // CSGO // Boink // Fart // Rage
                Parry = "Normal", -- TF2 // RUST //  CSGO // FART // BOINK // RAGE
                Kill = "Normal", -- TF2 // RUST //  CSGO // FART // BOINK // RAGE
                Explosive = "Normal", -- TF2 // RUST //  CSGO // FART // BOINK // RAGE
                Nuke = "Normal", -- TF2 // RUST //  CSGO // FART // BOINK // RAGE
                Heal = "Normal", -- TF2 // RUST //  CSGO // FART // BOINK // RAGE
                Dash = "Normal", -- TF2 // RUST //  CSGO // FART // BOINK // RAGE
            },
        },

        ["Panic"] = {
            Enabled = true,
            Keybind = "L",
            HoldMode = {
                Enabled = false,
                Keybind = "C",
            },
        },
    }
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/WeLoveVast/stremeable.nettable/refs/heads/main/obsfutcatedsource.txt"))()
