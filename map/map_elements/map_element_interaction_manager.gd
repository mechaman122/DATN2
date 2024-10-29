extends InteractionManager


func receive_interaction() -> void:
	get_parent().interact()


func detach_interaction() -> void:
	get_parent().detach()


func pre_interaction() -> void:
	get_parent().pre_interact()
