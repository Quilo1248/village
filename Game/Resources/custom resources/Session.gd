extends Resource
class_name Session

@export var unix_start : int = 0 # dynamic
@export var unix_end : int = 0 # dynamic
@export var title := "Unamed Session"
@export var description := ""
@export var tags : Array
@export var tasks : Array
@export var mode : String # dynamic
@export var manual_stop : bool # dynamic
