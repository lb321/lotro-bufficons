
function CopySettings(to, from)
	for k,v in pairs(from) do
		to[k] = v;
	end
end

ConfigurationManager = class();

ConfigurationManager.defaultSettings =
{
	version = 0.03,
	iconsPerLine = 10,
	positionX = 300,
	positionY = 10,
	maxDuration = 90,
	spacing = 5,
	sortCriteria = 2,
	showFractional = 2,
	overlayOpacity = 60,
	lockPosition = false
}

function ConfigurationManager:Constructor()
	self.currentSettings = {};
	self.savedSettings = {};
	CopySettings(self.currentSettings, ConfigurationManager.defaultSettings);
	CopySettings(self.savedSettings, self.currentSettings);
end

function ConfigurationManager:RestoreSettings()
	CopySettings(self.currentSettings, self.savedSettings);
	-- TODO: decide what "args" shall be when multiple settings changed...
	LynxPlugins.Utils.ExecuteCallback(self, "SettingChanged", { });
end

function ConfigurationManager:RestoreDefaultSettings()
	CopySettings(self.currentSettings, ConfigurationManager.defaultSettings);
	-- TODO: decide what "args" shall be when multiple settings changed...
	LynxPlugins.Utils.ExecuteCallback(self, "SettingChanged", { });
end

function ConfigurationManager:SaveSettings()
	-- TODO save
	local enc_settings = LynxPlugins.Utils.convSave(self.currentSettings);
	Turbine.PluginData.Save(Turbine.DataScope.Account, "BuffIcons_Settings", enc_settings)
	--
	CopySettings(self.savedSettings, self.currentSettings);
end

function ConfigurationManager:LoadSettings()
	-- TODO load
	local raw_settings = Turbine.PluginData.Load(Turbine.DataScope.Account, "BuffIcons_Settings")
	if raw_settings ~= nil then
		if raw_settings["s:version"] ~= nil then
			local settings = LynxPlugins.Utils.convLoad(raw_settings);
			CopySettings(self.currentSettings, settings);
		else
			-- first piece of legacy code...
			for k,v in pairs(raw_settings) do
				if type(k) == "number" then raw_settings[k] = nil; end
			end
			CopySettings(self.currentSettings, raw_settings);
		end
		CopySettings(self.savedSettings, self.currentSettings);
	end
end

function ConfigurationManager:GetSetting(name)
	return self.currentSettings[name];
end

function ConfigurationManager:ChangeSetting(name, new_value)
	self.currentSettings[name] = new_value;
	LynxPlugins.Utils.ExecuteCallback(self, "SettingChanged", { Key = name, Value = new_value });
end
