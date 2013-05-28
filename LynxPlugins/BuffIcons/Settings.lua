
function CopySettings(to, from)
	for k,v in pairs(from) do
		to[k] = v;
	end
end

ConfigurationManager = class();

ConfigurationManager.defaultSettings =
{
	iconsPerLine = 10,
	positionX = 300,
	positionY = 10,
	spacing = 5,
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
	Turbine.PluginData.Save(Turbine.DataScope.Account, "BuffIcons_Settings", self.currentSettings)
	--
	CopySettings(self.savedSettings, self.currentSettings);
end

function ConfigurationManager:LoadSettings()
	-- TODO load
	local settings = Turbine.PluginData.Load(Turbine.DataScope.Account, "BuffIcons_Settings")
	if settings ~= nil then
		CopySettings(self.currentSettings, settings);
	end
	--
	CopySettings(self.savedSettings, self.currentSettings);
end

function ConfigurationManager:GetSetting(name)
	return self.currentSettings[name];
end

function ConfigurationManager:ChangeSetting(name, new_value)
	self.currentSettings[name] = new_value;
	LynxPlugins.Utils.ExecuteCallback(self, "SettingChanged", { Key = name, Value = new_value });
end
