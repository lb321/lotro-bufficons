
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

	self.positionXLabel = Turbine.UI.Label();
	self.positionXLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
	self.positionXLabel:SetSize(180, 20);
	self.positionXLabel:SetPosition(10, 10);
	self.positionXLabel:SetText("Horizontal Position");
	self.positionXLabel:SetParent(self.mainPanel);

	self.positionX = LynxPlugins.Utils.NumericInput();
	self.positionX:SetValue(self.sm:GetSetting("positionX"));
	self.positionX:SetPosition(200, 10);
	self.positionX:SetParent(self.mainPanel);
	self.positionX.ValueChanged = self.ValueChangedCallback;

	self.positionYLabel = Turbine.UI.Label();
	self.positionYLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
	self.positionYLabel:SetSize(180, 20);
	self.positionYLabel:SetPosition(10, 40);
	self.positionYLabel:SetText("Vertical Position");
	self.positionYLabel:SetParent(self.mainPanel);

	self.positionY = LynxPlugins.Utils.NumericInput();
	self.positionY:SetValue(self.sm:GetSetting("positionY"));
	self.positionY:SetPosition(200, 40);
	self.positionY:SetParent(self.mainPanel);
	self.positionY.ValueChanged = self.ValueChangedCallback;

	-- create a control(-reference)=>config parameter table
	self.controlName = {
		[self.positionX] = "positionX",
		[self.positionY] = "positionY"
	}

	self.revertButton = Turbine.UI.Lotro.Button();
	self.revertButton:SetText("Revert");
	self.revertButton:SetSize(80, 22);
	self.revertButton:SetPosition(10, 100);
	self.revertButton:SetEnabled(false);
	self.revertButton:SetParent(self.mainPanel);
	self.revertButton.Click = function(sender, args)
		if not self.revertButton:IsEnabled() then
			Turbine.Shell.WriteLine(" Button Clicked while disabled ");
			return;
		end
		self.sm:RestoreSettings();
		self.revertButton:SetEnabled(false);
		-- TODO: might iterate over the controlName table later
		self.positionX:SetValue(self.sm:GetSetting("positionX"));
		self.positionY:SetValue(self.sm:GetSetting("positionY"));
	end

	self.defaultButton = Turbine.UI.Lotro.Button();
	self.defaultButton:SetText("Default");
	self.defaultButton:SetSize(80, 22);
	self.defaultButton:SetPosition(95, 100);
	self.defaultButton:SetParent(self.mainPanel);
	self.defaultButton.Click = function(sender, args)
		self.sm:RestoreDefaultSettings();
		self:Initialize();
		self.revertButton:SetEnabled(true);
	end

	self.accepttButton = Turbine.UI.Lotro.Button();
	self.accepttButton:SetText("Accept");
	self.accepttButton:SetSize(80, 22);
	self.accepttButton:SetPosition(180, 100);
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
end
