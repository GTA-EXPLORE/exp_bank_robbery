-- ███████╗██╗  ██╗██████╗ ██╗      ██████╗ ██████╗ ███████╗
-- ██╔════╝╚██╗██╔╝██╔══██╗██║     ██╔═══██╗██╔══██╗██╔════╝
-- █████╗   ╚███╔╝ ██████╔╝██║     ██║   ██║██████╔╝█████╗  
-- ██╔══╝   ██╔██╗ ██╔═══╝ ██║     ██║   ██║██╔══██╗██╔══╝  
-- ███████╗██╔╝ ██╗██║     ███████╗╚██████╔╝██║  ██║███████╗
-- ╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

-- Join us and support us
-- 🎮 Discord: https://discord.gg/MjTkbWb3Bd
-- ☕ BuyMeACoffee: https://buymeacoffee.com/gtaexplore
-- 📺 Youtube: https://www.youtube.com/@gta-explore
                                                         
LANGUAGE = 'en'

MONEY_PER_STACK = 150
MONEY_TYPE = "money"

BANK_TIMER = 60 * 60000     -- 60 minutes

POLICE_REQUIRED = 0
POLICE_JOBS = {     --job = minimum rank, Example: police = 0,
    police = 0,
    sheriff = 0
}

POL_ALERT_TIME = 30 * 1000  -- 30 seconds
POL_ALERT_SPRITE = 108      -- radar_financier_strand...
POL_ALERT_COLOR = 1         -- Red
POL_ALERT_WAVE = true       -- Enables the blip wave.

HACK_ITEM = "laptop"        -- Required item to hack, Remove to allow anyone to hack.

BANKS = {
    pillbox = {
        vault_hack = {
            model = GetHashKey("v_corp_bk_secpanel"),
            position = vector3(147.25, -1046.259, 29.46812),
            rotation = vector3(0.0, 0.0, -110.1538)
        },
        vault_door = {
            model = GetHashKey("v_ilev_gb_vauldr"),
            position = vector3(148.0266, -1044.364, 28.35693),
            reset_yaw = -110.1538
        },
        first_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(150.62, -1045.29, 28.34),
            rotation = vector3(0.0, 0.0, 160.0)
        },
        door_hack = {
            model = GetHashKey("v_corp_bk_secpanel"),
            position = vector3(148.4648, -1046.6, 29.46809),
            rotation = vector3(0.0, 0.0, 159.9542)
        },
        door = {
            model = GetHashKey("v_ilev_gb_vaubar"),
            position = vector3(150.2913, -1047.629, 29.6663),
            reset_yaw = 159.9542
        },
        second_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(146.76, -1049.98, 28.34),
            rotation = vector3(0.0, 0.0, 300.0)
        },
        third_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(149.78, -1050.99, 28.34),
            rotation = vector3(0.0, 0.0, 20.0)
        }
    },

    vinewood = {
        vault_hack = {
            model = GetHashKey("v_corp_bk_secpanel"),
            position = vector3(311.5875, -284.6257, 54.26483),
            rotation = vector3(0.0, 0.0, -110.134)
        },
        vault_door = {
            model = GetHashKey("v_ilev_gb_vauldr"),
            position = vector3(312.358, -282.7301, 53.15365),
            reset_yaw = -110.134
        },
        first_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(314.98, -284.01, 53.14),
            rotation = vector3(0.0, 0.0, 139.14)
        },
        door_hack = {
            model = GetHashKey("v_corp_bk_secpanel"),
            position = vector3(312.797, -284.984, 54.2648),
            rotation = vector3(0.0, 0.0, 159.9542)
        },
        door = {
            model = GetHashKey("v_ilev_gb_vaubar"),
            position = vector3(314.6239, -285.9945, 54.46301),
            reset_yaw = 159.866
        },
        second_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(311.02, -288.16, 53.14),
            rotation = vector3(0.0, 0.0, 301.99)
        },
        third_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(314.15, -289.4, 53.14),
            rotation = vector3(0.0, 0.0, 26.81)
        }
    },

    hardwick = {
        vault_hack = {
            model = GetHashKey("v_corp_bk_secpanel"),
            position = vector3(-353.48, -55.48119, 49.13662),
            rotation = vector3(0.0, 0.0, -109.1402)
        },
        vault_door = {
            model = GetHashKey("v_ilev_gb_vauldr"),
            position = vector3(-352.7365, -53.57248, 48.02543),
            reset_yaw = -109.1402
        },
        first_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(-350.0, -54.72, 48.01),
            rotation = vector3(0.0, 0.0, 135.15)
        },
        door_hack = {
            model = GetHashKey("v_corp_bk_secpanel"),
            position = vector3(-352.25, -55.81, 49.13659),
            rotation = vector3(0.0, 0.0, 160.8598)
        },
        door = {
            model = GetHashKey("v_ilev_gb_vaubar"),
            position = vector3(-350.4144, -56.79705, 49.3348),
            reset_yaw = 160.8598
        },
        second_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(-353.95, -59.09, 48.01),
            rotation = vector3(0.0, 0.0, 298.21)
        },
        third_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(-350.84, -60.16, 48.16),
            rotation = vector3(0.0, 0.0, 28.58)
        }
    },

    del_perro = {
        vault_hack = {
            model = GetHashKey("v_corp_bk_secpanel"),
            position = vector3(-1210.42, -336.43, 37.88108),
            rotation = vector3(0.0, 0.0, -63.13626)
        },
        vault_door = {
            model = GetHashKey("v_ilev_gb_vauldr"),
            position = vector3(-1211.261, -334.5596, 36.76989),
            reset_yaw = -63.13626
        },
        first_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(-1208.64, -333.45, 36.75),
            rotation = vector3(0.0, 0.0, 194.95)
        },
        door_hack = {
            model = GetHashKey("v_corp_bk_secpanel"),
            position = vector3(-1209.31, -335.77, 37.88104),
            rotation = vector3(0.0, 0.0, -153.1363)
        },
        door = {
            model = GetHashKey("v_ilev_gb_vaubar"),
            position = vector3(-1207.328, -335.1289, 38.07925),
            reset_yaw = -153.1363
        },
        second_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(-1208.18, -339.3, 36.75),
            rotation = vector3(0.0, 0.0, 342.56)
        },
        third_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(-1205.21, -337.77, 36.75),
            rotation = vector3(0.0, 0.0, 73.64)
        }
    },

    ocean = {
        vault_hack = {
            model = GetHashKey("v_corp_bk_secpanel"),
            position = vector3(-2956.5, 482.064, 15.79713),
            rotation = vector3(0.0, 0.0, -2.457949)
        },
        vault_door = {
            model = GetHashKey("hei_prop_heist_sec_door"),
            position = vector3(-2958.539, 482.2706, 14.68594),
            reset_yaw = -2.457949
        },
        first_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(-2958.09, 485.19, 14.67),
            rotation = vector3(0.0, 0.0, 257.58)
        },
        door_hack = {
            model = GetHashKey("v_corp_bk_secpanel"),
            position = vector3(-2956.582, 483.3756, 15.7971),
            rotation = vector3(0.0, 0.0, -92.45795)
        },
        door = {
            model = GetHashKey("v_ilev_gb_vaubar"),
            position = vector3(-2956.116, 485.4206, 15.99531),
            reset_yaw = -92.45795
        },
        second_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(-2952.8, 482.73, 14.67),
            rotation = vector3(0.0, 0.0, 51.61)
        },
        third_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(-2952.8, 486.07, 14.67),
            rotation = vector3(0.0, 0.0, 137.3)
        }
    },
    
    route_66 = {
        vault_hack = {
            model = GetHashKey("v_corp_bk_secpanel"),
            position = vector3(1175.62, 2712.906, 38.18807),
            rotation = vector3(0.0, 0.0, 90.0)
        },
        vault_door = {
            model = GetHashKey("v_ilev_gb_vauldr"),
            position = vector3(1175.542, 2710.861, 37.07689),
            reset_yaw = 90.0
        },
        first_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(1172.49, 2711.1, 37.06),
            rotation = vector3(0.0, 0.0, 340.17)
        },
        door_hack = {
            model = GetHashKey("v_corp_bk_secpanel"),
            position = vector3(1174.354, 2712.82, 38.18804),
            rotation = vector3(0.0, 0.0, 0.0)
        },
        door = {
            model = GetHashKey("v_ilev_gb_vaubar"),
            position = vector3(1172.291, 2713.146, 38.38625),
            reset_yaw = 0
        },
        second_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(1174.88, 2716.49, 37.06),
            rotation = vector3(0.0, 0.0, 151.18)
        },
        third_cash = {
            model = GetHashKey("hei_prop_hei_cash_trolly_01"),
            position = vector3(1171.52, 2716.35, 37.06),
            rotation = vector3(0.0, 0.0, 229.56)
        }
    }
}

-- ██████╗  ██████╗     ███╗   ██╗ ██████╗ ████████╗     ██████╗██╗  ██╗ █████╗ ███╗   ██╗ ██████╗ ███████╗
-- ██╔══██╗██╔═══██╗    ████╗  ██║██╔═══██╗╚══██╔══╝    ██╔════╝██║  ██║██╔══██╗████╗  ██║██╔════╝ ██╔════╝
-- ██║  ██║██║   ██║    ██╔██╗ ██║██║   ██║   ██║       ██║     ███████║███████║██╔██╗ ██║██║  ███╗█████╗  
-- ██║  ██║██║   ██║    ██║╚██╗██║██║   ██║   ██║       ██║     ██╔══██║██╔══██║██║╚██╗██║██║   ██║██╔══╝  
-- ██████╔╝╚██████╔╝    ██║ ╚████║╚██████╔╝   ██║       ╚██████╗██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗
-- ╚═════╝  ╚═════╝     ╚═╝  ╚═══╝ ╚═════╝    ╚═╝        ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

SD.Locale.LoadLocale(LANGUAGE)