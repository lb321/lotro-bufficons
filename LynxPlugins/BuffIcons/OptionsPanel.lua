
--import "LynxPlugins.Utils.NumericInput";
OptionPanel = class();

function OptionPanel:Constructor(cfgManager)
	self.sm = cfgManager;
	self.mainPanel = Turbine.UI.Control()
	--self.mainPanel:SetBackColor( Turbine.UI.Color( 0.3, 0.3, 0.3 ) );
	self.mainPanel:SetSize( 400, 600 );
	self.mainPanel.MouseClick = function(sender, args)
		-- cause other (text-)inputs to lose focus and trigger value update
		self.mainPanel:Focus();
	end

	self.ValueChangedCallback = function (sender, args)
		self.sm:ChangeSetting(self.controlName[sender], args.Value);
		if not self.revertButton:IsEnabled() then
			self.revertButton:SetEnabled(true);
		end
	end

	self.positionXLabel = LynxPlugins.Utils.Label("Horizontal Position");
	self.positionXLabel:SetSize(180, 20);
	self.positionXLabel:SetPosition(10, 10);
	self.positionXLabel:SetParent(self.mainPanel);

	self.positionX = LynxPlugins.Utils.NumericInput();
	self.positionX:SetValue(self.sm:GetSetting("positionX"));
	self.positionX:SetPosition(200, 10);
	self.positionX:SetParent(self.mainPanel);
	self.positionX.ValueChanged = self.ValueChangedCallback;

	self.positionYLabel = LynxPlugins.Utils.Label("Vertical Position");
	self.positionYLabel:SetSize(180, 20);
	self.positionYLabel:SetPosition(10, 40);
	self.positionYLabel:SetParent(self.mainPanel);

	self.positionY = LynxPlugins.Utils.NumericInput();
	self.positionY:SetValue(self.sm:GetSetting("positionY"));
	self.positionY:SetPosition(200, 40);
	self.positionY:SetParent(self.mainPanel);
	self.positionY.ValueChanged = self.ValueChangedCallback;

	self.iconsPerLineLabel = LynxPlugins.Utils.Label("Icons per Line");
	self.iconsPerLineLabel:SetSize(180, 20);
	self.iconsPerLineLabel:SetPosition(10, 70);
	self.iconsPerLineLabel:SetParent(self.mainPanel);

	self.iconsPerLine = LynxPlugins.Utils.NumericInput();
	self.iconsPerLine:SetValue(self.sm:GetSetting("iconsPerLine"));
	self.iconsPerLine:SetLimits(2, 20);
	self.iconsPerLine:SetPosition(200, 70);
	self.iconsPerLine:SetParent(self.mainPanel);
	self.iconsPerLine.ValueChanged = self.ValueChangedCallback;

	self.sortCriteriaLabel = LynxPlugins.Utils.Label("Sort Criterion");
	self.sortCriteriaLabel:SetSize(180, 20);
	self.sortCriteriaLabel:SetPosition(10, 100);
	self.sortCriteriaLabel:SetParent(self.mainPanel);

	self.sortCriteria = LynxPlugins.Utils.ComboBox();
	self.sortCriteria:SetSize(160, 20);
	self.sortCriteria:SetPosition(200, 100);
	self.sortCriteria:AddItem("Duration", 1);
	self.sortCriteria:AddItem("Remaining Duration", 2);
	self.sortCriteria:SetParent(self.mainPanel);
	self.sortCriteria.SelectedIndexChanged = self.ValueChangedCallback;

	self.showFractionalLabel = LynxPlugins.Utils.Label("Show fractional Units");
	self.showFractionalLabel:SetSize(180, 20);
	self.showFractionalLabel:SetPosition(10, 130);
	self.showFractionalLabel:SetParent(self.mainPanel);

	self.showFractional = LynxPlugins.Utils.ComboBox();
	self.showFractional:SetSize(160, 20);
	self.showFractional:SetPosition(200, 130);
	self.showFractional:AddItem("Never", 1);
	self.showFractional:AddItem("Only 1.x", 2);
	self.showFractional:AddItem("1.x through 9.x", 3);
	self.showFractional:SetParent(self.mainPanel);
	self.showFractional.SelectedIndexChanged = self.ValueChangedCallback;

	self.opacitySlider = LynxPlugins.Utils.Slider();
	self.opacitySlider:SetParent(self.mainPanel);
	self.opacitySlider:SetText("Overlay Opacity");
	self.opacitySlider:SetPosition(10, 170);
	self.opacitySlider:SetSize(350, 40);
	self.opacitySlider:SetStep(1);
	self.opacitySlider:SetMin(0);
	self.opacitySlider:SetMax(100);
	self.opacitySlider.ValueChanged = self.ValueChangedCallback;

	-- create a control(-reference)=>config parameter table
	self.controlName = {
		[self.positionX] = "positionX",
		[self.positionY] = "positionY",
		[self.iconsPerLine] = "iconsPerLine",
		[self.sortCriteria] = "sortCriteria",
		[self.showFractional] = "showFractional",
		[self.opacitySlider] = "overlayOpacity"
	}

	self.revertButton = Turbine.UI.Lotro.Button();
	self.revertButton:SetText("Revert");
	self.revertButton:SetSize(110, 22);
	self.revertButton:SetPosition(10, 220);
	self.revertButton:SetEnabled(false);
	self.revertButton:SetParent(self.mainPanel);
	self.revertButton.Click = function(sender, args)
		if not self.revertButton:IsEnabled() then
			Turbine.Shell.WriteLine(" Button Clicked while disabled ");
			return;
		end
		self.sm:RestoreSettings();
		self:Initialize();
		self.revertButton:SetEnabled(false);
	end

	self.defaultButton = Turbine.UI.Lotro.Button();
	self.defaultButton:SetText("Default");
	self.defaultButton:SetSize(110, 22);
	self.defaultButton:SetPosition(125, 220);
	self.defaultButton:SetParent(self.mainPanel);
	self.defaultButton.Click = function(sender, args)
		-- TODO: confirmation dialogue
		self.sm:RestoreDefaultSettings();
		self:Initialize();
		self.revertButton:SetEnabled(true);
	end

	self.accepttButton = Turbine.UI.Lotro.Button();
	self.accepttButton:SetText("Accept");
	self.accepttButton:SetSize(110, 22);
	self.accepttButton:SetPosition(240, 220);
	self.accepttButton:SetParent(self.mainPanel);
	self.accepttButton.Click = function(sender, args)
		self.sm:SaveSettings();
		self.revertButton:SetEnabled(false);
	end

end

-- synchronize controls with configuration
function OptionPanel:Initialize()
	self.positionX:SetValue(self.sm:GetSetting("positionX"));
	self.positionY:SetValue(self.sm:GetSetting("positionY"));
	self.iconsPerLine:SetValue(self.sm:GetSetting("iconsPerLine"));
	self.sortCriteria:SetSelection(self.sm:GetSetting("sortCriteria"));
	self.showFractional:SetSelection(self.sm:GetSetting("showFractional"));
	self.opacitySlider:SetValue(self.sm:GetSetting("overlayOpacity"));
end
