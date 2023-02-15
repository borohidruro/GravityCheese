#Copyright 2023 Carlos Esteban García Sánchez
#This file is part of Gravity Cheese.

#Gravity Cheese is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

#Gravity Cheese is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

#You should have received a copy of the GNU General Public License along with Gravity Cheese. If not, see <https://www.gnu.org/licenses/>. 

#Contact Info: carlosgarcia3dqro@gmail.com


extends KinematicBody2D

const PARALLEL_TO_FLOOR_DIRECTION = {Vector2.UP: Vector2.LEFT, Vector2.LEFT: Vector2.DOWN, Vector2.DOWN: Vector2.RIGHT, Vector2.RIGHT: Vector2.UP}

signal damage_received
signal player_died

export var speed := 150
export var hp: int setget _set_hp

var velocity_limit_for_damage: float


onready var _player_sprite := $Sprite
onready var _animation_player := $AnimationPlayer

var active_gravity_direction: Vector2 setget _set_active_gravity_direction
var gravity_magnitude: float
var _gravity_acceleration_vector: Vector2

var _total_velocity := Vector2(100, 0)
var _total_velocity_before_slide := Vector2.ZERO
var _parallel_to_floor_direction := Vector2.RIGHT
var _parallel_to_floor_velocity: Vector2

var _floor_normal := Vector2(0, -1)
var _was_falling: bool = true


func _ready() -> void:
	_parallel_to_floor_velocity = _parallel_to_floor_direction * speed


func _physics_process(delta) -> void:
	_update_total_velocity(delta)
	
	_total_velocity_before_slide = _total_velocity
	
	_total_velocity = move_and_slide(_total_velocity, _floor_normal)


	if is_on_floor():
		var _collision_info : KinematicCollision2D
		for _collision_number in get_slide_count()-1:
			_collision_info = get_slide_collision(_collision_number)
			if _collision_info.normal != _floor_normal:
				_bounce()
				
		if _was_falling:
			_calculate_damage(_total_velocity_before_slide)
			_was_falling = false
	
	else: 
		_was_falling = true
		


func _set_active_gravity_direction(value: Vector2):
	var _previous_gravity_direction := active_gravity_direction
	
	active_gravity_direction = value
	
	_floor_normal = active_gravity_direction * -1
	_gravity_acceleration_vector = active_gravity_direction * gravity_magnitude
	
	_update_parralel_to_floor_direction(active_gravity_direction)
	_update_parallel_to_floor_velocity(active_gravity_direction, _previous_gravity_direction)
	_update_sprite()
	
	_total_velocity = Vector2.ZERO

	
func _set_hp(value) -> void:
	hp = value
	if hp == 0:
		emit_signal("player_died")
	
	
func _calculate_damage(velocity_before_impact: Vector2):
	var _vertical_velocity_before_impact := velocity_before_impact.project(_gravity_acceleration_vector)
	if _vertical_velocity_before_impact.length() > velocity_limit_for_damage:
		emit_signal("damage_received")
		
		self.hp = hp - 1
		
		_animation_player.play("01-hurt_animation")
		
	
	
	
func _bounce():
	_parallel_to_floor_velocity *= -1
	_player_sprite.frame = wrapi(_player_sprite.frame + 1, 0, 2)
	
		

func _update_total_velocity(delta: float) -> void:

	if is_on_floor():
		_total_velocity = Vector2.ZERO
		_total_velocity = _parallel_to_floor_velocity + active_gravity_direction * delta
	else:
		_total_velocity += _gravity_acceleration_vector * delta

	
func _update_parralel_to_floor_direction(_active_gravity_direction: Vector2):
	_parallel_to_floor_direction =  PARALLEL_TO_FLOOR_DIRECTION[_active_gravity_direction]
	
	
func _update_parallel_to_floor_velocity (_active_gravity_direction: Vector2, _previous_gravity_direction: Vector2)-> void:
	var previous_and_active_gravity_are_parallel: bool = _active_gravity_direction.dot(_previous_gravity_direction)
	if previous_and_active_gravity_are_parallel:
		return
	else:
		_parallel_to_floor_velocity = _parallel_to_floor_direction * speed
	
func _update_sprite() -> void:
	var character_up_direction := -transform.y 
	var angle_rotation = character_up_direction.angle_to(_floor_normal)
	rotate(angle_rotation)
	
	if _floor_normal == Vector2.DOWN or _floor_normal == Vector2.LEFT:
		_player_sprite.flip_h = true
	else:
		_player_sprite.flip_h = false
	
	
	if _parallel_to_floor_velocity.normalized() == Vector2.RIGHT or _parallel_to_floor_velocity.normalized() == Vector2.DOWN:
		_player_sprite.frame = 0
	else:
		_player_sprite.frame = 1
