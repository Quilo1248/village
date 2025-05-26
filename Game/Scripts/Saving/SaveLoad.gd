extends Node


const save_location = "user://VillageSave.tres"
var SaveFileData : SaveDataResource = SaveDataResource.new()


func  save():
	ResourceSaver.save(SaveFileData, save_location)


func load():
	if FileAccess.file_exists(save_location):
		SaveFileData = ResourceLoader.load(save_location).duplicate(true)
