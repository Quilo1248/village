extends TextureProgressBar
#this node will be responsible for displaying the current time's value in donut format
#this node will not set it's own color and should therefore just display values from 0 - 60


#set value for minutes and seconds
func set_value_ms(minutes : int, seconds : int):
	value = 0
	value += minutes
	value += float(seconds) / 60.0
