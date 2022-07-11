extends Node

var danoEsp = 10
export(int) var DANO = 10
var max_mana = 50
var mana = max_mana
var cura_mana = 10
var cura = 30
export(int) var max_jogHP = 70
var jogHP = max_jogHP
var bloqueou = false

export(String, FILE, "*.tscn") var prox

onready var espada = $UI/Espada
onready var curar = $UI/Curar
onready var bloqueio = $UI/Bloquear
onready var status = $UI/status/Label
onready var anim = $"Descrição"
onready var timer = $acabou
onready var som = $som

signal atacou
signal bloqueou
signal morreu
signal curou

func _ready():
	anim.play("desc")


func responder():
	if bloqueou:
		jogHP -= DANO / 2
	else:
		jogHP -= DANO
	status.text = str(jogHP) + "HP\n" + str(mana) + "MP"
	bloqueou = false
	espada.disabled = false
	curar.disabled = false
	bloqueio.disabled = false
	if jogHP <= 0:
		prox = "res://Menu.tscn"
		emit_signal("morreu")
		espada.disabled = true
		curar.disabled = true
		bloqueio.disabled = true
		timer.start(3)


func _on_Espada_button_up():
	som.play()
	espada.disabled = true
	curar.disabled = true
	bloqueio.disabled = true
	emit_signal("atacou")


func _on_Curar_button_up():
	som.play()
	espada.disabled = true
	curar.disabled = true
	bloqueio.disabled = true
	if mana >= 15:
		if jogHP + cura <= max_jogHP:
			jogHP += cura
		else:
			jogHP = max_jogHP
		mana -= 15
	status.text = str(jogHP) + "HP\n" + str(mana) + "MP"
	emit_signal("curou")


func _on_Bloquear_button_up():
	som.play()
	espada.disabled = true
	curar.disabled = true
	bloqueio.disabled = true
	bloqueou = true
	if mana + cura_mana <= max_mana:
		mana += cura_mana
	else:
		mana = max_mana
	status.text = str(jogHP) + "HP\n" + str(mana) + "MP"
	emit_signal("bloqueou")


func _on_Rato_respondeu():
	responder()


func _on_Rato_ganhou():
	timer.start(3)


func _on_acabou_timeout():
	get_tree().change_scene(prox)

