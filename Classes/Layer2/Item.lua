local Item = {
    itemId = -1,
    
    GetAmount = function(self)
        return GetItemCount(self.ItemId)
    end,
}