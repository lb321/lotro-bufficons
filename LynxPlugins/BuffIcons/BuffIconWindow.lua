-- infinite duration => 3,4028234663853e+038 (max finite float value)

import "Turbine";
import "Turbine.Gameplay";
import "LynxPlugins.Utils";
import "LynxPlugins.BuffIcons.BuffIconDisplay";

BuffIconWindow = class( Turbine.UI.Window );

function BuffIconWindow:Constructor()
	Turbine.UI.Window.Constructor( self );

	self.spacing = 5;
	self.iconSize = 36;
	self.iconsPerLine = 10;
	self.gridWidth = self.iconSize + self.spacing;
	self.gridHeight = 52 + self.spacing;
	self.width = self.iconsPerLine * self.gridWidth;
	self.buffs = { };
	self.debuffs = { };

	-- hook event callbacks
	self.player = Turbine.Gameplay.LocalPlayer.GetInstance()
	local effects = self.player:GetEffects();

	self.EffectAddedCallback = function(sender, args)
		self:AddEffect( args.Index );
	end
	self.EffectRemovedCallback = function(sender, args)
		self:RemoveEffect( args.Effect );
	end

	LynxPlugins.Utils.AddCallback(effects, "EffectAdded", self.EffectAddedCallback);
	LynxPlugins.Utils.AddCallback(effects, "EffectRemoved", self.EffectRemovedCallback);

	-- load existing effects

	for i = 1, effects:GetCount() do
		self:AddEffect( i );
	end

	-- TODO: configurable placement
	-- self:SetPosition(1200, 10);
	-- Turbine.Shell.WriteLine("Screen width: " .. Turbine.UI.Display:GetWidth());
	self:SetPosition(Turbine.UI.Display:GetWidth() - 300 - self.width, 10);
	self:SetSize(self.width, 40);
	self:SetVisible( true );
	self:SetMouseVisible( false );
	--self:SetOpacity( 1);
	self:SetBackColor(0.5, 0, 0, 0);

	self.KeyDown = function(sender,args)
		-- hide UI event (F12 by default)
		if (args.Action == 268435635) then
			-- simple toggle as there is currently no other functionality to hide
			if (self:IsVisible()) then
				self:SetVisible(false);
			else
				self:SetVisible(true);
			end
		end
	end
	self:SetWantsKeyEvents(true);
end

function BuffIconWindow:Destruct()
	-- remove callbacks
	local effects = self.player:GetEffects();
	LynxPlugins.Utils.RemoveCallback(effects, "EffectAdded", self.EffectAddedCallback);
	LynxPlugins.Utils.RemoveCallback(effects, "EffectRemoved", self.EffectRemovedCallback);
end

function BuffIconWindow:AddEffect( effectIndex )
	local effect = self.player:GetEffects():Get( effectIndex );

	local effectDisplay = BuffIconDisplay();
	effectDisplay:SetEffect( effect );
	effectDisplay:SetParent( self );
	-- effectDisplay:SetSize( self.effectSize, self.effectSize );

	local insertionList = nil;
	local effectEndTime = effect:GetStartTime() + effect:GetDuration();

	if ( effectDisplay:GetEffect():IsDebuff() ) then
		insertionList = self.debuffs;
	else
		insertionList = self.buffs;
	end

	local insertAt = -1;

	for i = 1, #insertionList do
		local testEffect = insertionList[i]:GetEffect();
		local testEffectEndTime = testEffect:GetStartTime() + testEffect:GetDuration();

		if ( effectEndTime > testEffectEndTime ) then
			insertAt = i;
			break;
		end
	end

	if ( insertAt == -1 ) then
		table.insert(insertionList, effectDisplay);
	else
		table.insert(insertionList, insertAt, effectDisplay);
	end

	self:UpdateEffectsLayout();
	-- Turbine.Shell.WriteLine("Duration: " .. effect:GetDuration() .. " StartTime: " .. effect:GetStartTime());
end

function BuffIconWindow:RemoveEffect( effect )
	local list = self.buffs;
	if ( effect:IsDebuff() ) then list = self.debuffs end

	for i = 1, #list do
		local effectListItem = list[i]:GetEffect();

		if ( effect == effectListItem ) then
			local effectElement = list[i];
			effectElement:Destruct();
			table.remove(list, i);
			break;
		end
	end

	self:UpdateEffectsLayout();
end

function BuffIconWindow:DoGridLayout(items, y_offset)
	local numItems = #items
	-- self.numBuffRows = math.ceil(numItems / self.iconsPerLine);
	local row = 0;
	local col = 0;

	for i=1, numItems do
		local colCount = math.min(numItems - row * self.iconsPerLine, self.iconsPerLine);
		local x = self.width - self.gridWidth * (col + 1);
		local y = row * (self.gridHeight) + y_offset;
		items[i]:SetPosition(x,y);

		col = col + 1;
		if col >= self.iconsPerLine and i < numItems then
			col = 0;
			row = row + 1;
		end
	end
	return (row + 1) * self.gridHeight
end

function BuffIconWindow:UpdateEffectsLayout()
	local buffHeight = self:DoGridLayout(self.buffs, 0);
	local debuffHeight = self:DoGridLayout(self.debuffs, buffHeight + 16);
	local newHeight = buffHeight + 16 + debuffHeight;
	if (newHeight ~= self.height) then
		self:SetHeight(newHeight)
		self.hight = newHeight
	end
end
