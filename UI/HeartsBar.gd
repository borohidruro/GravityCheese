#Copyright 2023 Carlos Esteban García Sánchez
#This file is part of Gravity Cheese.

#Gravity Cheese is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

#Gravity Cheese is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

#You should have received a copy of the GNU General Public License along with Gravity Cheese. If not, see <https://www.gnu.org/licenses/>. 

#Contact Info: carlosgarcia3dqro@gmail.com


extends HBoxContainer

const UIHeart: PackedScene = preload("res://UI/UIHeart.tscn")

signal health_depleted

var max_hp :int setget _set_max_hp

var current_health := 0 setget set_current_health

func _set_max_hp(value) -> void:
	max_hp = value
	_setup()


func _setup() -> void:
	var _max_hp = max_hp
	current_health = _max_hp
	
	for i in _max_hp:
		var _ui_heart: TextureRect = UIHeart.instance()
		add_child(_ui_heart)


func set_current_health(amount: int) -> void:
	var old_value := current_health
	current_health = int(clamp(amount, 0, max_hp))
	
	for i in range(old_value, current_health, -1):
	 get_child(i - 1).queue_free()
	
	if get_child_count() == 0:
		emit_signal("health_depleted")
	
