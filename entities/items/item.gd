@tool
extends Resource

class_name Item

enum Rarity {
    COMMON = 0,
    UNCOMMON = 1,
    RARE = 2,
    EPIC = 3,
    LEGENDARY = 4,
}


@export var name : String = ""
@export var rarity : Rarity = Rarity.COMMON
@export var type : PlayerData.ItemType = PlayerData.ItemType.ALL
@export var description : String = ""
@export var icon_form_resource : bool = false:
    set(value):
        if value and resource != null and resource.texture != null:
            icon = resource.texture
        else:
            icon = null
        icon_form_resource = value


@export var icon : Texture = null
@export var price : int = 0

@export var resource : Resource = null
@export var item_scene : PackedScene = null
var resell_percentage : float = 0.7

func get_resell_price() -> int:
    return int(price * resell_percentage)

func get_weight() -> float:
    return GameData.weight_rarity[rarity]