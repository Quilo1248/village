extends TextureProgressBar
#this node will be responsible for displaying the current time's value in donut format
#this node will not set it's own color and should therefore just display values from 0 - 60


#set value for hours, minutes and seconds (requires a limit
func set_value_msh(minutes : int, seconds : int, hours : int, limit : int):
	value = 0
	value += minutes
	value += float(seconds) / 60.0
	
	if hours == limit -1:
		if minutes == 0:
			value = 60
