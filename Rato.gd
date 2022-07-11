extends Node2D

onready var hpLabel = $HP
onready var anim = $AnimationPlayer
onready var tempo = $Timer

export(int) var MAX_HP = 120

var HP = MAX_HP

signal respondeu
signal ganhou

func responder():
	Batalha.espada.disabled = true
	Batalha.curar.disabled = true
	Batalha.bloqueio.disabled = true
	anim.play("AtaqueInim")
	emit_signal("respondeu")


func _on_Batalha_atacou():
	HP -= Batalha.danoEsp
	hpLabel.text = str(HP) + "HP"
	if HP > 0:
		anim.play("Ataque")
		tempo.start(0.8)
	else:
		anim.play("Ganhou")
		Batalha.espada.disabled = true
		Batalha.curar.disabled = true
		Batalha.bloqueio.disabled = true
		emit_signal("ganhou")


func _on_Batalha_bloqueou():
	tempo.start(0.8)


func _on_Timer_timeout():
	tempo.stop()
	responder()


func _on_Batalha_curou():
	tempo.start(0.8)


func _on_Batalha_morreu():
	anim.play("Perdeu")
