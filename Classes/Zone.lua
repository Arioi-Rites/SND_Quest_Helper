local Zone = {
    NAMEtoID = {
        ["Limsa_Lower_Decks"] = {id = 129, type="AY", commandName="Limsa"},
        ["Limsa_Upper_Decks_Marauders"] = {id = 181, type="AN", requires="Limsa_Lower_Decks", commandName="Marauders Guild"},
        ["Limsa_Upper_Decks_Aftcastle"] = {id = 181, type="AN", requires="Limsa_Lower_Decks", commandName="Aftcastle"},
        ["Default"] = {id = -1, type="None", commandName="None"}
    },
    IDtoNAME = {},
}

for name, obj in pairs(Zone.NAMEtoID) do
    Zone.IDtoNAME[obj.id] = name
end