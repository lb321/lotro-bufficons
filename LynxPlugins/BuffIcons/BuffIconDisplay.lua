
import "Turbine";
import "Turbine.Gameplay";
-- import "Turbine.UI.Extensions";

-- local baseImageID = 0x41007E35;

BuffIconDisplay = class( Turbine.UI.Window );

function BuffIconDisplay:Constructor()
	Turbine.UI.Window.Constructor(self);

	-- general members
	self.currentClock = 0;

	self:SetSize(36,52);
	-- self:SetPosition(50,350);

	self:SetVisible( true );
	-- self:SetOpacity( 1 );

	-- icon (test)
	self.icon = Turbine.UI.Lotro.EffectDisplay()
	-- self.icon:SetEffect(effect);
	self.icon:SetParent( self );
	self.icon:SetPosition(0,0);
	-- self.icon:SetMouseVisible( false );
	self.icon:SetZOrder( 25 );


	-- overlayWindow (test)
	self.overlayWindow = Turbine.UI.Window();
	self.overlayWindow:SetParent( self );
	self.overlayWindow:SetMouseVisible( false );
	self.overlayWindow:SetZOrder( 120 );
	self.overlayWindow:SetPosition( 2, 2 );
	self.overlayWindow:SetSize( 32, 32 );
	self.overlayWindow:SetOpacity( 0.6 );
	self.overlayWindow:SetBlendMode( 4 ); -- 4 adds opaque part (yay!)
	self.overlayWindow:SetVisible( true );

	-- holder (test)
	self.holder = Turbine.UI.Control();
	self.holder:SetParent( self.overlayWindow );
	self.holder:SetMouseVisible( false );
	self.holder:SetZOrder( 50 );
	self.holder:SetPosition( 16, 0 );
	self.holder:SetSize( 16, 16 );
	self.holder:SetVisible( true );

	-- overlay
	self.elapsedOverlay = Turbine.UI.Control();
	self.elapsedOverlay:SetParent( self.holder );
	self.elapsedOverlay:SetPosition( -16, 0 );
	self.elapsedOverlay:SetSize( 32, 32 );
	self.elapsedOverlay:SetMouseVisible( false );
	self.elapsedOverlay:SetZOrder( 100 );
	self.elapsedOverlay:SetBlendMode( 0 );

	-- tint (test)
	self.tint = Turbine.UI.Control();
	self.tint:SetMouseVisible( false );
	self.tint:SetZOrder( 150 );
	self.tint:SetBackColor( Turbine.UI.Color( 1, 0, 0, 0.2 ) );
	self.tint:SetBackColorBlendMode( 5 );
	-- self.tint:SetParent( self.elapsedOverlay );
	self.tint:SetParent( self.overlayWindow );
	-- self.tint:SetBlendMode( 3 );
	self.tint:SetPosition( 0, 0 );
	self.tint:SetSize( 32, 32 );

	--[[
	-- holder (test)
	self.holder = Turbine.UI.Window();
	self.holder:SetParent( self );
	-- self.holder:SetStretchMode( 3 );
	self.holder:SetMouseVisible( false );
	self.holder:SetZOrder( 50 );
	self.holder:SetOpacity( 0.7 );
	-- self.holder:SetBackColor( Turbine.UI.Color( 0.7, 0.5, 0.5, 0.9 ) );
	-- self.holder:SetBackColorBlendMode( 3 );
	-- self.holder:SetParent( self );
	-- self.holder:SetBlendMode( 3 );
	self.holder:SetPosition( 2, 2 );
	self.holder:SetSize( 32, 32 ); -- 32,32
	self.holder:SetVisible( true );

	-- overlay
	self.elapsedOverlay = Turbine.UI.Control();
	self.elapsedOverlay:SetParent( self.holder );
	self.elapsedOverlay:SetPosition( 0, 0 );
	self.elapsedOverlay:SetSize( 32, 32 );
	-- self.elapsedOverlay:SetStretchMode( 3 );
	-- self.elapsedOverlay:SetMouseVisible( false );
	self.elapsedOverlay:SetZOrder( 100 );
	-- self.elapsedOverlay:SetOpacity( 0.7 );
--	self.elapsedOverlay:SetBackground( "LynxPlugins/BuffIcons/Resources/9s.tga" );
	-- self.elapsedOverlay:SetBackground( "TurbinePlugins/Examples/Resources/StatusIcon2.tga" );
	-- self.elapsedOverlay:SetBackColor( Turbine.UI.Color( 1.0, 0, 0, 0.8 ) );
	-- self.elapsedOverlay:SetBackColorBlendMode( 3 );
	self.elapsedOverlay:SetBlendMode( 0 );


	-- crop (test)
	self.crop = Turbine.UI.Control();
	self.crop:SetParent( self.elapsedOverlay );
	-- self.crop:SetStretchMode( 3 );
	-- self.crop:SetMouseVisible( false );
	self.crop:SetZOrder( 120 );
	self.crop:SetPosition( 0, 0 );
	self.crop:SetSize( 32, 32 );
	-- self.crop:SetOpacity( 1 );
--	self.crop:SetBackground( "LynxPlugins/BuffIcons/Resources/30s.tga" );
	-- self.crop:SetBackColor( Turbine.UI.Color( 0.0, 0.5, 0.5, 0.9 ) );
	-- self.crop:SetBackColorBlendMode( 6 );
	self.crop:SetBlendMode( 4 ); -- 4 adds opaque part (yay!)
	-- self.crop:SetVisible( false );

	-- tint (test)
	self.tint = Turbine.UI.Control();
	-- self.tint:SetStretchMode( 3 );
	-- self.tint:SetMouseVisible( false );
	self.tint:SetZOrder( 150 );
	-- self.tint:SetOpacity( 0.7 );
	self.tint:SetBackColor( Turbine.UI.Color( 1, 0, 0, 0.2 ) );
	self.tint:SetBackColorBlendMode( 5 );
	-- self.tint:SetParent( self.elapsedOverlay );
	self.tint:SetParent( self.elapsedOverlay );
	-- self.tint:SetBlendMode( 3 );
	self.tint:SetPosition( 0, 0 );
	self.tint:SetSize( 32, 32 );]]--

	-- label (test)
	self.countdown = Turbine.UI.Label();
	self.countdown:SetForeColor(Turbine.UI.Color(1, 235/255, 228/255, 82/255));
    self.countdown:SetOutlineColor(Turbine.UI.Color(1, 0, 0, 0));
	self.countdown:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self.countdown:SetFont(Turbine.UI.Lotro.Font.Verdana14);
    self.countdown:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
	self.countdown:SetPosition( 0, 36 );
	self.countdown:SetSize( 36, 16 );
	self.countdown:SetParent(self);
	-- demo:
	--self.countdown:SetText("58 m");

	--if effect:GetDuration() < 8640000 then -- 100 days in seconds
	--	self.SetWantsUpdates(true);
	--end

end

function BuffIconDisplay:Destruct(effect)
	self:SetVisible(false);
	self:SetWantsUpdates(false);
	self.tint:SetParent(nil);
	self.overlayWindow:SetParent(nil);
	self.elapsedOverlay:SetParent(nil);
	self.holder:SetParent(nil);
	self.icon:SetParent(nil);
	self:SetParent(nil);
end

function BuffIconDisplay:SetEffect(effect)
	self.icon:SetEffect(effect);

	if effect:GetDuration() < 8640000 then -- 100 days in seconds
		self:SetWantsUpdates(true);
	end
end

function BuffIconDisplay:GetEffect(effect)
	return self.icon:GetEffect();
end

TimeFormat_compact = function(value)
	if (value < 60) then
		return string.format("%d s", value)
	elseif (value < 3600) then
		return string.format("%d m", value/60)
	elseif (value < 86400) then
		return string.format("%d h", value/3600)
	else
		return string.format("%d d", value/86400)
	end
end

function BuffIconDisplay:Update(args)
	local effect = self.icon:GetEffect();
	local gameTime = Turbine.Engine.GetGameTime();
    local elapsedTime = gameTime - effect:GetStartTime();
    local percentComplete = elapsedTime / effect:GetDuration();
	local remaining = effect:GetDuration() - elapsedTime;

	-- TODO: only recreate timeString when it actually changed
	local timeString = TimeFormat_compact(remaining)
	self.countdown:SetText(timeString)

	-- update clock overlay
	local newClock = math.floor(60 * percentComplete);
	-- prevent ticking back to 45s if we slightly pass duration
	newClock = math.min(newClock, 59);
	if newClock ~= self.currentClock then
		if newClock >= 15 and self.currentClock < 15 then
			-- add 15s block
			self.overlayWindow:SetBackground( "LynxPlugins/BuffIcons/Resources/15s.tga" );
			-- put holder in next quarter
			self.holder:SetPosition( 16, 16 );
			self.elapsedOverlay:SetPosition( -16, -16 );
		elseif newClock >= 30 and self.currentClock < 30 then
			-- change 15s block with 30s block
			self.overlayWindow:SetBackground( "LynxPlugins/BuffIcons/Resources/30s.tga" );
			-- put ??? in next quarter
			self.holder:SetPosition( 0, 16 );
			self.elapsedOverlay:SetPosition( 0, -16 );
		elseif newClock >= 45 and self.currentClock < 45 then
			-- change 30s block with 45s block
			self.overlayWindow:SetBackground( "LynxPlugins/BuffIcons/Resources/45s.tga" );
			self.holder:SetPosition( 0, 0 );
			self.elapsedOverlay:SetPosition( 0, 0 );
			-- put ??? in next quarter
		end
	end

	local frame = newClock % 15;
	if frame ~= 0 then
		self.elapsedOverlay:SetBackground( "LynxPlugins/BuffIcons/Resources/" .. frame .. "s.tga" );
		self.elapsedOverlay:SetVisible(true);
	else
		self.elapsedOverlay:SetVisible(false);
	end
	self.currentClock = newClock;
end
