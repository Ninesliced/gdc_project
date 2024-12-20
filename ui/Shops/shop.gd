extends Control

enum ShopType { 
	BUY,
	SELL,
	UPGRADE,
	QUIT,
}

var CurrentShopType : ShopType = ShopType.BUY


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
