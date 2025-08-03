using GDWeave;
using util.LexicalTransformer;

namespace RGBNameplates;

/*
 The main entrypoint of your mod project
 This code here is invoked by GDWeave when loading your mod's DLL assembly, at runtime
*/

public class Mod : IMod
{
	public Mod(IModInterface mi)
	{
		// Load your mod's configuration file
		var config = new Config(mi.ReadConfig<ConfigFileSchema>());

		mi.RegisterScriptMod(
			new TransformationRuleScriptModBuilder()
				.ForMod(mi)
				.Named("[RGB Nameplates]")
				.Patching("res://Scenes/Entities/Player/player_label.gdc")
				.AddRule(
					new TransformationRuleBuilder()
						.Named("Insert colors")
						.Do(Operation.Append)
						.Matching(
							TransformationPatternFactory.CreateGdSnippetPattern(
								"""
								_name = _name.replace("]", "")
								"""
							)
						)
						.With(
							"""
							
							if player_id == -1: return

							var name_label = get_node("VBoxContainer/Label")
							var title_label = get_node("VBoxContainer/Label2")
							var name_font = name_label["custom_fonts/normal_font"]
							var title_font = title_label["custom_fonts/font"]
							var RGBNameplates = get_node("/root/ToesRGBNameplates")

							var name_color = RGBNameplates._get_name_color(player_id)
							name_label["custom_colors/font_color"] = name_color.to_html()
							name_label["custom_colors/default_color"] = name_color.to_html()

							var outline_color = RGBNameplates._get_outline_color(name_color)
							if outline_color: name_font["outline_color"] = outline_color.to_html(true)
							name_font["outline_size"] = 1 if outline_color else 0

							title_label["custom_colors/font_color"] = name_color.to_html()

							var title_color = Color(name_color.to_html(true))
							title_color.a = 150
							if outline_color: title_font["outline_color"] = outline_color.to_html(true)
							title_font["outline_size"] = 1 if outline_color else 0

							""",
							1
						)
				)
				.Build()
		);


		// }
	}

	public void Dispose()
	{
		// Post-injection cleanup (optional)
	}
}
