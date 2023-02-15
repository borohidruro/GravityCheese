#Copyright 2023 Carlos Esteban García Sánchez
#This file is part of Gravity Cheese.

#Gravity Cheese is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

#Gravity Cheese is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

#You should have received a copy of the GNU General Public License along with Gravity Cheese. If not, see <https://www.gnu.org/licenses/>. 

#Contact Info: carlosgarcia3dqro@gmail.com


extends Control

signal play_again_selected
signal return_to_title_selected

var _legend:= ""

onready var _gameresult_label:= $MarginContainer/VBoxContainer/MarginContainer2/EndResultLabel

func _ready() -> void:
	_gameresult_label.text = _legend

func update_game_result(var legend: String) -> void:
	_legend = legend

func _on_PlayAgain_pressed():
	emit_signal("play_again_selected")


func _on_TitleScreen_pressed():
	emit_signal("return_to_title_selected")
