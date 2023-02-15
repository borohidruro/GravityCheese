#Copyright 2023 Carlos Esteban García Sánchez
#This file is part of Gravity Cheese.

#Gravity Cheese is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

#Gravity Cheese is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

#You should have received a copy of the GNU General Public License along with Gravity Cheese. If not, see <https://www.gnu.org/licenses/>. 

#Contact Info: carlosgarcia3dqro@gmail.com


extends Node2D

export var gravity_magnitude = 800
export var maximum_player_hp := 5
export var max_velocity_before_damage := 500

onready var _player := $Player
onready var _hud := $CanvasLayer/HUD
onready var _gravity_system = $GravitySystem
onready var _canvas_layer := $CanvasLayer

func _ready() -> void:
	_game_setup()
	
	
func _game_setup() -> void:
	_player.gravity_magnitude = gravity_magnitude
	_player.active_gravity_direction = Vector2.DOWN
	_player.velocity_limit_for_damage = max_velocity_before_damage
	_player.hp = maximum_player_hp
	
	_hud.set_hearts_bar(maximum_player_hp)

func _on_GravitySystem_gravity_direction_changed(new_gravity_direction: Vector2):
	_player.active_gravity_direction = new_gravity_direction


func _on_Player_damage_received():
	_hud.reduce_health()



func _on_CheeseManager_player_won():
	_show_endgame_screen("Well done, thanks for playing!")


func _on_Player_player_died():
	_show_endgame_screen("Oh, you lost...")

	
func _show_endgame_screen(var legend: String) -> void:
	var _game_result := legend
	
	_player.set_physics_process(false)
	_gravity_system.set_physics_process(false)
	_player.queue_free()
	_hud.queue_free()
	
	
	
	var _endgame_scene : PackedScene = load("res://UI/EndGame.tscn")
	var _endgame := _endgame_scene.instance()
	
	_endgame.update_game_result(_game_result)
	
	_endgame.connect("play_again_selected", self, "_on_Endgame_play_again_selected")
	_endgame.connect("return_to_title_selected", self, "_on_Endgame_return_to_title_selected")
	
	
	
	_canvas_layer.add_child(_endgame)


func _on_Endgame_play_again_selected() -> void:
	get_tree().reload_current_scene()

func _on_Endgame_return_to_title_selected() -> void:
	get_tree().change_scene("res://MainTitle.tscn")
