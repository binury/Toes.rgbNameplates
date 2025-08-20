#    Copyright 2024 Robin Ury

#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at

#        http://www.apache.org/licenses/LICENSE-2.0

#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

extends Node

onready var Players = get_node("/root/ToesSocks/Players")
#onready var Chat = get_node("/root/ToesSocks/Chat")


func _ready():
	Players.connect("ingame", self, "_on_ingame")


func _on_ingame() -> void:
	# Attempt to force a cosmetic update to "unstuck" our local player's name color from changing
	yield(get_tree().create_timer(3.5), "timeout")
	var new = PlayerData.cosmetics_equipped.duplicate()
	Network._send_actor_action(Players.local_player.owner_id, "_update_cosmetics", [new])
	Players.local_player._update_cosmetics(new)


# RGBNameplates
func _get_name_color(player_id: int) -> Color:
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
	return outline_color
