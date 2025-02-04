

EFFECT.Mat = Material( "effects/tool_tracer" )
local matLight 	= Material( "effects/yellowflare" )

/*---------------------------------------------------------
   Init( data table )
---------------------------------------------------------*/
function EFFECT:Init( data )

	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	
	// Keep the start and end pos - we're going to interpolate between them
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.EndPos = data:GetOrigin()
	
	local Weapon = data:GetEntity()
	if ( IsValid( Weapon ) ) then
	
		local Owner = Weapon:GetOwner()
		if ( IsValid( Owner ) ) then
			local TeamID = Owner:Team()
			self.Color = team.GetColor( TeamID )
		end
	
	end
	
	self.Alpha = 255

end

/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )

	self.Alpha = self.Alpha - FrameTime() * 50
	
	self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos )
	
	if (self.Alpha < 0) then return false end
	return true

end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render( )

	if ( self.Alpha < 1 ) then return end
	

	self.Length = (self.StartPos - self.EndPos):Length()
		
	
	local texcoord = CurTime() * -0.2
	
	
	
	for i = 1, 10 do
	
		render.SetMaterial( self.Mat )
		
		texcoord = texcoord + i * 0.05 * texcoord
	
		render.DrawBeam( self.StartPos, 										// Start
						self.EndPos,											// End
						i * self.Alpha * 0.025,													// Width
						texcoord,														// Start tex coord
						texcoord + (self.Length / (128 + self.Alpha)),									// End tex coord
						self.Color )
						
		render.SetMaterial( matLight )

		render.DrawSprite( self.StartPos, i * 15, i * 15, Color( self.Color.r, self.Color.g, self.Color.b, self.Alpha ) )
		render.DrawSprite( self.EndPos, i * 15, i * 15, Color( self.Color.r, self.Color.g, self.Color.b, self.Alpha ) )
	
	end
	


end
