extends Polygon2D

var collision = CollisionPolygon2D.new()

func _ready():
	add_child(collision)
	collision.set_polygon(self.polygon)
