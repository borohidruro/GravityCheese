#Copyright 2023 Carlos Esteban García Sánchez
#This file is part of Gravity Cheese.

#Gravity Cheese is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

#Gravity Cheese is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

#You should have received a copy of the GNU General Public License along with Gravity Cheese. If not, see <https://www.gnu.org/licenses/>. 

#Contact Info: carlosgarcia3dqro@gmail.com


extends Control


onready var _hearts_bar:= get_node("Panel/HBoxContainer/HeartsBar")


func set_hearts_bar(value) -> void:
	_hearts_bar.max_hp = value

func reduce_health() -> void:
	_hearts_bar.current_health = _hearts_bar.current_health - 1


