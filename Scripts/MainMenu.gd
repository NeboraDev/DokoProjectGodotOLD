extends Node2D

onready var settings_menu = $SettingsButtons
onready var main_menu = $MenuButtons
onready var select_audio = $SelectAudio  # Plays the select audio sound effect

func _ready():
	settings_menu.visible = false
	$MenuButtons/NewGameButton.grab_focus()  # Allows keypress
	fullscreen()

func _on_NewGameButton_pressed():
	select_audio.play()
	get_tree().change_scene("res://Scenes/TestWorld.tscn")

func _on_ContinueButton_pressed():
	select_audio.play()

func _on_SettingsButton_pressed():
	select_audio.play()
	settings_menu.visible = true
	main_menu.visible = false
	$SettingsButtons/VolumeButton.grab_focus()

func _on_QuitButton_pressed():
	select_audio.play()
	get_tree().quit()
	
func _on_VolumeButton_pressed():
	select_audio.play()

func _on_KeybindsButton_pressed():
	select_audio.play()

func _on_DisplayButton_pressed():
	select_audio.play()

func _on_DataButton_pressed():
	select_audio.play()

func _on_BackButton_pressed():
	select_audio.play()
	settings_menu.visible = false
	main_menu.visible = true
	$MenuButtons/NewGameButton.grab_focus()

func fullscreen():
	if Input.is_action_just_pressed("ui_fullscreen"):
		print("Hello World!")
		OS.window_fullscreen = !OS.window_fullscreen
