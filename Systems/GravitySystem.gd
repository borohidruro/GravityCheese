#Copyright 2023 Carlos Esteban García Sánchez
#This file is part of Gravity Cheese.

#Gravity Cheese is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

#Gravity Cheese is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

#You should have received a copy of the GNU General Public License along with Gravity Cheese. If not, see <https://www.gnu.org/licenses/>. 

#Contact Info: carlosgarcia3dqro@gmail.com


extends Node

const GRAVITY_DIRECTION_VECTORS:= [Vector2.UP, Vector2.LEFT, Vector2.DOWN, Vector2.RIGHT]

signal gravity_direction_changed

var _active_gravity_direction := Vector2(0, 1)

func _physics_process(_delta):
	_get_input()


func _get_input() -> void:
	var gravity_direction_input:= Vector2.ZERO
	
	if Input.is_action_pressed("gravity_right"):
		gravity_direction_input = Vector2.RIGHT
	if Input.is_action_pressed("gravity_left"):
		gravity_direction_input = Vector2.LEFT
	if Input.is_action_pressed("gravity_down"):
		gravity_direction_input = Vector2.DOWN
	if Input.is_action_pressed("gravity_up"):
		gravity_direction_input = Vector2.UP
	
	if gravity_direction_input != Vector2.ZERO and gravity_direction_input!= _active_gravity_direction:
		_active_gravity_direction = gravity_direction_input
		emit_signal("gravity_direction_changed", _active_gravity_direction)
