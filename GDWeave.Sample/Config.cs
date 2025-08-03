using System.Text.Json.Serialization;

namespace RGBNameplates;

public class Config(ConfigFileSchema configFile)
{
	[JsonInclude]
	public bool infiniteChatRange = configFile.infiniteChatRange;
}
