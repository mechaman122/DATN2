extends Area2D

class_name InteractionManager

var curr_interaction: InteractionManager

func initiate_interaction() -> void:
	if curr_interaction != null:
		curr_interaction.receive_interaction()
	
		
func receive_interaction() -> void:
	print("No interaction reception behaviour defined.")
	

func pre_interaction() -> void:
	pass
	

func detach_interaction() ->void:
	pass
	

func _on_Interaction_Manager_area_entered(area) -> void:
	curr_interaction = area
	pre_interaction()


func _on_Interaction_Manager_area_exited(area) -> void:
	if curr_interaction == area:
		curr_interaction = null
		detach_interaction()
