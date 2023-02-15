#Copyright 2023 Carlos Esteban García Sánchez
#This file is part of Gravity Cheese.

#Gravity Cheese is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

#Gravity Cheese is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

#You should have received a copy of the GNU General Public License along with Gravity Cheese. If not, see <https://www.gnu.org/licenses/>. 

#Contact Info: carlosgarcia3dqro@gmail.com


extends Node2D

signal player_won

func _ready():
	EventBus.connect("cheese_collected", self, "_on_cheese_collected")
	
func _on_cheese_collected() -> void:
	var _remaining_cheese_number:= _get_cheese_count()
	if _remaining_cheese_number == 0:
		emit_signal("player_won")
	

func _get_cheese_count() -> int:
	return get_child_count() - 1
