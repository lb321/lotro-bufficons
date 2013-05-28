
import "LynxPlugins.BuffIcons";

-- buffIcons = BuffIconTest();

configManager = ConfigurationManager();
optionsPanel = OptionPanel(configManager);
buffIconWindow = BuffIconWindow(configManager);

plugin.Load = function(self, sender, args)
	configManager:LoadSettings();
	optionsPanel:Initialize();
	buffIconWindow:Initialize();
	Turbine.Shell.WriteLine("BuffIcons v" .. Plugins["BuffIcons"]:GetVersion() .. " loaded");
end

plugin.Unload = function(self, sender, args)
	buffIconWindow:Destruct();
	Turbine.Shell.WriteLine("BuffIcons v" .. Plugins["BuffIcons"]:GetVersion() .. " unloaded");
end

-- hook options panel
plugin.GetOptionsPanel = function( self )
	return optionsPanel.mainPanel;
end

-- Turbine.Shell.AddCommand("bufficons", dumpCommand);
