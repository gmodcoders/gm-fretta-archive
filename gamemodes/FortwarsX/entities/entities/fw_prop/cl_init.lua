
include( "shared.lua" )
 
--[[---------------------------------------------------------
   Name: Draw
   Purpose: Draw the model in-game.
   Remember, the things you render first will be underneath!
---------------------------------------------------------]]

function ENT:Draw()

    --self.BaseClass.Draw(self)  			-- We want to override rendering, so don't call baseclass.

    self.Entity:DrawModel()

end
