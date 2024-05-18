
-- Required:
--  "Something Needs Doing (Expanded Edition)" (to execute all this jazz) https://puni.sh/api/repository/croizat
--  "TextAdvance" (for /at) https://raw.githubusercontent.com/NightmareXIV/MyDalamudPlugins/main/pluginmaster.json
--  "Teleporter" (for /tp) MAIN REPO
--  "Lifestream" (for aeathernet tp within city) https://raw.githubusercontent.com/NightmareXIV/MyDalamudPlugins/main/pluginmaster.json

-- Settings

yield("/at enabled")        -- Enables TextAdvance
yield("/nastatus off")      -- Hides sprout status, this gets rid of a lot of social attention
                            -- TODO Turns off SND errors on /target fail automatically in SND settings

-- Initialization

Q_MSQ_1_0_lvl1_1:Execute()
Q_MSQ_1_0_lvl1_2:Execute(1)
Q_Making_a_Name:Execute()
Q_MSQ_1_0_lvl1_2:Execute()