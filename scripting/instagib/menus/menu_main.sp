// -------------------------------------------------------------------
void Menu_Main(int client)
{
	Menu menu = new Menu(MenuMain_Handler);
	
	menu.SetTitle("TF2Instagib v" ... INSTAGIB_VERSION);
	
	menu.AddItem("exit", "Exit");
	menu.AddItem("settings", "Settings");
	
	if (CheckCommandAccess(client, "forceround", ADMFLAG_CHEATS)) {
		menu.AddItem("forceround", "Force Special Round");
		menu.AddItem("reloadcfg", "Reload Config");
		menu.AddItem("mapconfig", "Edit Map Config");
	}
	
	menu.AddItem("credits", "Credits");
	menu.ExitButton = false;
	menu.Display(client, 60);
}

void Credits(int client)
{
	Panel panel = new Panel();
	
	panel.DrawText("TF2Instagib v" ... INSTAGIB_VERSION);
	panel.DrawText("Made by Haxton Sale (76561197999759379)");
	
	panel.DrawText(" ");
	
	panel.DrawText("Source code is available at");
	panel.DrawText("https://github.com/haxtonsale/TF2Instagib");
	
	panel.DrawItem("Back");
	
	panel.Send(client, Credits_Handler, 60);
	
	delete panel;
}

// -------------------------------------------------------------------
public int MenuMain_Handler(Menu menu, MenuAction action, int client, int option)
{
	if (action == MenuAction_Select) {
		char info[32];
		menu.GetItem(option, info, sizeof(info));
		
		if (StrEqual(info, "settings")) {
			Menu_Settings(client);
		} else if (StrEqual(info, "forceround")) {
			ClientCommand(client, "forceround");
		} else if (StrEqual(info, "credits")) {
			Credits(client);
		} else if (StrEqual(info, "reloadcfg")) {
			ClientCommand(client, "instagibcfg");
		} else if (StrEqual(info, "mapconfig")) {
			ClientCommand(client, "instagibedit");
		}
	} else if (action == MenuAction_End) {
		delete menu;
	}

	return 0;
}

public int Credits_Handler(Menu menu, MenuAction action, int client, int option)
{
	if (action == MenuAction_Select) {
		Menu_Main(client);
	}

	return 0;
}