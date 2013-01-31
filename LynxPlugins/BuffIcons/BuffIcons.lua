
import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI.Extensions";

local baseImageID = 0x41007E35;

BuffIconTest = class( Turbine.UI.Extensions.SimpleWindow );

function BuffIconTest:Constructor()
	Turbine.UI.Extensions.SimpleWindow.Constructor( self );

	self:SetSize(64,64);
	self:SetPosition(50,350);
	local imageId = baseImageID + math.floor( 60 * 0.33 );
	-- self:SetBackground(imageId);
	-- self:SetBackground("LynxPlugins/BuffIcons/Resources/sk_burglar_knivesout_r1.tga");

	self:SetVisible( true );
	-- self:SetOpacity( 1 );

	-- icon (test)
	self.icon = Turbine.UI.Window();
	self.icon:SetParent( self );
	self.icon:SetSize(32,32);
	self.icon:SetPosition(0,0);
	-- self.icon:SetStretchMode( 3 );
	-- self.icon:SetMouseVisible( false );
	self.icon:SetZOrder( 25 );
	self.icon:SetOpacity( 1 );
	-- self.icon:SetBackColor( Turbine.UI.Color( 0.7, 0.5, 0.5, 0.9 ) );
	-- self.icon:SetBackColorBlendMode( 3 );
	self.icon:SetBackground("LynxPlugins/BuffIcons/Resources/sk_burglar_knivesout_r1.tga");
	self.icon:SetVisible( true );
	-- self.icon:SetBlendMode( 3 );

	-- crop (test)
	self.crop = Turbine.UI.Window();
	self.crop:SetParent( self );
	-- self.crop:SetStretchMode( 3 );
	-- self.crop:SetMouseVisible( false );
	self.crop:SetZOrder( 120 );
	self.crop:SetPosition( 0, 0 );
	self.crop:SetSize( 32, 32 );
	self.crop:SetOpacity( 0.6 );
	self.crop:SetBackground( "LynxPlugins/BuffIcons/Resources/30s.tga" );
	-- self.crop:SetBackColor( Turbine.UI.Color( 0.0, 0.5, 0.5, 0.9 ) );
	-- self.crop:SetBackColorBlendMode( 6 );
	self.crop:SetBlendMode( 4 ); -- 4 adds opaque part (yay!)
	self.crop:SetVisible( true );

	-- holder (test)
	self.holder = Turbine.UI.Control();
	self.holder:SetParent( self.crop );
	-- self.holder:SetStretchMode( 3 );
	self.holder:SetMouseVisible( false );
	self.holder:SetZOrder( 50 );
	self.holder:SetOpacity( 0.7 );
	-- self.holder:SetBackColor( Turbine.UI.Color( 0.7, 0.5, 0.5, 0.9 ) );
	-- self.holder:SetBackColorBlendMode( 3 );
	-- self.holder:SetParent( self );
	-- self.holder:SetBlendMode( 3 );
	--[[self.holder:SetPosition( 0, 0 );
	self.holder:SetSize( 32, 32 );]]--
	self.holder:SetPosition( 0, 16 );
	self.holder:SetSize( 16, 16 );
	self.holder:SetVisible( true );

	-- overlay
	self.elapsedOverlay = Turbine.UI.Control();
	self.elapsedOverlay:SetParent( self.holder );
	--[[self.elapsedOverlay:SetPosition( 0, 0 );
	self.elapsedOverlay:SetSize( 32, 32 );]]--
	self.elapsedOverlay:SetPosition( 0, -16 );
	self.elapsedOverlay:SetSize( 32, 32 );
	-- self.elapsedOverlay:SetStretchMode( 3 );
	-- self.elapsedOverlay:SetMouseVisible( false );
	self.elapsedOverlay:SetZOrder( 100 );
	-- self.elapsedOverlay:SetOpacity( 0.7 );
	self.elapsedOverlay:SetBackground( "LynxPlugins/BuffIcons/Resources/9s.tga" );
	-- self.elapsedOverlay:SetBackground( "TurbinePlugins/Examples/Resources/StatusIcon2.tga" );
	-- self.elapsedOverlay:SetBackColor( Turbine.UI.Color( 1.0, 0, 0, 0.8 ) );
	-- self.elapsedOverlay:SetBackColorBlendMode( 3 );
	self.elapsedOverlay:SetBlendMode( 0 );


	-- tint (test)
	self.tint = Turbine.UI.Control();
	-- self.tint:SetStretchMode( 3 );
	-- self.tint:SetMouseVisible( false );
	self.tint:SetZOrder( 150 );
	-- self.tint:SetOpacity( 0.7 );
	self.tint:SetBackColor( Turbine.UI.Color( 1, 0, 0, 0.2 ) );
	self.tint:SetBackColorBlendMode( 5 );
	-- self.tint:SetParent( self.elapsedOverlay );
	self.tint:SetParent( self.crop );
	-- self.tint:SetBlendMode( 3 );
	self.tint:SetPosition( 0, 0 );
	self.tint:SetSize( 32, 32 );

	-- label (test)
	self.countdown = Turbine.UI.Label();
	self.countdown:SetForeColor(Turbine.UI.Color(1, 235/255, 228/255, 82/255));
    self.countdown:SetOutlineColor(Turbine.UI.Color(1, 0, 0, 0));
	self.countdown:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self.countdown:SetFont(Turbine.UI.Lotro.Font.Verdana14);
    self.countdown:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
	self.countdown:SetPosition( 0, 32 );
	self.countdown:SetSize( 36, 16 );
	self.countdown:SetParent(self);
	-- demo:
	self.countdown:SetText("58 m");

end

