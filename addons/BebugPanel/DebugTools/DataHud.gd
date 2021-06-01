extends MarginContainer

var root: TreeItem

var _monitor_dict := {}

onready var _fader := $Fader
onready var _tree := $Panel/Tree


func _ready() -> void:
	set_process(false)
	root = _tree.create_item()
	_tree.set_hide_root(true)


func _process(_delta: float) -> void:
	for key in _monitor_dict:
		if key:
			var data = key[0].get(key[1])
			if data is Node:
				data = data.name
			_monitor_dict[key].set_text(1, str(data))


func add_monitor(node, property) -> void:
	_monitor_dict[[node, property]] = create_tree_property(node, property)

	# This is important to let the node be deleted without a crash
	var node_already_bound = false
	for binding in node.get_signal_connection_list("tree_exiting"):
		if binding.source == node:
			node_already_bound = true
	if not node_already_bound:
		node.connect("tree_exiting", self, "remove_node", [node])

	if _monitor_dict.keys():
		set_process(true)
		_fader.fade_in()


func remove_node(node) -> void:
	node.disconnect("tree_exiting", self, "remove_monitor")
	for key in _monitor_dict:
		if key[0] == node:
			remove_monitor(node, key[1])


func remove_monitor(node, property) -> void:
#	node.disconnect("tree_exiting", self, "remove_monitor")
	if _monitor_dict.has([node, property]):
		var pair = _monitor_dict[[node, property]]
		var parent = pair.get_parent()
		pair.free()
		if parent.get_children() == null:
			parent.free()
		var _erase_result = _monitor_dict.erase([node, property])
	if not _monitor_dict.keys():
		set_process(false)
		_fader.fade_out()


func create_tree_property(node, property) -> TreeItem:
	var parent = create_tree_node(node)
	var child = parent.get_children()
	while child:
		if child.get_text(0) == property:
			return child
		child = child.get_next()
	child = _tree.create_item(parent)
	child.set_text(0, property)
	return child


func create_tree_node(node) -> TreeItem:
	var child = root.get_children()
	while child:
		if child.get_text(0) == node.name:
			return child
		child = child.get_next()
	child = _tree.create_item(root)
	child.set_text(0, node.name)
	return child

#func _on_Observer_reset() -> void:
#	for key in _monitor_dict:
#		remove_monitor(key.front(), key.back())
#	_monitor_dict = {}
