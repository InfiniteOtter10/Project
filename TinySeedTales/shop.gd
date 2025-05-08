extends Node2D
var ZahlNeuerShop = 0
var Slot1 = Global.Slot1
var Slot2 = Global.Slot2
var Slot3 = Global.Slot3

var przFarmland = 4
var przSatgut = 4
var przSpecial = 10

var przSmal = 5
var przMid = 4
var przBig = 9

var SatgutArten = ["Möhren", "Salat", "Stangenbohnen"]

var smal = [[[0,0,0,0,0],
			[0,0,1,0,0],
			[0,0,1,1,0],
			[0,0,0,0,0],
			[0,0,0,0,0]],	[[0,0,0,0,0],
							 [0,0,0,0,0],
							 [0,0,1,0,0],
							 [0,0,0,0,0],
							 [0,0,0,0,0]],	[[0,0,0,0,0],
											 [0,0,0,0,0],
											 [0,0,1,1,0],
											 [0,0,0,0,0],
											 [0,0,0,0,0]]]
var mid = [[[0,0,0,0,0],
			[0,0,0,0,0],
			[0,1,1,1,0],
			[0,0,0,1,0],
			[0,0,0,0,0]],	[[0,0,0,0,0],
							 [0,0,1,0,0],
							 [0,1,1,1,0],
							 [0,0,0,0,0],
							 [0,0,0,0,0]],	[[0,0,0,0,0],
											 [0,0,1,0,0],
											 [0,1,1,1,0],
											 [0,0,1,0,0],
											 [0,0,0,0,0]]]
var big = [[[0,0,0,0,0],
			[0,1,1,1,0],
			[0,1,1,0,0],
			[0,1,0,0,0],
			[0,0,0,0,0]],	[[0,0,0,0,0],
							 [0,1,1,1,0],
							 [0,1,0,1,0],
							 [0,1,1,1,0],
							 [0,0,0,0,0]],	[[0,0,0,0,0],
											 [0,0,0,0,0],
											 [0,1,1,1,0],
											 [0,1,1,1,0],
											 [0,0,0,0,0]]]

func ZufallSlot(Aray):
	var Zufall = randi() % (przFarmland - 1 + 1) + 1
	if Zufall == 1:
		Aray.Art = "Farmland"
	else :
		Zufall = randi() % (przSatgut - 1 + 1) + 1
		if Zufall == 1:
			Aray.Art = "Satgut"
		else :
			Zufall = randi() % (przSpecial - 1 + 1) + 1
			if Zufall == 1:
				Aray.Art = "Special"
			else:
				ZufallSlot(Aray)

func ZufalBoden(Aray):
	var Teil
	var Zufall = randi() % (przSmal - 1 + 1) + 1
	
	if Zufall == 1:
		Teil = "smal"
	else :
		Zufall = randi() % (przMid - 1 + 1) + 1
		if Zufall == 1:
			Teil = "mid"
		else :
			Zufall = randi() % (przBig - 1 + 1) + 1
			if Zufall == 1:
				Teil = "big"
			else:
				return ZufalBoden(Aray)
	return Teil

func teilAuswahl(Aray):
	
	var SlotCopy = Aray

	if Aray.Art == "Farmland" || Aray.Art == "Satgut":
		SlotCopy.Teil1 = ZufalBoden(Aray)
		SlotCopy.Teil2 = ZufalBoden(Aray)
		SlotCopy.Teil3 = ZufalBoden(Aray)
		if Aray.Art == "Satgut":
			var Zufall = randi() % (2)
			Aray.Art = SatgutArten[Zufall]

	return SlotCopy

func microTeilAuswahl(Aray):
	var SlotCopy = Aray
	var ZufalTeil = randi() % (3)

	if  typeof(Aray.Teil1) == TYPE_STRING :
		if Aray.Teil1 == "smal":
			SlotCopy.Teil1 = smal[ZufalTeil]
		else :
			if Aray.Teil1 == "mid":
				SlotCopy.Teil1 = mid[ZufalTeil]
			else:
				if Aray.Teil1 == "big":
					SlotCopy.Teil1 = big[ZufalTeil]

	ZufalTeil = randi() % (3)
	if  typeof(Aray.Teil2) == TYPE_STRING :
		if Aray.Teil2 == "smal":
			SlotCopy.Teil2 = smal[ZufalTeil]
		else :
			if Aray.Teil2 == "mid":
				SlotCopy.Teil2 = mid[ZufalTeil]
			else:
				if Aray.Teil2 == "big":
					SlotCopy.Teil2 = big[ZufalTeil]

	ZufalTeil = randi() % (3)
	if  typeof(Aray.Teil3) == TYPE_STRING :
		if Aray.Teil3 == "smal":
			SlotCopy.Teil3 = smal[ZufalTeil]
		else :
			if Aray.Teil3 == "mid":
				SlotCopy.Teil3 = mid[ZufalTeil]
			else:
				if Aray.Teil3 == "big":
					SlotCopy.Teil3 = big[ZufalTeil]

	return SlotCopy

func preis(Aray):
	var SlotCopy = Aray
	var PreisCopy = 0

	for i in range(5):
		for j in range(5):
			if Aray.Art == "Farmland":
				if Aray.Teil1[i][j] == 1:
					PreisCopy = PreisCopy + 100
				if Aray.Teil2[i][j] == 1:
					PreisCopy = PreisCopy + 100
				if Aray.Teil3[i][j] == 1:
					PreisCopy = PreisCopy + 100
			if Aray.Art != "Farmland" && Aray.Art != "Special":
				if Aray.Teil1[i][j] != 0:
					PreisCopy = PreisCopy + 200
				if Aray.Teil2[i][j] != 0:
					PreisCopy = PreisCopy + 200
				if Aray.Teil3[i][j] != 0:
					PreisCopy = PreisCopy + 200

	SlotCopy.preis = PreisCopy
	return SlotCopy

func _initShop() -> void:
	Slot1.preis = 0
	Slot2.preis = 0
	Slot3.preis = 0
	ZufallSlot(Slot1)
	ZufallSlot(Slot2)
	ZufallSlot(Slot3)

	Slot1 = teilAuswahl(Slot1)
	Slot2 = teilAuswahl(Slot2)
	Slot3 = teilAuswahl(Slot3)

	Slot1 = microTeilAuswahl(Slot1)
	Slot2 = microTeilAuswahl(Slot2)
	Slot3 = microTeilAuswahl(Slot3)

	Slot1 = preis(Slot1)
	Slot2 = preis(Slot2)
	Slot3 = preis(Slot3)
	
	update_Lable()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.Money = 300000
	_initShop()
	

	
	pass # Replace with function body.

func update_Lable():
	$Preise/erstes.text = var_to_str(Slot1.preis) + " $"
	$Preise/zweites.text = var_to_str(Slot2.preis) + " $"
	$Preise/drites.text = var_to_str(Slot3.preis) + " $"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(Slot1.Art)
	if ZahlNeuerShop < Global.shopSequence:
		_initShop()
		
		ZahlNeuerShop = Global.shopSequence
	Global.Slot1 = Slot1
	Global.Slot2 = Slot2
	Global.Slot3 = Slot3
	pass

func _on_erstes_pressed() -> void:
	print("Button 1 gedrückt – Art:", Slot1.Art, ", Preis:", Slot1.preis, ", Geld:", Global.Money)

	if Slot1.preis <= Global.Money:
		if Slot1.Art == "Farmland" or Slot1.Art == "Special":
			if $Preise/erstes.text != "gekauft":
				$Preise/erstes.text = "gekauft"
				Global.Money -= Slot1.preis
				Global.Teile.push_front(Slot1.Teil1)
				Global.Teile.push_front(Slot1.Teil2)
				Global.Teile.push_front(Slot1.Teil3)
				print("Slot1 erfolgreich gekauft.")
			else:
				print("Slot1 bereits gekauft.")
		else:
			print("Slot1 ist kein kaufbarer Typ:", Slot1.Art)
	else:
		print("Nicht genug Geld für Slot1")


func _on_zweites_pressed() -> void:
	print("Button 2 gedrückt – Art:", Slot2.Art, ", Preis:", Slot2.preis, ", Geld:", Global.Money)

	if Slot2.preis <= Global.Money:
		if Slot1.Art == "Farmland" or Slot1.Art == "Möhren":
			if $Preise/zweites.text != "gekauft":
				$Preise/zweites.text = "gekauft"
				Global.Money -= Slot2.preis
				Global.Teile.push_front(Slot2.Teil1)
				Global.Teile.push_front(Slot2.Teil2)
				Global.Teile.push_front(Slot2.Teil3)
				print("Slot2 erfolgreich gekauft.")
			else:
				print("Slot2 wurde bereits gekauft.")
		else:
			print("Slot2 ist kein kaufbarer Typ:", Slot2.Art)
	else:
		print("Nicht genug Geld für Slot2 – benötigt:", Slot2.preis)


func _on_drites_pressed() -> void:
	print("Button 3 gedrückt – Art:", Slot3.Art, ", Preis:", Slot3.preis, ", Geld:", Global.Money)

	if Slot3.preis <= Global.Money:
		if Slot1.Art == "Farmland" or Slot1.Art == "Special":
			if $Preise/drites.text != "gekauft":
				$Preise/drites.text = "gekauft"
				Global.Money -= Slot3.preis
				Global.Teile.push_front(Slot3.Teil1)
				Global.Teile.push_front(Slot3.Teil2)
				Global.Teile.push_front(Slot3.Teil3)
				print("Slot3 erfolgreich gekauft.")
			else:
				print("Slot3 wurde bereits gekauft.")
		else:
			print("Slot3 ist kein kaufbarer Typ:", Slot3.Art)
	else:
		print("Nicht genug Geld für Slot3 – benötigt:", Slot3.preis)
