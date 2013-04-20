
import "LynxPlugins.BuffIcons";
import "LynxPlugins.BuffIcons.BuffIconWindow";

-- buffIcons = BuffIconTest();
buffIconWindow = BuffIconWindow();

plugin.Load = function(self, sender, args)
    Turbine.Shell.WriteLine("BuffIcons v" .. Plugins["BuffIcons"]:GetVersion() .. " loaded");
end

plugin.Unload = function(self, sender, args)
	buffIconWindow:Destruct();
	Turbine.Shell.WriteLine("BuffIcons v" .. Plugins["BuffIcons"]:GetVersion() .. " unloaded");
end
