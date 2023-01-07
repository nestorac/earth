extends Node

enum layer {NONE, WATER, LAND, ICE, GRASS, TEMP}

export var color_min = Color (0.0, 0.0, 1.0, 1.0)
export var color_max = Color (1.0, 0.0, 0.0, 1.0)

func log_color(color_a:Color, color_b:Color, t:float):

	# Calcula el logaritmo de cada componente del color inicial y final
	var log_r_a = log(color_a.r)
	var log_g_a = log(color_a.g)
	var log_b_a = log(color_a.b)
	var log_a_a = log(color_a.a)

	var log_r_b = log(color_b.r)
	var log_g_b = log(color_b.g)
	var log_b_b = log(color_b.b)
	var log_a_b = log(color_b.a)

	# Interpola los logaritmos de cada componente del color utilizando lerp()
	var log_r_result = lerp(log_r_a, log_r_b, t)
	var log_g_result = lerp(log_g_a, log_g_b, t)
	var log_b_result = lerp(log_b_a, log_b_b, t)
	var log_a_result = lerp(log_a_a, log_a_b, t)

	# Calcula el antilogaritmo de cada componente interpolado para obtener los valores finales
	var r = exp(log_r_result)
	var g = exp(log_g_result)
	var b = exp(log_b_result)
	var a = exp(log_a_result)

	# Crea un nuevo color con los componentes interpolados
	var result = Color(r, g, b, a)

	# Imprime el resultado final
	return(result)
