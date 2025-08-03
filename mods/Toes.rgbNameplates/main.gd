extends Node


# RGBNameplates
func _get_name_color(player_id: int) -> Color:
	var Players = get_node("/root/ToesSocks/Players")
	var name_color = Players.get_chat_color(str(player_id))
	if name_color != null:
		# No transparent names
		name_color.a = 1.0
		return name_color
	else:
		return Color.lavenderblush


func _get_outline_color(name_color: Color):
		name_color = Color(name_color.to_html())
		var luminosity = name_color.get_luminance()
		var outline_hex = "#"
		var outline_color: Color
		# DARK
		if luminosity <= 0.4:
			return null
			# outline_color = Color8(192, 176, 190, 255)
		# MID
		elif luminosity <= 0.7:
			name_color.v -= 0.35
			outline_color = Color(name_color.to_html())
		# BRIGHT
		else:
			name_color.v -= 0.70
			outline_color = Color(name_color.to_html())
		# breakpoint
		return outline_color
