
-- Required:
--  "Something Needs Doing (Expanded Edition)" (to execute all this jazz) https://puni.sh/api/repository/croizat
--  "TextAdvance" (for /at) https://raw.githubusercontent.com/NightmareXIV/MyDalamudPlugins/main/pluginmaster.json
--  "Teleporter" (for /tp) MAIN REPO
--  "Lifestream" (for aeathernet tp within city) https://raw.githubusercontent.com/NightmareXIV/MyDalamudPlugins/main/pluginmaster.json

-- Initialization
yield("/at enabled")
yield("/nastatus off")

MSQ_1_0_lvl1_1:Execute()
MSQ_1_0_lvl1_2:Execute(1)
Q_Making_a_Name:Execute()
MSQ_1_0_lvl1_2:Execute()